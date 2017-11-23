//
//  SearchCityViewController.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 22..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class SearchCityViewController: UIViewController, WeatherManagerDelegate {

    private let weatherManager = WeatherManager()
    private var isSuccess = false
    private var searchedCity:City? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        result.isUserInteractionEnabled = true
    }

    @IBOutlet var textField: UITextField!
    @IBOutlet var result: UILabel!
    
    
    @IBAction func search(_ sender: UIButton) {
        if let cityFullName = textField.text, false == cityFullName.isEmpty {
            var cityArr = cityFullName.split(separator: " ").map { String($0) }
            if 3 == cityArr.count {
                cityArr.append(cityFullName)
                let city = City()
                city.setInfo(cityInfos: cityArr)
                searchedCity = city
                weatherManager.getMintely(city: city)
            }
        }
    }
    
    func getMintelyWeather(info: [String : Any]) {
        if let errorMessage = MyJSONPaser.sharedInstance.getByQuery(query: "error.message", JSONDic: info) as? String {
            result.text = lineBreak(message: errorMessage)
            searchedCity = nil
            isSuccess = false
        }
        else {
            result.text = "'\((textField.text)!)'을\n저장하시겠습니까?"
            isSuccess = true
        }
    }
    
    func lineBreak(message:String) -> String {
        var newMessage = message
        if 20 < message.count {
            let endOfPart = Int(Double(message.count) * 0.4)
            let splitMessage = newMessage.split(endOfPart: endOfPart)
            newMessage = "\(splitMessage[0])\n\(splitMessage[1])"
        }
        return newMessage
    }
    
    @IBAction func saveCity(_ sender: UITapGestureRecognizer) {
        if let city = searchedCity, true == isSuccess {
            CityRepository.shareInstance.save(city: city)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
