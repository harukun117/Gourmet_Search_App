//
//  GetStoreList.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/18.
//

import Foundation

struct GetStoreList {
    let baseURL = URL(string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=6ba99736091e59ed&id=J001280392&format=json")!

    func getStoreList(keyword: String? = nil, lat: Double, lng: Double, rangeCode: String, genres: [String?]) async -> Result<StoreListResponse, APIClientError> {


        var urlComponents = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: true
        )

        let selectedGenre = genres.contains{$0 != nil}
        var genreQuery = ""
        if selectedGenre {
            for genre in genres {
                if let unwrappedGenre = genre {
                    genreQuery += unwrappedGenre + ","
                }
            }
            genreQuery.removeLast()
        }

        urlComponents?.queryItems = [
            URLQueryItem(name: "keyword", value: keyword),
            URLQueryItem(name: "lat", value: String(format: "%.6f", lat)),
            URLQueryItem(name: "lng", value: String(format: "%.6f", lng)),
            URLQueryItem(name: "range", value: rangeCode),
            URLQueryItem(name: "genre", value: genreQuery)
        ]

        guard let url = urlComponents?.url else {
            return .failure(.invalidURL)
        }

        //URL Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        //API通信
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpURLResponse = response as? HTTPURLResponse else {
                preconditionFailure()
            }

            switch httpURLResponse.statusCode {
            case 200:
                do {
                    let storeListResponse: StoreListResponse = try parseResponse(from: data)
                    return .success(storeListResponse)
                } catch {
                    return .failure(.parseError)
                }
            case 1000:
                return .failure(.apiResponseError(.serverError))
            case 2000:
                return .failure(.apiResponseError(.APICertificationError))
            case 3000:
                return .failure(.apiResponseError(.InValidParameterError))
            default:
                return .failure(.apiResponseError(.undefined(statusCode: httpURLResponse.statusCode)))
            }
        } catch let error as NSError where error.domain == NSURLErrorDomain {
            return .failure(.urlSessionError(.networkError))
        } catch {
            return .failure(.urlSessionError(.unknown(error)))
        }
    }

    func parseResponse<Response: Decodable>(from data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
