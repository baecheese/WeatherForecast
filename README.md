# 🌤 Weather Forecast 🌧

## 사용 서비스
* [SK Weather API](https://developers.skplanetx.com/apidoc/kor/weather/)
* [Alamofire](https://github.com/Alamofire/Alamofire)

## Request
``` Swift
func requestREST() {
  let weatherURL = "http://apis.skplanetx.com/weather/current/minutely"
  let header : HTTPHeaders = ["appKey" : "c7c387b5-f5f7-3342-91dd-ae532e67ced7"]
  let parameters = ["version" : "1",
                   "city" : "서울",
                   "county" : "강남구",
                   "village" : "도곡동"]
        
  Alamofire.request(weatherURL, method: .get, parameters: parameters,
                    encoding: URLEncoding.default, headers: header)
                    .responseJSON { (response) in
                        switch response.result {
                        case .success(let JSON):
                          print("🌈 Success with JSON : \(JSON)")
                        case .failure(let error):
                            print("😈 Failure with error : \(error)")
                        }
                    }
}
```

###  App Transport Security Setting
![](Plan/App Transport Security Setting)
* 위의 방법은 모든 HTTP를 허용하는 방법이므로 실제 사용에서는 적합하지 않음
* 참고 - [블로가 되어 날아보자 iOS iOS9 App Transport Security 설정법](http://blowmj.tistory.com/entry/iOS-iOS9-App-Transport-Security-%EC%84%A4%EC%A0%95%EB%B2%95)

## Response
```
🌈 Success with JSON :  {
    common =     {
        alertYn = Y;
        stormYn = N;
    };
    result =     {
        code = 9200;
        message = "\Uc131\Uacf5";
        requestUrl = "/weather/current/minutely?village=\Ub3c4\Uace1\Ub3d9&county=\Uac15\Ub0a8\Uad6c&version=1&city=\Uc11c\Uc6b8";
    };
    weather =     {
        minutely =         (
                        {
                humidity = "";
                lightning = 0;
                precipitation =                 {
                    sinceOntime = "0.00";
                    type = 0;
                };
                pressure =                 {
                    seaLevel = "";
                    surface = "";
                };
                rain =                 {
                    last10min = "0.00";
                    last12hour = "0.00";
                    last15min = "0.00";
                    last1hour = "0.00";
                    last24hour = "0.00";
                    last30min = "0.00";
                    last6hour = "0.00";
                    sinceMidnight = "0.00";
                    sinceOntime = "0.00";
                };
                sky =                 {
                    code = "SKY_A01";
                    name = "\Ub9d1\Uc74c";
                };
                station =                 {
                    id = 401;
                    latitude = "37.48891";
                    longitude = "127.01562";
                    name = "\Uc11c\Ucd08";
                    type = KMA;
                };
                temperature =                 {
                    tc = "10.90";
                    tmax = "11.00";
                    tmin = "6.00";
                };
                timeObservation = "2017-11-14 12:39:00";
                wind =                 {
                    wdir = "320.20";
                    wspd = "3.70";
                };
            }
        );
    };
}

```
