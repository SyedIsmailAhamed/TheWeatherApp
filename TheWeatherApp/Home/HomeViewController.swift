//
//  HomeViewController.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import UIKit
import Messages

class HomeViewController: UIViewController {

    var viewModel : HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = HomeViewModel()
        viewModel?.fetchWeatherData(completionHandler: {[weak self] (status) in
            guard let self = self,
                  let weatherModel = self.viewModel?.weatherModel else {return}
            if status{
                
            }
        })

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
