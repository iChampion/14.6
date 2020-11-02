import Foundation
import Alamofire

protocol WeatherDelegate {
    func loaded(weather: WeatherFeed)
}
class WeatherLoader {
    
    var delegete: WeatherDelegate?
    
    func loadWeather(){
        //SVProgressHUD.show()
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&lang=ru&appid=1b5d6b08a5a5bba746af85d8d6967514")!
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [self] (data, response, error) in
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do {
                    let wFeeds =  try decoder.decode(WeatherFeed.self, from: data!)
                    //SVProgressHUD.dismiss()
                    DispatchQueue.main.async{
                    print(wFeeds.name)
                        self.delegete?.loaded(weather: wFeeds)
                    }
                } catch {
                    debugPrint("Error JSON parsing")
                }
            }
        }
        dataTask.resume()
    }
    
    func loadWeather2(completion: @escaping (Weather5) -> Void ){
        let request = AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.75&lon=37.62&units=metric&lang=ru&appid=f86ed0c9b1eeaf923c459e7a76cf3959")
            request.responseDecodable(of: Weather5.self) { (response) in
                guard let weather = response.value else { return }
                completion(weather)
            }
    }
}
