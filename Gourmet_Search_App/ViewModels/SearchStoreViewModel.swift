//
//  SearchStoreViewModel.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/18.
//

import Foundation

@MainActor
final class SearchStoreViewModel {

    static let shared = SearchStoreViewModel()
    private let getStoreList = GetStoreList()
    var storeListResponse: StoreListResponse?
    var storeContents: [StoreContent] = []
    @Published var state: State = .initial
    var storeContent: StoreContent?
    var errorAlert: ErrorAlert?
    var available: Int = 0
    let rangePickerViewData: [String] = ["300m以内", "500m以内", "1000m以内", "2000m以内", "3000m以内"]
    let budgetPickerViewData: [String] = ["指定なし", "~500円", "501円~1000円", "1001円~1500円", "1501円~2000円", "2001円~3000円", "3001円~4000円", "4001円~5000円", "5001円~7000円", "7001円~10000円", "10001円~15000円", "15001円~20000円", "20001円~30000円", "30001円~"]
    var genres = [String?](repeating: nil, count: 17)
    var searchText: String? = nil
    var rangeCode: String = "1"
    var budgetCode: String? = nil
    var lat: Double = 35.669220
    var lng: Double = 139.761457
    @Published var start: Int = 1

    func setKeyword(keyword: String) {
        if keyword.isEmpty {
            searchText = nil
        } else {
            searchText = keyword
        }
    }

    func selectRange(index: Int) {
        rangeCode = String(index+1)
    }

    func selectBudget(index: Int) {
        switch index {
        case 0:
            budgetCode = nil
        case 1:
            budgetCode = "B009"
        case 2:
            budgetCode = "B010"
        case 3:
            budgetCode = "B011"
        case 4:
            budgetCode = "B001"
        case 5:
            budgetCode = "B002"
        case 6:
            budgetCode = "B003"
        case 7:
            budgetCode = "B008"
        case 8:
            budgetCode = "B004"
        case 9:
            budgetCode = "B005"
        case 10:
            budgetCode = "B006"
        case 11:
            budgetCode = "B012"
        case 12:
            budgetCode = "B013"
        case 13:
            budgetCode = "B014"
        default:
            budgetCode = nil
        }
    }

    func selectNextPage(sender: Int) {
        switch sender {
        case 0:
            start = 1
        case 1:
            if start == available - available % 20 {
                start = start - storeContents.count
            } else {
                start = start - 20
            }
        case 2:
            start = start + 20
        case 3:
            start = available - available % 20 + 1
        default:
            break
        }
        getStore()
    }

    func getStore() {
        state = .loading
        Task {
            let getStoreListResult = await getStoreList.getStoreList(keyword: searchText, lat: lat, lng: lng, rangeCode: rangeCode, genres: genres, budget: budgetCode, start: start)
            switch getStoreListResult {
            case .success(let response):
                print(response)
                storeListResponse = response
                setStoreContents()
            case .failure(let apiError):
                state = .error
                errorAlert = ErrorAlert(apiError)
                print(apiError)
            }
        }
    }

    private func setStoreContents() {
        guard let storeListResponse = storeListResponse?.results else {
            return
        }
        available = storeListResponse.results_available
        storeContents = storeListResponse.shop.map { shop in
            return StoreContent(
                id: shop.id ?? "",
                name: shop.name ?? "",
                address: shop.address ?? "",
                station_name: shop.name ?? "",
                genre_catch: shop.genre?.catchPhrase ?? "",
                budget_average: shop.budget?.average ?? "",
                catchPhrase: shop.catchPhrase ?? "",
                capacity: shop.capacity,
                access: shop.access ?? "",
                url: shop.urls?.pc ?? "",
                s_photo: shop.photo?.mobile?.s ?? "",
                l_photo: shop.photo?.mobile?.l ?? "",
                open: shop.open ?? "",
                close: shop.close ?? "",
                course: shop.course ?? "",
                free_drink: shop.free_drink ?? "",
                free_food: shop.free_food ?? "",
                private_room: shop.private_room ?? "",
                card: shop.card ?? "",
                wifi: shop.wifi ?? "",
                parking: shop.parking ?? "",
                pet: shop.pet ?? "",
                coupon_url: shop.coupon_urls?.sp ?? ""
            )

        }
        if storeContents.isEmpty {
            state = .nolist
        } else {
            state = .list
        }
    }
}

struct StoreContent: Identifiable {
    let id: String
    let name: String
    let address: String
    let station_name: String
    let genre_catch: String
    let budget_average: String
    let catchPhrase: String
    let capacity: Int?
    let access: String
    let url: String
    let s_photo: String
    let l_photo: String
    let open: String
    let close: String
    let course: String
    let free_drink: String
    let free_food: String
    let private_room: String
    let card: String
    let wifi: String
    let parking: String
    let pet: String
    let coupon_url: String
}

enum State {
    case initial
    case loading
    case list
    case nolist
    case error
}



