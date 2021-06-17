//
//  CitiesViewController.swift
//  Weather
//
//  Created by Олег Савельев on 13.06.2021.
//
import UIKit
import Foundation

extension CitiesViewController: UISearchBarDelegate {
    
    //MARK: -Search settings
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            if let city = searchBar.text?.capitalized, !city.isEmpty {
                let cityVC = self.storyboard?.instantiateViewController(identifier: "City") as! CityViewController
                Network.shared.getCitesWeather(cities: [city]) { weather in
                    cityVC.cityData = weather
                    DispatchQueue.main.async {
                        self.present(cityVC, animated: true, completion: nil)
                    }
                   
                }
            }
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = nil
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
        }

    
    //MARK: - IndicatorActivity
    func activityIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .medium
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    

    //MARK: - Update Views
    func updateView(){
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        citiesTableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "City")
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        citiesTableView.isHidden = true
        
        citySearchBar.translatesAutoresizingMaskIntoConstraints = false
        citySearchBar.delegate = self
        
        constraintsSettings()
    }
    
    //MARK: - Constraints
    private func constraintsSettings(){
        NSLayoutConstraint.activate([
            citySearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citySearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citySearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            citySearchBar.bottomAnchor.constraint(equalTo: citiesTableView.topAnchor),
            
            citiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            citiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
