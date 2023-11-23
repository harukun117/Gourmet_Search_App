//
//  ViewController.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/18.
//

import UIKit
import Combine

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!

    @IBOutlet weak var rangePickerView: UIPickerView!
    @IBOutlet weak var budgetPickerView: UIPickerView!

    @IBOutlet var izakaya: UIButton!
    @IBOutlet var diningBar: UIButton!
    @IBOutlet var creativeCuisine: UIButton!
    @IBOutlet var japaneseFood: UIButton!
    @IBOutlet var westernFood: UIButton!
    @IBOutlet var italianFrench: UIButton!
    @IBOutlet var chineseFood: UIButton!
    @IBOutlet var yakiniku: UIButton!
    @IBOutlet var koreanFood: UIButton!
    @IBOutlet var asianFood: UIButton!
    @IBOutlet var eachCountryFood: UIButton!
    @IBOutlet var karaoke: UIButton!
    @IBOutlet var bar: UIButton!
    @IBOutlet var ramen: UIButton!
    @IBOutlet var okonomi: UIButton!
    @IBOutlet var cafe: UIButton!
    @IBOutlet var other: UIButton!
    @IBOutlet var searchButton: UIButton!

    var searchStoreViewModel: SearchStoreViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchStoreViewModel = SearchStoreViewModel.shared
        searchBar.delegate = self
        searchBar.placeholder = "フリーワード　例)新宿 居酒屋"

        rangePickerView.dataSource = self
        budgetPickerView.dataSource = self

        rangePickerView.delegate = self
        budgetPickerView.delegate = self
    }

    @IBAction func tapButton(_ sender: UIButton) {
        searchStoreViewModel.selectGenre(tag: sender.tag)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchStoreViewModel.setKeyword(keyword: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // キーボードを閉じる
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if pickerView == rangePickerView {
            return searchStoreViewModel.rangePickerViewData.count
        }

        if pickerView == budgetPickerView {
            return searchStoreViewModel.budgetPickerViewData.count
        }

        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == rangePickerView {
            return searchStoreViewModel.rangePickerViewData[row]
        }
        if pickerView == budgetPickerView {
            return searchStoreViewModel.budgetPickerViewData[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            // ピッカーで選択した項目の処理
        if pickerView == rangePickerView {
            searchStoreViewModel.selectRange(index: row)
        }

        if pickerView == budgetPickerView {
            searchStoreViewModel.selectBudget(index: row)
        }

    }

    @IBAction func search(_ sender: Any) {
        searchStoreViewModel.storeListResponse = nil
        searchStoreViewModel.getStore()
        searchStoreViewModel.$storeListResponse
            .compactMap {$0}
            .sink { [weak self] _ in
                if let navigationController = self?.navigationController {
                    if let nextViewController = navigationController.viewControllers.first(where: { $0 is ResultStoreListViewController }) as? ResultStoreListViewController {
                        // 既存のResultStoreListViewControllerが存在する場合
                        navigationController.popToViewController(nextViewController, animated: true)
                    } else {
                        // 既存のResultStoreListViewControllerが存在しない場合、新しいインスタンスを生成して画面遷移
                        let nextViewController = self?.storyboard?.instantiateViewController(withIdentifier: "result") as! ResultStoreListViewController
                        navigationController.pushViewController(nextViewController, animated: true)
                    }
                }
            }
            .store(in: &cancellables)
    }


}
