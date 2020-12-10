//
//  HomeViewController.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import UIKit
import Messages
import CoreLocation

class HomeViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    var viewModel : HomeViewModel?
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupTableView()

    }
    func setupTableView(){
        tblView.estimatedSectionHeaderHeight = 300
        let headerNib = UINib.init(nibName: "HomeHeaderView", bundle: Bundle.main)
        tblView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HomeHeaderView")
    }

    func fetchData(){
        guard let location = currentLocation,
              CLLocationCoordinate2DIsValid(location.coordinate)
        else { return  }
        viewModel = HomeViewModel()
        viewModel?.fetchWeatherData(location: location, completionHandler: {[weak self] (status) in
            guard let self = self else {return}
            if status{
                self.tblView.reloadData()
            }
        })
    }
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.startUpdatingLocation()

    }

}

extension HomeViewController : CLLocationManagerDelegate{

    // Below method will provide you current location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocation == nil {
            currentLocation = locations.last
            Commons.currentLocation = currentLocation
            fetchData()

            //            locationManager?.stopMonitoringSignificantLocationChanges()
            //            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
            //
            //            print("locations = \(locationValue)")
            //
            //            locationManager?.stopUpdatingLocation()
        }
    }

    // Below Mehtod will print error if not able to update location.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
}

extension HomeViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeHeaderView") as! HomeHeaderView
        if let currentModel = viewModel?.weatherModel{
            headerView.loadData(weatherModel: currentModel)
        }
        return headerView
    }
}

extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        return cell!
    }


}
