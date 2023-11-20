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
    let id: String?
    let name: String?
    let logo_image: String?
    let name_kana: String?
    let address: String?
    let station_name: String?
    let ktai_coupon: Int?
    let large_service_area: LargeServiceArea?
    let service_area: ServiceArea?
    let large_area: LargeArea?
    let middle_area: MiddleArea?
    let small_area: SmallArea?
    let lat: Double?
    let lng: Double?
    let genre: Genre?
    let sub_genre: SubGenre?
    let budget: Budget?
    let budget_memo: String?
    let catchPhrase: String?
    let capacity: Int?
    let access: String?
    let mobile_access: String?
    let urls: Urls?
    let photo: Photo?
    let open: String?
    let close: String?
    let party_capacity: Any?
    let wifi: String?
    let wedding: String?
    let course: String?
    let free_drink: String?
    let free_food: String?
    let private_room: String?
    let horigotatsu: String?
    let tatami: String?
    let card: String?
    let non_smoking: String?
    let charter: String?
    let ktai: String?
    let parking: String?
    let barrier_free: String?
    let other_memo: String?
    let sommelier: String?
    let open_air: String?
    let show: String?
    let equipment: String?
    let karaoke: String?
    let band: String?
    let tv: String?
    let english: String?
    let pet: String?
    let child: String?
    let lunch: String?
    let midnight: String?
    let shop_detail_memo: String?
    let coupon_urls: CouponUrls?

    private enum CodingKeys: String, CodingKey {
        case id, name, logo_image, name_kana, address, station_name, ktai_coupon, large_service_area, service_area, large_area, middle_area, small_area, lat, lng, genre, sub_genre, budget, budget_memo, capacity, access, mobile_access, urls, photo, open, close, wifi, wedding, course, free_drink, free_food, private_room, horigotatsu, tatami, card, non_smoking, charter, ktai, parking, barrier_free, other_memo, sommelier, open_air, show, equipment, karaoke, band, tv, english, pet, child, lunch, midnight, shop_detail_memo, coupon_urls
        // "catch" キーに対応するプロパティ名のエスケープ
        case party_capacity = "party_capacity"
        case catchPhrase = "catch"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let intValue = try? container.decode(Int.self, forKey: .party_capacity) {
            self.party_capacity = intValue
        } else if let stringValue = try? container.decode(String.self, forKey: .party_capacity) {
            self.party_capacity = stringValue
        } else {
            // エラー時のデフォルト値などを設定する
            self.party_capacity = nil
        }

        self.id = try? container.decode(String.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.logo_image = try? container.decode(String.self, forKey: .logo_image)
        self.name_kana = try? container.decode(String.self, forKey: .name_kana)
        self.address = try? container.decode(String.self, forKey: .address)
        self.station_name = try? container.decode(String.self, forKey: .station_name)
        self.ktai_coupon = try? container.decode(Int.self, forKey: .ktai_coupon)
        self.large_service_area = try? container.decode(LargeServiceArea.self, forKey: .large_service_area)
        self.service_area = try? container.decode(ServiceArea.self, forKey: .service_area)
        self.large_area = try? container.decode(LargeArea.self, forKey: .large_area)
        self.middle_area = try? container.decode(MiddleArea.self, forKey: .middle_area)
        self.small_area = try? container.decode(SmallArea.self, forKey: .small_area)
        self.lat = try? container.decode(Double.self, forKey: .lat)
        self.lng = try? container.decode(Double.self, forKey: .lng)
        self.genre = try? container.decode(Genre.self, forKey: .genre)
        self.sub_genre = try? container.decode(SubGenre.self, forKey: .sub_genre)
        self.budget = try? container.decode(Budget.self, forKey: .budget)
        self.budget_memo = try? container.decode(String.self, forKey: .budget_memo)
        self.capacity = try? container.decode(Int.self, forKey: .capacity)
        self.access = try? container.decode(String.self, forKey: .access)
        self.mobile_access = try? container.decode(String.self, forKey: .mobile_access)
        self.urls = try? container.decode(Urls.self, forKey: .urls)
        self.photo = try? container.decode(Photo.self, forKey: .photo)
        self.open = try? container.decode(String.self, forKey: .open)
        self.close = try? container.decode(String.self, forKey: .close)
        self.wifi = try? container.decode(String.self, forKey: .wifi)
        self.wedding = try? container.decode(String.self, forKey: .wedding)
        self.course = try? container.decode(String.self, forKey: .course)
        self.free_drink = try? container.decode(String.self, forKey: .free_drink)
        self.free_food = try? container.decode(String.self, forKey: .free_food)
        self.private_room = try? container.decode(String.self, forKey: .private_room)
        self.horigotatsu = try? container.decode(String.self, forKey: .horigotatsu)
        self.tatami = try? container.decode(String.self, forKey: .tatami)
        self.card = try? container.decode(String.self, forKey: .card)
        self.non_smoking = try? container.decode(String.self, forKey: .non_smoking)
        self.charter = try? container.decode(String.self, forKey: .charter)
        self.ktai = try? container.decode(String.self, forKey: .ktai)
        self.parking = try? container.decode(String.self, forKey: .parking)
        self.barrier_free = try? container.decode(String.self, forKey: .barrier_free)
        self.other_memo = try? container.decode(String.self, forKey: .other_memo)
        self.sommelier = try? container.decode(String.self, forKey: .sommelier)
        self.open_air = try? container.decode(String.self, forKey: .open_air)
        self.show = try? container.decode(String.self, forKey: .show)
        self.equipment = try? container.decode(String.self, forKey: .equipment)
        self.karaoke = try? container.decode(String.self, forKey: .karaoke)
        self.band = try? container.decode(String.self, forKey: .band)
        self.tv = try? container.decode(String.self, forKey: .tv)
        self.english = try? container.decode(String.self, forKey: .english)
        self.pet = try? container.decode(String.self, forKey: .pet)
        self.child = try? container.decode(String.self, forKey: .child)
        self.lunch = try? container.decode(String.self, forKey: .lunch)
        self.midnight = try? container.decode(String.self, forKey: .midnight)
        self.shop_detail_memo = try? container.decode(String.self, forKey: .shop_detail_memo)
        self.coupon_urls = try? container.decode(CouponUrls.self, forKey: .coupon_urls)
        self.catchPhrase = try? container.decode(String.self, forKey: .catchPhrase)
    }

}

struct LargeServiceArea: Decodable {
    let code: String?
    let name: String?
}

struct ServiceArea: Decodable {
    let code: String?
    let name: String?
}

struct LargeArea: Decodable {
    let code: String?
    let name: String?
}

struct MiddleArea: Decodable {
    let code: String?
    let name: String?
}

struct SmallArea: Decodable {
    let code: String?
    let name: String?
}

struct Genre: Decodable {
    let name: String?
    let catchPhrase: String?
    let code: String?

    private enum CodingKeys: String, CodingKey {
        case name, code
        case catchPhrase = "catch"
    }
}

struct SubGenre: Decodable {
    let name: String?
    let code: String?
}

struct Budget: Decodable {
    let code: String?
    let name: String?
    let average: String?
}

struct Urls: Decodable {
    let pc: String?
}

struct Photo: Decodable {
    let pc: PhotoSizes?
    let mobile: MobilePhotoSizes?
}

struct PhotoSizes: Decodable {
    let l: String?
    let m: String?
    let s: String?
}

struct MobilePhotoSizes: Decodable {
    let l: String?
    let s: String?
}

struct CouponUrls: Decodable {
    let pc: String?
    let sp: String?
}
