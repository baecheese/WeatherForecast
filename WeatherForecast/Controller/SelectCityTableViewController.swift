//
//  SelectCityTableViewController.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 21..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit
import Alamofire

class SelectCityTableViewController: UITableViewController {
    
    var allCity = CityRepository.shareInstance.getAllList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        if 1 == indexPath.section {
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
        cell.backgroundColor = .gray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if false == allCity.isEmpty {
            if let weatherPage = storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController,
                1 == indexPath.section {
                weatherPage.seletedCity = allCity[indexPath.row]
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

}
