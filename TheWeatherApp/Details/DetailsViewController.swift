//
//  DetailsViewController.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    var viewModel : DetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()


        let headerNib = UINib.init(nibName: HomeHeaderView.Identifier, bundle: Bundle.main)
        detailsTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: HomeHeaderView.Identifier)
        detailsTableView.estimatedSectionHeaderHeight = 300
        detailsTableView.register(UINib(nibName: DetailsTableViewCell.Identifier, bundle: Bundle.main), forCellReuseIdentifier: DetailsTableViewCell.Identifier)



        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        detailsTableView.reloadData()
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

extension DetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = .white
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.Identifier) as! HomeHeaderView
        if let currentModel = viewModel?.selectedDay {
            headerView.loadData(weatherModel: currentModel)
        }
        headerView.backgroundColor = .white
        return headerView
    }
}

extension DetailsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.Identifier, for: indexPath) as! DetailsTableViewCell
        if let currentModel = viewModel?.selectedDay {
            cell.loadData(model: currentModel)
        }
        return cell
    }


}
