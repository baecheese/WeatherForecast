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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        tableview.allowsSelection = false
        
        weatherManager.getMintely(city: seletedCity!)
        area.text = seletedCity!.fullName
        
        showAlert()
    }
    
    @IBOutlet var area: UILabel!
    @IBOutlet var sky: UILabel!
    @IBOutlet var temparature: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet var backgroundImage: UIImageView!
    var minutelyWeather = [String : Any]()
    
    func getMintelyWeather(info: [String : Any]) {
        let weather = MyJSONPaser.sharedInstance.getByQuery(query: "weather.minutely", JSONDic: info)
        if let minutely = weather as? Array<[String:Any]> {
            minutelyWeather = minutely[0]
            setBackgroundImage(info: minutely[0])
            setTopInformation(info: minutely[0])
            tableview.reloadData()
        }
    }
    
    func setBackgroundImage(info:[String:Any]) {
        if let skyCode = MyJSONPaser.sharedInstance.getByQuery(query: "sky.code", JSONDic: info) as? String {
            backgroundImage.image = UIImage(named: weatherInfo.getSkyImageName(name: skyCode))
            backgroundImage.contentMode = .scaleAspectFill
            backgroundImage.alpha = 0.8
        }
    }
    
    func setTopInformation(info:[String:Any]) {
        if let nowTemperature = MyJSONPaser.sharedInstance.getByQuery(query: "temperature.tc", JSONDic: info) as? String,
            let skyCode = MyJSONPaser.sharedInstance.getByQuery(query: "sky.code", JSONDic: info) as? String {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.sky.text = self.weatherInfo.getSkyState(code: skyCode)
                self.temparature.text = nowTemperature + self.weatherInfo.getUnit(key: "temperature.tc")
                self.alert.dismiss(withClickedButtonIndex: 0, animated: true)
            })
        }
    }
    
    private let alert = UIAlertView(title: "Loading...", message: nil , delegate: nil, cancelButtonTitle: nil)
    
    func showAlert() {
        let viewBack:UIView = UIView(frame: CGRect(x: 83, y: 0,width: 100, height: 100))
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 37, height: 37))
        loadingIndicator.center = viewBack.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()
        viewBack.addSubview(loadingIndicator)
        viewBack.center = self.view.center
        alert.setValue(viewBack, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        alert.show()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherInfo.detailInfos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let name = weatherInfo.detailInfos[indexPath.row]
        cell.name.text = name
        cell.name.textColor = .black
        if let value = MyJSONPaser.sharedInstance.getByQuery(query: weatherInfo.querys[name]!, JSONDic: minutelyWeather) as? String {
            cell.value.text = value + weatherInfo.getUnit(key: name)
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
