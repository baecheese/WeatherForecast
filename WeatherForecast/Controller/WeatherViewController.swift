//
//  WeatherViewController.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 13..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var value: UILabel!
}

class WeatherViewController: UIViewController, WeatherManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    var seletedCity:City? = nil
    let weatherManager = WeatherManager()
    let weatherInfo = WeatherInfo()
    var currentWeather:Weather? = nil
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var mainInfoView: MainWeatherInfoView!
    
    var minutelyWeather = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        tableview.allowsSelection = false
        
        weatherManager.getMintely(city: seletedCity!)
        // todo
//        area.text = seletedCity!.fullName
        
        showAlert()
    }
    
    func getMintelyWeather(info: [String : Any]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            var message = "Error"
            if let weatherForcast = WeatherForecast(json: info) {
                let weather = weatherForcast.weather
                self.succeseWeatherInfos(weather: weather)
                return;
            }
            if let error = ErrorJSON(json: info) {
                message = error.message
                self.failWeatherInfo(message: message)
            }
        })
    }
    
    func succeseWeatherInfos(weather:Weather) {
        currentWeather = weather
        // todo - mintely를 구하는 것이 아닐 때의 확장성
        if let sky = weather.minutely?.first?.sky {
            setBackgroundImage(sky: sky)
        }
        setTopInformation(weather: weather)
        tableview.reloadData()
        alert.dismiss(animated: true, completion: nil)
    }
    
    func failWeatherInfo(message:String) {
        alert.title = "Fail"
        alert.message = message
    }
    
    func setBackgroundImage(sky:Sky) {
        backgroundImage.image = UIImage(named: weatherInfo.getSkyImageName(name: sky.code))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.8

    }
    
    func setTopInformation(weather:Weather) {
        // todo weather의 카테고리를 고를 수 잇을 때 (ex 분 별, 시간 별 ...)
        if let minutely = weather.minutely?.first {
            // to do
//            mainInfoView.setData(minutely)
            /* todo
            sky.text = weatherInfo.getSkyState(code: minutely.sky.code)
            // todo
            temparature.text = minutely.temperature.tc + weatherInfo.getUnit(type: minutely)
             */
        }
    }
    
    private let alert = UIAlertController(title: "loading", message: "날씨 정보를 받는 중입니다.", preferredStyle: UIAlertControllerStyle.alert)
    
    func showAlert() {
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (Bool) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherInfo.detailKeys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let name = weatherInfo.detailKeys[indexPath.row]
        cell.name.text = name
        cell.name.textColor = .black
        if let weather = currentWeather,
            let weatherType = weather.minutely?.first {
            //to do
            cell.value.text = weatherInfo.getDetail(name: name, weatherType: weatherType) + weatherInfo.getUnit(type: weatherType)
            
            cell.value.textColor = .black
        }
        else {
            cell.value.text = "🌙"
        }
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
