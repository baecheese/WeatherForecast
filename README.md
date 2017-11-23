# 🌤 Weather Forecast 🌧
## 개발 진행 상황
* 날씨 정보 지원 도시 검색 (완료)
* 날씨 정보 요청 (완료)
* 기본 UI (완료)
* 사용자 지정 도시 저장 (진행중 ing....)

## 시연
![](https://github.com/baecheese/WeatherForecast/blob/master/Plan/use.gif?raw=true)


##  앱 이미지
### 도시 검색 / 저장
![](https://github.com/baecheese/WeatherForecast/blob/master/Plan/main.png?raw=true)
![](https://github.com/baecheese/WeatherForecast/blob/master/Plan/search.png?raw=true)
* 원하는 지역에 관측소가 있는지 검색하고, 저장한다.

### 날씨정보
![](https://github.com/baecheese/WeatherForecast/blob/master/Plan/weatherView.jpg?raw=true)
* 저장한 도시를 누르면 현재 날씨 정보를 알려준다.
* 날씨에 따라 배경화면을 다르게 보여준다.

## 사용 서비스
* [SK Weather API](https://developers.skplanetx.com/apidoc/kor/weather/)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [Realm](https://realm.io/)

## Request Example
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

## Response Example
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
