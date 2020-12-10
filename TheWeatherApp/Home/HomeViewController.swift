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

        //for simulator i simulated dubai's location
        if AppPlatform.isSimulator {
           currentLocation = CLLocation(latitude: 25.2048, longitude: 55.2708)
            fetchData()
        }
    }
    func setupTableView(){
        tblView.estimatedSectionHeaderHeight = 300
        let headerNib = UINib.init(nibName: HomeHeaderView.Identifier, bundle: Bundle.main)

        tblView.register(headerNib, forHeaderFooterViewReuseIdentifier: HomeHeaderView.Identifier)
        let timeNiB = UINib.init(nibName: TimelyDataHeaderView.Identifier, bundle: Bundle.main)

        tblView.register(timeNiB, forHeaderFooterViewReuseIdentifier: TimelyDataHeaderView.Identifier)
        tblView.register(UINib(nibName: DaysTableViewCell.Identifier, bundle: Bundle.main), forCellReuseIdentifier: DaysTableViewCell.Identifier)
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
            locationManager?.stopMonitoringSignificantLocationChanges()
            locationManager?.stopUpdatingLocation()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = .white
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.Identifier) as! HomeHeaderView
            if let currentModel = viewModel?.weatherModel {
                headerView.loadData(weatherModel: currentModel)
            }
            headerView.didSelectUnitsButton = {[weak self]status in
                guard let self = self else { return  }
                self.showOptions()
            }
            headerView.backgroundColor = .white
            return headerView
        }
        else{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TimelyDataHeaderView.Identifier) as! TimelyDataHeaderView
            if let currentModel = viewModel?.weatherModel?.hourly {
                headerView.loadData(timeArray: currentModel)
            }
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedModel = viewModel?.weatherModel?.daily?[indexPath.row], let parentModel = viewModel?.weatherModel else { return }
        let detailsVC = DetailsViewController()
        let detailsVM = DetailsViewModel(day: selectedModel, parentModel: parentModel)
        detailsVC.viewModel = detailsVM
        self.present(detailsVC, animated: true, completion: nil)
    }
    func showOptions(){
        let alert = UIAlertController(title: "Select an option", message: "", preferredStyle: .actionSheet)
        let celsius = UIAlertAction(title: "Celsius", style: UIAlertAction.Style.default, handler: {
            (_)in
            let units = UnitsofMeasurement.celsius
            Commons.unitesofMeasurement = units
            self.tblView.reloadData()
        })
        let fahrenheit = UIAlertAction(title: "Fahrenheit", style: UIAlertAction.Style.default, handler: {
            (_)in
            let units = UnitsofMeasurement.fahrenheit
            Commons.unitesofMeasurement = units
            self.tblView.reloadData()
        })
        alert.addAction(celsius)
        alert.addAction(fahrenheit)
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let daysCount = viewModel?.numberofRows() ?? 0
        return section == 0 ? 0 : daysCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DaysTableViewCell = tableView.dequeueReusableCell(withIdentifier: DaysTableViewCell.Identifier, for: indexPath) as! DaysTableViewCell

        if let currentModel = viewModel?.getDaysModel(idxPath: indexPath){
            cell.loadData(model: currentModel)
        }

        return cell
    }


}
