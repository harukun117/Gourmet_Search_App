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
                case .list, .nolist, .error:
                    self?.activityIndicator.stopAnimating()
                    if let navigationController = self?.navigationController {
                        if let nextViewController = navigationController.viewControllers.first(where: { $0 is ResultStoreListViewController }) as? ResultStoreListViewController {
                            navigationController.popToViewController(nextViewController, animated: true)
                        } else {
                            let nextViewController = self?.storyboard?.instantiateViewController(withIdentifier: "result") as! ResultStoreListViewController
                            navigationController.pushViewController(nextViewController, animated: true)
                        }
                    }
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    @IBAction func tapButton(_ sender: UIButton) {
        searchStoreViewModel.selectGenre(tag: sender.tag)
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

