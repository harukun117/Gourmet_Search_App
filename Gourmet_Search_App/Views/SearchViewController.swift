//
//  ViewController.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/18.
//

import UIKit
import Combine
import CoreLocation

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate {

    @IBOutlet var searchBar: UISearchBar!

    @IBOutlet weak var rangePickerView: UIPickerView!
    @IBOutlet weak var budgetPickerView: UIPickerView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
    let locationManager = CLLocationManager()
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

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        searchStoreViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.activityIndicator.startAnimating()
                case .list, .nolist:
                    self?.activityIndicator.stopAnimating()
                    if let navigationController = self?.navigationController {
                        if let nextViewController = navigationController.viewControllers.first(where: { $0 is ResultStoreListViewController }) as? ResultStoreListViewController {
                            navigationController.popToViewController(nextViewController, animated: true)
                        } else {
                            let nextViewController = self?.storyboard?.instantiateViewController(withIdentifier: "result") as! ResultStoreListViewController
                            navigationController.pushViewController(nextViewController, animated: true)
                        }
                    }
                case .error:
                    self?.activityIndicator.stopAnimating()
                    guard let errorAlert = self?.searchStoreViewModel.errorAlert else {
                        return
                    }
                    let alertController = UIAlertController(title: errorAlert.title, message: errorAlert.message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "戻る", style: .default) { _ in
                    }
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    @IBAction func tapButton(_ sender: UIButton) {
        let customColor = UIColor(red: 255/255, green: 249/255, blue: 218/255, alpha: 1.0)
        switch sender.tag {
        case 0:
            if searchStoreViewModel.genres[0] == nil {
                searchStoreViewModel.genres[0] = "G001"
                izakaya.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[0] = nil
                izakaya.backgroundColor = customColor
            }
        case 1:
            if searchStoreViewModel.genres[1] == nil {
                searchStoreViewModel.genres[1] = "G002"
                diningBar.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[1] = nil
                diningBar.backgroundColor = customColor
            }
        case 2:
            if searchStoreViewModel.genres[2] == nil {
                searchStoreViewModel.genres[2] = "G003"
                creativeCuisine.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[2] = nil
                creativeCuisine.backgroundColor = customColor
            }
        case 3:
            if searchStoreViewModel.genres[3] == nil {
                searchStoreViewModel.genres[3] = "G004"
                japaneseFood.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[3] = nil
                japaneseFood.backgroundColor = customColor
            }
        case 4:
            if searchStoreViewModel.genres[4] == nil {
                searchStoreViewModel.genres[4] = "G005"
                westernFood.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[4] = nil
                westernFood.backgroundColor = customColor
            }
        case 5:
            if searchStoreViewModel.genres[5] == nil {
                searchStoreViewModel.genres[5] = "G006"
                italianFrench.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[5] = nil
                italianFrench.backgroundColor = customColor
            }
        case 6:
            if searchStoreViewModel.genres[6] == nil {
                searchStoreViewModel.genres[6] = "G007"
                chineseFood.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[6] = nil
                chineseFood.backgroundColor = customColor
            }
        case 7:
            if searchStoreViewModel.genres[7] == nil {
                searchStoreViewModel.genres[7] = "G008"
                yakiniku.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[7] = nil
                yakiniku.backgroundColor = customColor
            }
        case 8:
            if searchStoreViewModel.genres[8] == nil {
                searchStoreViewModel.genres[8] = "G017"
                koreanFood.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[8] = nil
                koreanFood.backgroundColor = customColor
            }
        case 9:
            if searchStoreViewModel.genres[9] == nil {
                searchStoreViewModel.genres[9] = "G009"
                asianFood.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[9] = nil
                asianFood.backgroundColor = customColor
            }
        case 10:
            if searchStoreViewModel.genres[10] == nil {
                searchStoreViewModel.genres[10] = "G010"
                eachCountryFood.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[10] = nil
                eachCountryFood.backgroundColor = customColor
            }
        case 11:
            if searchStoreViewModel.genres[11] == nil {
                searchStoreViewModel.genres[11] = "G011"
                karaoke.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[11] = nil
                karaoke.backgroundColor = customColor
            }
        case 12:
            if searchStoreViewModel.genres[12] == nil {
                searchStoreViewModel.genres[12] = "G012"
                bar.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[12] = nil
                bar.backgroundColor = customColor
            }
        case 13:
            if searchStoreViewModel.genres[13] == nil {
                searchStoreViewModel.genres[13] = "G013"
                ramen.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[13] = nil
                ramen.backgroundColor = customColor
            }
        case 14:
            if searchStoreViewModel.genres[14] == nil {
                searchStoreViewModel.genres[14] = "G016"
                okonomi.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[14] = nil
                okonomi.backgroundColor = customColor
            }
        case 15:
            if searchStoreViewModel.genres[15] == nil {
                searchStoreViewModel.genres[15] = "G014"
                cafe.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[15] = nil
                cafe.backgroundColor = customColor
            }
        case 16:
            if searchStoreViewModel.genres[16] == nil {
                searchStoreViewModel.genres[16] = "G015"
                other.backgroundColor = UIColor.systemYellow
            } else {
                searchStoreViewModel.genres[16] = nil
                other.backgroundColor = customColor
            }
        default:
            break
        }
    }

    @IBAction func search(_ sender: Any) {
        searchStoreViewModel.storeListResponse = nil
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            let alertController = UIAlertController(title: "エラー", message: "位置情報の取得に失敗しました。端末の設定をご確認ください。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "戻る", style: .default) { _ in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchStoreViewModel.setKeyword(keyword: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
        if pickerView == rangePickerView {
            searchStoreViewModel.selectRange(index: row)
        }

        if pickerView == budgetPickerView {
            searchStoreViewModel.selectBudget(index: row)
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            searchStoreViewModel.lat = latitude
            searchStoreViewModel.lng = longitude
            searchStoreViewModel.start = 1
            searchStoreViewModel.getStore()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

