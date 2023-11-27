//
//  DetailViewController.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    var searchStoreViewModel: SearchStoreViewModel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre_catch: UILabel!
    @IBOutlet weak var catchPhrase: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var access: UILabel!
    @IBOutlet weak var openTime: UILabel!
    @IBOutlet weak var budget_avg: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var private_room: UILabel!
    @IBOutlet weak var pet: UILabel!
    @IBOutlet weak var wifi: UILabel!
    @IBOutlet weak var parking: UILabel!
    @IBOutlet weak var card: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var free_food: UILabel!
    @IBOutlet weak var free_drink: UILabel!

    @IBOutlet weak var coupon: UIButton!
    @IBOutlet weak var url: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchStoreViewModel = SearchStoreViewModel.shared
        if let content = searchStoreViewModel.storeContent {
            Task {
                do {
                    self.img.image = try await setImageViewImage(from: content.l_photo)
                } catch {
                    self.img.image = UIImage(systemName: "nosign")
                }
            }
            self.name.text = content.name
            self.genre_catch.text = content.genre_catch
            self.catchPhrase.text = content.catchPhrase
            self.address.text = content.address
            self.access.text = content.access
            self.openTime.text = content.open
            self.budget_avg.text = content.budget_average
            self.url.setTitle(content.url, for: .normal)
            if let capa = content.capacity {
                self.capacity.text = String(capa)
            } else {
                self.capacity.text = ""
            }
            self.private_room.text = content.private_room
            self.coupon.setTitle(content.coupon_url, for: .normal)
            self.pet.text = content.pet
            self.wifi.text = content.wifi
            self.parking.text = content.parking
            self.card.text = content.card
            self.course.text = content.course
            self.free_drink.text = content.free_drink
            self.free_food.text = content.free_food


        }

    }

    private func loadImage(from urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }

    private func setImageViewImage(from urlString: String) async throws -> UIImage {
        do {
            let image = try await loadImage(from: urlString)
            if let image = image {
                return image
            } else {
                return UIImage(systemName: "nosign")!
            }
        } catch {
            return UIImage(systemName: "nosign")!
        }
    }

    @IBAction func openURLTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            guard let url = URL(string: url.currentTitle!) else { return }
            UIApplication.shared.open(url)
        case 1:
            guard let coupon = URL(string: coupon.currentTitle!) else { return }
            UIApplication.shared.open(coupon)
        default:
            break
        }
    }

}
