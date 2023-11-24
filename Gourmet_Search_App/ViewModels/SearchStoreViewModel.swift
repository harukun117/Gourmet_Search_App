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
    @Published var storeListResponse: StoreListResponse?
    var storeContents: [StoreContent] = []
    var storeContent: StoreContent?
    let rangePickerViewData: [String] = ["300m以内", "500m以内", "1000m以内", "2000m以内", "3000m以内"]
    let budgetPickerViewData: [String] = ["指定なし", "~500円", "501円~1000円", "1001円~1500円", "1501円~2000円", "2001円~3000円", "3001円~4000円", "4001円~5000円", "5001円~7000円", "7001円~10000円", "10001円~15000円", "15001円~20000円", "20001円~30000円", "30001円~"]
    var genres = [String?](repeating: nil, count: 17)
    var searchText: String? = nil
    var rangeCode: String = "1"
    var budgetCode: String? = nil


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

    func selectGenre(tag: Int) {
        switch tag {
        case 0:
            if genres[0] == nil {
                genres[0] = "G001"
            } else {
                genres[0] = nil
            }
        case 1:
            if genres[1] == nil {
                genres[1] = "G002"
            } else {
                genres[1] = nil
            }
        case 2:
            if genres[2] == nil {
                genres[2] = "G003"
            } else {
                genres[2] = nil
            }
        case 3:
            if genres[3] == nil {
                genres[3] = "G004"
            } else {
                genres[3] = nil
            }
        case 4:
            if genres[4] == nil {
                genres[4] = "G005"
            } else {
                genres[4] = nil
            }
        case 5:
            if genres[5] == nil {
                genres[5] = "G006"
            } else {
                genres[5] = nil
            }
        case 6:
            if genres[6] == nil {
                genres[6] = "G007"
            } else {
                genres[6] = nil
            }
        case 7:
            if genres[7] == nil {
                genres[7] = "G008"
            } else {
                genres[7] = nil
            }
        case 8:
            if genres[8] == nil {
                genres[8] = "G017"
            } else {
                genres[8] = nil
            }
        case 9:
            if genres[9] == nil {
                genres[9] = "G009"
            } else {
                genres[9] = nil
            }
        case 10:
            if genres[10] == nil {
                genres[10] = "G010"
            } else {
                genres[10] = nil
            }
        case 11:
            if genres[11] == nil {
                genres[11] = "G011"
            } else {
                genres[11] = nil
            }
        case 12:
            if genres[12] == nil {
                genres[12] = "G012"
            } else {
                genres[12] = nil
            }
        case 13:
            if genres[13] == nil {
                genres[13] = "G013"
            } else {
                genres[13] = nil
            }
        case 14:
            if genres[14] == nil {
                genres[14] = "G016"
            } else {
                genres[14] = nil
            }
        case 15:
            if genres[15] == nil {
                genres[15] = "G014"
            } else {
                genres[15] = nil
            }
        case 16:
            if genres[16] == nil {
                genres[16] = "G015"
            } else {
                genres[16] = nil
            }
        default:
            break
        }
    }

    func getStore() {
        Task {
            let getStoreListResult = await getStoreList.getStoreList(keyword: searchText, lat: 35.669220, lng: 139.761457, rangeCode: rangeCode, genres: genres, budget: budgetCode)
            switch getStoreListResult {
            case .success(let response):
                print(response)
                storeListResponse = response
                setStoreContents()
            case .failure(let apiError):
                print(apiError)
            }
        }
    }

    private func setStoreContents() {
        guard let storeListResponse = storeListResponse?.results.shop else {
            return
        }
        storeContents = storeListResponse.map { shop in
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



