//
//  ResultStoreListViewController.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/21.
//

import UIKit

class ResultStoreListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var searchStoreViewModel: SearchStoreViewModel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
         super.viewDidLoad()
        searchStoreViewModel = SearchStoreViewModel.shared
        tableView.register(UINib(nibName: "ResultStoreListTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let storeListResponse = searchStoreViewModel.storeListResponse else {
            print("a")
            return 0
        }
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ResultStoreListTableViewCell
        cell.img.image = UIImage(systemName: "swift")
        cell.name.text = "name"
        cell.access.text = "access"
        cell.budget.text = "budget"
        return cell
    }
}
