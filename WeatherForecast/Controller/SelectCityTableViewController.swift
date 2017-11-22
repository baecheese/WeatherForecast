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
    
    var dataIsEmpty = false
    let dataCenter = DataCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 < dataCenter.count() {
            return dataCenter.count()
        }
        dataIsEmpty = true
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        if true == dataIsEmpty {
            cell.textLabel?.text = "저장된 도시가 없습니다."
            cell.textLabel?.textColor = .gray
        }
        else {
            cell.textLabel?.textColor = .black
            cell.textLabel?.text = dataCenter.getCity(id: indexPath.row)?.fullName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let weatherPage = storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController {
            // to do
            if 0 == indexPath.row {
                weatherPage.city = City(city: "서울", county: "강남구", village: "도곡동")
            }
            else {
                weatherPage.city = City(city: "고양", county: "덕양구", village: "화정동")
            }
//            weatherPage.selectArea = CityInfo().citys[indexPath.row]
            self.navigationController?.pushViewController(weatherPage, animated: true)
        }
    }

}
