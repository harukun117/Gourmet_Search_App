//
//  ResultStoreListViewController.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/21.
//

import UIKit
import Combine

class ResultStoreListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var searchStoreViewModel: SearchStoreViewModel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finalButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var pageInformation: UILabel!
    @IBOutlet weak var allPageValue: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchStoreViewModel = SearchStoreViewModel.shared

        tableView.register(UINib(nibName: "ResultStoreListTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")

        searchStoreViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.activityIndicatorView.startAnimating()
                case .list, .nolist, .error:
                    self?.activityIndicatorView.stopAnimating()
                    self?.tableView.reloadData()

                    guard let numberOfSections = self?.tableView.numberOfSections else {
                        return
                    }
                    guard let numberOfRows = self?.tableView.numberOfRows(inSection: 0) else {
                        return
                    }
                    if numberOfSections > 0 && numberOfRows > 0 {
                        let indexPath = IndexPath(row: 0, section: 0)
                        self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }

                    guard let searchStoreViewModel = self?.searchStoreViewModel else {
                        return
                    }
                    self?.pageInformation.text = "\(searchStoreViewModel.start / 20 + 1)ページ目 (\(searchStoreViewModel.available)件 \(searchStoreViewModel.start)-\(searchStoreViewModel.start + searchStoreViewModel.storeContents.count - 1)件)"
                    self?.allPageValue.text = "全\(searchStoreViewModel.available / 20 + 1)ページ"
                default:
                    break
                }
            }
            .store(in: &cancellables)

        searchStoreViewModel.$start
            .sink { start in
                if start == 1 {
                    self.firstButton.isEnabled = false
                    self.previousButton.isEnabled = false
                    self.nextButton.isEnabled = true
                    self.finalButton.isEnabled = true
                } else if start >= self.searchStoreViewModel.available - self.searchStoreViewModel.available % 20 {
                    self.firstButton.isEnabled = true
                    self.previousButton.isEnabled = true
                    self.nextButton.isEnabled = false
                    self.finalButton.isEnabled = false
                } else {
                    self.firstButton.isEnabled = true
                    self.previousButton.isEnabled = true
                    self.nextButton.isEnabled = true
                    self.finalButton.isEnabled = true
                }
            }
            .store(in: &cancellables)
    }

    @IBAction func tapButton(_ sender: UIButton) {
        searchStoreViewModel.selectNextPage(sender: sender.tag)
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
                navigationController.popToViewController(nextViewController, animated: true)
            } else {
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                navigationController.pushViewController(nextViewController, animated: true)
            }
        }
    }
}
