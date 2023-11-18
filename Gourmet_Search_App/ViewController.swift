//
//  ViewController.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/18.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
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

    var genres = [String?](repeating: nil, count: 17)

    var rangePickerSelectedIndex: Int = 0
    var budgetPickerSelectedIndex: Int = 0

    var searchStoreViewModel: SearchStoreViewModel = SearchStoreViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rangePickerView.dataSource = self
        budgetPickerView.dataSource = self

        rangePickerView.delegate = self
        budgetPickerView.delegate = self
    }

    @IBAction func tapButton(_ sender: UIButton) {
        switch sender.tag {
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
            rangePickerSelectedIndex = row
        }

        if pickerView == budgetPickerView {
            budgetPickerSelectedIndex = row
        }

    }

}

