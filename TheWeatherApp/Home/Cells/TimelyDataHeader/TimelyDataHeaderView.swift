//
//  TimelyDataHeaderView.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import UIKit

class TimelyDataHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var timeCollectionView: UICollectionView!
    var datasource = [Hourly]()

    override func awakeFromNib() {
        timeCollectionView.register(UINib(nibName: TimelyCollectionViewCell.Identifier, bundle: nil), forCellWithReuseIdentifier: TimelyCollectionViewCell.Identifier)
    }

    func loadData(timeArray : [Hourly]){
        datasource = timeArray
        timeCollectionView.reloadData()
    }

    
}

extension TimelyDataHeaderView : UICollectionViewDelegate{

}
extension TimelyDataHeaderView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 100, height: 100)
    }
}
extension TimelyDataHeaderView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TimelyCollectionViewCell = collectionView.dequeueCell(identifier: TimelyCollectionViewCell.Identifier, indexPath: indexPath)
        cell.loadData(model: datasource[indexPath.row])
        return cell
    }


}
