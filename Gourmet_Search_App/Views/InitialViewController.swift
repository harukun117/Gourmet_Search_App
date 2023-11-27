//
//  InitialViewController.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/28.
//

import UIKit
import Foundation

class InitialViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        performDelayedSegue()
    }

    // 画面遷移を行う非同期関数
    func performDelayedSegue() {
        Task {
            try await Task.sleep(nanoseconds: UInt64(1 * NSEC_PER_SEC))
            DispatchQueue.main.async {
                if let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "initial") as? InitialNavigationViewController {
                    destinationVC.modalPresentationStyle = .fullScreen
                    self.present(destinationVC, animated: true, completion: nil)
                }
            }
        }
    }
}
