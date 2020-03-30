//
//  COVIDCollectionViewController.swift
//  covidTracker
//
//  Created by pradeep Kolli on 3/24/20.
//  Copyright © 2020 pradeep Kolli. All rights reserved.
//

import UIKit

extension CovidCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: 235)
    }
}

private let reuseIdentifier = "caseCells"

class CovidCollectionViewController: UICollectionViewController, UISearchBarDelegate {
    let serviceRequest = CovidServiceRequest()
    var listingsArray:[Countries]?
    var searchCountryArray:[Countries]?
    var searching:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeServiceRequest()
        
    }
    func makeServiceRequest(){
        serviceRequest.fetchCovidCases{(response) in
            switch response{
            case.success(let responseInfo):
                self.listingsArray = responseInfo
                NSLog("case list data response \(String(describing: responseInfo))")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case.failure(let error):
                NSLog("error occured while requesting response Data \(error.localizedDescription)")
            }
        }
    }
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Search bar functionality
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchbarHeader", for: indexPath)
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if(!(searchBar.text?.isEmpty)!){
//            //reload your data source if necessary
//            self.collectionView?.reloadData()
//        }
//    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        searching = false
        collectionView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCountryArray = listingsArray?.filter({
            return $0.countryName == searchText
            
        })
        searching = true
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if searching{
            return self.searchCountryArray?.count ?? 0
        }
        return self.listingsArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CovidCollectionViewCell
        let covidEffectedCountry:Countries?
        if(searching){
            covidEffectedCountry = searchCountryArray?[indexPath.row]
        }
        else{
            covidEffectedCountry = listingsArray?[indexPath.row]
        }
        
        cell.countryNameLBL.text = covidEffectedCountry?.countryName
        cell.casesInTotalLBL.text = covidEffectedCountry?.cases.totalCases.commaSeparated
        cell.newCasesLBL.text = covidEffectedCountry?.cases.newCases
        cell.recoveredCasesLBL.text = covidEffectedCountry?.cases.recoveredCases.commaSeparated
        cell.totalDeathLBL.text = covidEffectedCountry?.deaths.totalDeaths.commaSeparated
        cell.newDeathsLBL.text = covidEffectedCountry?.deaths.newDeaths
        // Configure the cell
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius =  5
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    
}
