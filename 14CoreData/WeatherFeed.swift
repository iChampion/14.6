import Foundation

struct WeatherFeed: Decodable{
    var coord: Coord?
    var weather: [MyWeather]?
    var base: String?
    var main: Cmain
    var visibility: Int?
    var wind: Wind?
    var dt: Int?
    var timezone: Int?
    var name: String
    var cod: Int?
}
struct Coord: Decodable {
    var lon: Double?
    var lat: Double?
}
struct MyWeather: Decodable {
    var id: Int?
    var main: String
    var description: String
    var icon: String
}
struct Cmain: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double?
    var temp_max: Double?
    var presure: Int?
    var humidity: Int?
}
struct Wind: Decodable {
    var speed: Int?
    var deg: Int?
}
struct Weather5: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let daily: [Daily]
    
    struct Daily: Decodable {
        let dt: Int
        let temp: Temp
        
        struct Temp: Decodable {
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
    }
}

