//
//  LineNotify.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 12. 9..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation
import Alamofire

public class LineNotifyBot : NSObject {
    
    public static let sharedInstance:LineNotifyBot = LineNotifyBot()
    
    private let token:String = "oN7VIIUXZ1zcLNoRIE4hRwdr69jgMJQHs1MQ1Bykxe9"
    
    private override init() {
        super.init()
    }
    
    public func notify(sender:String, message:String) {
        var request = URLRequest(url: URL(string: "https://notify-api.line.me/api/notify")!)
        
        request.httpMethod = "POST"
        request.setValue("Bearer " + self.token, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["message":"\(sender)\n\(message)"], options: [])

        Alamofire.request(request).responseJSON { (response) in
                            switch response.result {
                            case .success(let JSON):
                               print(JSON)
                            case .failure(let error):
                                print(error)
                            }
        }
    }
        
}
