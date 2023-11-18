//
//  ViewController.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/18.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate {

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

    var searchStoreViewModel: SearchStoreViewModel = SearchStoreViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        searchBar.placeholder = "フリーワード　例)新宿 居酒屋"

        rangePickerView.dataSource = self
        budgetPickerView.dataSource = self

        rangePickerView.delegate = self
        budgetPickerView.delegate = self
    }

    @IBAction func tapButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if searchStoreViewModel.genres[0] == nil {
                searchStoreViewModel.genres[0] = "G001"
            } else {
                searchStoreViewModel.genres[0] = nil
            }
        case 1:
            if searchStoreViewModel.genres[1] == nil {
                searchStoreViewModel.genres[1] = "G002"
            } else {
                searchStoreViewModel.genres[1] = nil
            }
        case 2:
            if searchStoreViewModel.genres[2] == nil {
                searchStoreViewModel.genres[2] = "G003"
            } else {
                searchStoreViewModel.genres[2] = nil
            }
        case 3:
            if searchStoreViewModel.genres[3] == nil {
                searchStoreViewModel.genres[3] = "G004"
            } else {
                searchStoreViewModel.genres[3] = nil
            }
        case 4:
            if searchStoreViewModel.genres[4] == nil {
                searchStoreViewModel.genres[4] = "G005"
            } else {
                searchStoreViewModel.genres[4] = nil
            }
        case 5:
            if searchStoreViewModel.genres[5] == nil {
                searchStoreViewModel.genres[5] = "G006"
            } else {
                searchStoreViewModel.genres[5] = nil
            }
        case 6:
            if searchStoreViewModel.genres[6] == nil {
                searchStoreViewModel.genres[6] = "G007"
            } else {
                searchStoreViewModel.genres[6] = nil
            }
        case 7:
            if searchStoreViewModel.genres[7] == nil {
                searchStoreViewModel.genres[7] = "G008"
            } else {
                searchStoreViewModel.genres[7] = nil
            }
        case 8:
            if searchStoreViewModel.genres[8] == nil {
                searchStoreViewModel.genres[8] = "G017"
            } else {
                searchStoreViewModel.genres[8] = nil
            }
        case 9:
            if searchStoreViewModel.genres[9] == nil {
                searchStoreViewModel.genres[9] = "G009"
            } else {
                searchStoreViewModel.genres[9] = nil
            }
        case 10:
            if searchStoreViewModel.genres[10] == nil {
                searchStoreViewModel.genres[10] = "G010"
            } else {
                searchStoreViewModel.genres[10] = nil
            }
        case 11:
            if searchStoreViewModel.genres[11] == nil {
                searchStoreViewModel.genres[11] = "G011"
            } else {
                searchStoreViewModel.genres[11] = nil
            }
        case 12:
            if searchStoreViewModel.genres[12] == nil {
                searchStoreViewModel.genres[12] = "G012"
            } else {
                searchStoreViewModel.genres[12] = nil
            }
        case 13:
            if searchStoreViewModel.genres[13] == nil {
                searchStoreViewModel.genres[13] = "G013"
            } else {
                searchStoreViewModel.genres[13] = nil
            }
        case 14:
            if searchStoreViewModel.genres[14] == nil {
                searchStoreViewModel.genres[14] = "G016"
            } else {
                searchStoreViewModel.genres[14] = nil
            }
        case 15:
            if searchStoreViewModel.genres[15] == nil {
                searchStoreViewModel.genres[15] = "G014"
            } else {
                searchStoreViewModel.genres[15] = nil
            }
        case 16:
            if searchStoreViewModel.genres[16] == nil {
                searchStoreViewModel.genres[16] = "G015"
            } else {
                searchStoreViewModel.genres[16] = nil
            }
        default:
            break
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchStoreViewModel.searchText = searchText
        print(searchText)
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
            searchStoreViewModel.rangePickerSelectedIndex = row
        }

        if pickerView == budgetPickerView {
            searchStoreViewModel.budgetPickerSelectedIndex = row
        }

    }

}

