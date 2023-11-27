//
//  ErrorAlert.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/27.
//

import Foundation

enum ErrorAlert {
    case invalidURL
    case parseError
    case serverError
    case APICertificationError
    case InValidParameterError
    case undefined(statusCode: Int?)
    case networkError
    case unknown(message: String)

    init(_ apiClientError: APIClientError) {
        switch apiClientError {
        case .invalidURL:
            self = .invalidURL
        case .parseError:
            self = .parseError
        case .apiResponseError(let apiResponseError):
            switch apiResponseError {
            case .serverError:
                self = .serverError
            case .APICertificationError:
                self = .APICertificationError
            case .InValidParameterError:
                self = .InValidParameterError
            case .undefined(let statusCode):
                self = .undefined(statusCode: statusCode)
            }
        case .urlSessionError(let urlSessionError):
            switch urlSessionError {
            case .networkError:
                self = .networkError
            case .unknown(let error):
                self = .unknown(message: error.localizedDescription)
            }
        }
    }
}

extension ErrorAlert {
    var title: String {
        switch self {
        case .invalidURL:
            return "URLが無効です"
        case .parseError:
            return "パースエラー"
        case .serverError:
            return "サーバーエラー"
        case .APICertificationError:
            return "認証エラー"
        case .InValidParameterError:
            return "パラメータ不正エラー"
        case .undefined:
            return "予期せぬエラー"
        case .networkError:
            return"ネットワークエラー"
        case .unknown:
            return "予期せぬエラー"
        }
    }

    var message: String {
        switch self {
        case .invalidURL:
            return ""
        case .parseError:
            return ""
        case .serverError:
            return "しばらくしてから再試行してください"
        case .APICertificationError:
            return ""
        case .InValidParameterError:
            return ""
        case .undefined(let statusCode):
            return "ステータスコード\(String(describing: statusCode))"
        case .networkError:
            return"通信環境のよいところで再試行してください"
        case .unknown(let message):
            return message
        }
    }
}

