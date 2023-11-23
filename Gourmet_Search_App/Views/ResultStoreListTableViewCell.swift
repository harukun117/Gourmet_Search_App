//
//  ResultStoreListTableViewCell.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/21.
//

import UIKit

class ResultStoreListTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var access: UILabel!
    @IBOutlet weak var budget: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func create(img: String, name: String, access: String, budget: String) {
        Task {
            do {
                self.img.image = try await setImageViewImage(from: img)
            } catch {
                self.img.image = UIImage(systemName: "nosign")
            }
        }
        self.name.text = name
        self.access.text = "アクセス：" + access
        self.budget.text = "平均予算" + budget
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
}
