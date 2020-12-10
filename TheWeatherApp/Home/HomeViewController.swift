//
//  HomeViewController.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import UIKit
import Messages

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Commons.showActivityIndicator()
        HomeService.getWeatherData { (sender: RequestCallback<HomeWeather>) in
            Commons.hideActivityIndicator()
            switch sender {
            case .success(let object):
                print("current temp is \(object.current?.temp?.toFahrenheit())")
            case .failed(let error):
                switch error {
                case .gernalError(let message):
                    Messages.showMessage(message: message, theme: .error)
                default:
                    Messages.showMessage(message: error.localizedDescription, theme: .error)
                }
            }
        }
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
