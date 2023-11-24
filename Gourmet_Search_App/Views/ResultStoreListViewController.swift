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

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
         super.viewDidLoad()
        searchStoreViewModel = SearchStoreViewModel.shared

        tableView.register(UINib(nibName: "ResultStoreListTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchStoreViewModel.storeContents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ResultStoreListTableViewCell

        cell.create(img: searchStoreViewModel.storeContents[indexPath.row].s_photo, name: searchStoreViewModel.storeContents[indexPath.row].name, access: searchStoreViewModel.storeContents[indexPath.row].access, budget: searchStoreViewModel.storeContents[indexPath.row].budget_average)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchStoreViewModel.storeContent = searchStoreViewModel.storeContents[indexPath.row]
        if let navigationController = self.navigationController {
            if let nextViewController = navigationController.viewControllers.first(where: { $0 is DetailViewController }) as? DetailViewController {
                // 既存のResultStoreListViewControllerが存在する場合
                navigationController.popToViewController(nextViewController, animated: true)
            } else {
                // 既存のResultStoreListViewControllerが存在しない場合、新しいインスタンスを生成して画面遷移
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                navigationController.pushViewController(nextViewController, animated: true)
            }
        }
    }
}
