//
//  main.swift
//  GBQ5
//
//  Created by Даниил Мурыгин on 21.10.2019.
//

import Foundation


struct CarInfo {
    
    let mark:String
    
    let year:Date
    
    let color:CGColor
    
    let weightCapasity:Double
}

enum EngineDo:String {
    case on = "Включен"
    case off = "Выключен"
}
enum WindowDo:String {
    case open = "Открыты"
    case close = "Закрыты"
}

enum Carcase{
    case load, unload
}

enum InfoAboutCar {
    case min,full
}

protocol Car {
    
    var carInfo: CarInfo {get}
    var engine: EngineDo {get set}
    var window: WindowDo {get set}
    var filledWeight: Double {get set}
    func getInfo(infoCount:InfoAboutCar)

}
extension Car{
    mutating func carWindow(_ state: WindowDo){
          self.window = state
      }
      
    mutating func carEngine(_ state: EngineDo){
          self.engine = state
      }
    
    mutating func loadOrUnloadTrunk(_ value: Double, _ action: Carcase){
        
        switch action {
            case .load where value <= 0:
                print("Добавлено дуновение ветра")
            case .load where self.filledWeight + value > self.carInfo.weightCapasity:
                print("Вместимость превышена!")
            case .load:
                self.filledWeight += value
                
            case .unload where value >= filledWeight:
                self.filledWeight = 0
            case .unload where value < 0:
                self.filledWeight += value
            case .unload:
                self.filledWeight -= value
        }
    }
    
    func getInfo(infoCount: InfoAboutCar) {
        switch infoCount {
          case .min:
            print("Марка машины:\(carInfo.mark)",
                "\nГод выпуска:\(carInfo.year)",
                        "\nЦвет:\(carInfo.color)")
          case .full:
              print("Марка машины:\(carInfo.mark)",
                        "\nГод выпуска:\(carInfo.year)",
                        "\nЦвет:\(carInfo.color)",
                        "\nДвигатель:\(engine.rawValue)",
                        "\nОкна:\(window.rawValue)")
          }
    }
}

enum Boost: String {
    case on = "Включен"
    case off = "Выключен"
}

class SportCar: Car {
    
    
    let carInfo: CarInfo
    
    var engine: EngineDo = .off
    
    var window: WindowDo = .close
    
    private(set) var boost:Boost = .off
    
    
    var filledWeight: Double = 0
    
    
    init(_ carInfo:CarInfo) {
        self.carInfo = carInfo
    }
    
    func loadOrUnloadTrunk() {
        print("В спортивных машинах нет возможности добавить багаж :c")
    }
    
    func boostOnOrOff(_ action:Boost) {
        self.boost = action
    }
    
    func getInfo(infoCount: InfoAboutCar) {
        switch infoCount {
          case .min:
            print("Марка машины:\(carInfo.mark)",
                "\nГод выпуска:\(carInfo.year)",
                        "\nЦвет:\(carInfo.color)")
          case .full:
              print("Марка машины:\(carInfo.mark)",
                        "\nГод выпуска:\(carInfo.year)",
                        "\nЦвет:\(carInfo.color)",
                        "\nДвигатель:\(engine.rawValue)",
                        "\nУскорение:\(boost.rawValue)",
                        "\nОкна:\(window.rawValue)")
          }
    }
    
}

extension SportCar: CustomStringConvertible{
    var description: String {
        get{
            return "Это Спортивная машина"
        }
    }
}


class TrunkCar: Car {
    
    enum TrunkUpOrDown: String{
        case up = "Кузов поднят"
        case down = "Кузов опущен"
    }
    
    let carInfo: CarInfo
    
    var engine: EngineDo = .off
    
    var window: WindowDo = .close
    
    private(set) var trunkStatus:TrunkUpOrDown = .down
    
    
    var filledWeight: Double = 0
    
    init(_ carInfo:CarInfo) {
        self.carInfo = carInfo
    }
    
    func trunkUpOrDown(_ action:TrunkUpOrDown) {
        self.trunkStatus = action
    }
    
    func getInfo(infoCount: InfoAboutCar) {
        switch infoCount {
          case .min:
            print("Марка машины:\(carInfo.mark)",
                "\nГод выпуска:\(carInfo.year)",
                        "\nЦвет:\(carInfo.color)")
          case .full:
              print("Марка машины:\(carInfo.mark)",
                        "\nГод выпуска:\(carInfo.year)",
                        "\nЦвет:\(carInfo.color)",
                        "\nДвигатель:\(engine.rawValue)",
                        "\nСтатус кузова:\(trunkStatus.rawValue)",
                        "\nОкна:\(window.rawValue)")
          }
    }
    
}

extension TrunkCar: CustomStringConvertible{
    var description: String {
        get{
            return "Это Грузовая машина"
        }
    }
}



var b = SportCar(CarInfo(mark: "test", year: Date(), color: .white, weightCapasity: 0))

print(b.description)
b.getInfo(infoCount: .full)


var c = TrunkCar(CarInfo(mark: "monster", year: Date(), color: .black, weightCapasity: 1500))

print(c.description)
c.getInfo(infoCount: .full)
