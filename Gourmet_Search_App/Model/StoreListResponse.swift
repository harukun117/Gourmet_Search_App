//
//  StoreListResponse.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/18.
//

import Foundation

struct StoreListResponse: Decodable {
    let results: Results
}

struct Results: Decodable {
    let api_version: String
    let results_available: Int
    let results_returned: String
    let results_start: Int
    let shop: [Shop]
}

struct Shop: Decodable {
    let id: String
    let name: String
    let logo_image: String
    let name_kana: String
    let address: String
    let station_name: String
    let ktai_coupon: Int
    let large_service_area: ServiceArea
    let service_area: ServiceArea
    let large_area: Area
    let middle_area: Area
    let small_area: Area
    let lat: Double
    let lng: Double
    let genre: Genre
    let sub_genre: SubGenre
    let budget: Budget
    let catchPhrase: String
    let capacity: Int
    let access: String
    let mobile_access: String
    let urls: Urls
    let photo: Photo
    let open: String
    let close: String
    let party_capacity: Int
    let other_memo: String
    let shop_detail_memo: String
    let budget_memo: String
    let wedding: String
    let course: String
    let free_drink: String
    let free_food: String
    let private_room: String
    let horigotatsu: String
    let tatami: String
    let card: String
    let non_smoking: String
    let charter: String
    let ktai: String
    let parking: String
    let barrier_free: String
    let sommelier: String
    let open_air: String
    let show: String
    let equipment: String
    let karaoke: String
    let band: String
    let tv: String
    let lunch: String
    let midnight: String
    let english: String
    let pet: String
    let child: String
    let wifi: String
    let coupon_urls: CouponUrls
}

struct ServiceArea: Decodable {
    let code: String
    let name: String
}

struct Area: Decodable {
    let code: String
    let name: String
}

struct Genre: Decodable {
    let name: String
    let catchPhrase: String
    let code: String
}

struct SubGenre: Decodable {
    let name: String
    let code: String
}

struct Budget: Decodable {
    let code: String
    let name: String
    let average: String
}

struct Urls: Decodable {
    let pc: String
}

struct Photo: Decodable {
    let pc: PhotoSizes
    let mobile: MobilePhotoSizes
}

struct PhotoSizes: Decodable {
    let l: String
    let m: String
    let s: String
}

struct MobilePhotoSizes: Decodable {
    let l: String
    let s: String
}

struct CouponUrls: Decodable {
    let pc: String
    let sp: String
}
