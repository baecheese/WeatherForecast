//
//  SelectCityTableViewController.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 21..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class SelectCityTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    private var currentCity = ""
    let allCity = CityRepository.shareInstance.getAllList()
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        loadLaction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if 0 == section {
            return "current location"
        }
        return "city"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 1
        }
        if 0 < allCity.count {
            return allCity.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if 1 == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
            if allCity.isEmpty {
                cell.textLabel?.text = "저장된 도시가 없습니다."
                cell.textLabel?.textColor = .gray
                cell.selectionStyle = .none
            }
            else {
                cell.textLabel?.textColor = .black
                cell.textLabel?.text = allCity[indexPath.row].fullName
                cell.selectionStyle = .gray
            }
            return cell
        }
        let currentLocationCell = Bundle.main.loadNibNamed("CurrentLocationTableViewCell", owner: self, options: nil)?.first as! CurrentLocationTableViewCell
        currentLocationCell.cityName.text = currentCity
        return currentLocationCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if false == allCity.isEmpty {
            if let weatherPage = storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController {
                if 0 == indexPath.section {
                    var current = currentCity.split(separator: " ").map { String($0) }
                    current.append(currentCity)
                    let city = City()
                    city.setInfo(cityInfos: current)
                    weatherPage.seletedCity = city
                }
                if 1 == indexPath.section {
                    weatherPage.seletedCity = allCity[indexPath.row]
                }
                self.navigationController?.pushViewController(weatherPage, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if 0 == indexPath.section {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CityRepository.shareInstance.delete(city:allCity[indexPath.row])
            tableView.reloadData()
        }
    }
    
    private let locationManager = CLLocationManager()
    
    func loadLaction() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coor = manager.location?.coordinate {
            let location = CLLocation(latitude: coor.latitude, longitude: coor.longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                if let placeMark = placemarks?.first {
                    self.changeCurrentCityLabel(address: placeMark.name!)
                }
            })
            locationManager.stopUpdatingLocation()
        }
    }
    
    func changeCurrentCityLabel(address:String) {
        let addressInfo = address.split(separator: " ")
        if "대한민국" == addressInfo[0] {
            var city = ""
            for info in addressInfo {
                if info.last == "시" {
                    var new = info
                    new.removeLast()
                    city += "\(new) "
                }
                else if info.last == "구" {
                    city += "\(info) "
                }
                else if info.last == "동" {
                    city += "\(info)"
                }
            }
            currentCity = city
            self.tableview.reloadData()
            return;
        }
        currentCity = "지원하지 않는 국가입니다."
    }
    
}
