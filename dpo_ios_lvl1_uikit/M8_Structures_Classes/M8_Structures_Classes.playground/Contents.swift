import Foundation


// Задание 1
struct Person {
    var name: String
    var age: Int
    
    lazy var info: String = {
        if (lastAgeDigit == 1) {
            return "\(self.name), \(self.age) год"
        }
        let years = (lastAgeDigit >= 2) && (lastAgeDigit <= 4) ? "года" : "лет"
        return "\(self.name), \(self.age) \(years)"
    }()
    
    var lastAgeDigit: Int {
        guard let char = "\(self.age)".last else {
            // Error
            return -1
        }
        let string = String(char)
        let digit = Int(string) ?? -1

        return digit
    }
    
    
    init(_ name: String, _ age: Int) {
        self.name = name
        self.age = age
    }
    
    func getAgeComparisonString(_ p: Person) -> String {
        
        var sentence = ""
        if (p.age > self.age) {
            sentence = "\(p.name) старше меня"
        } else if (p.age < self.age) {
            sentence = "\(p.name) младше меня"
        } else {
            sentence = "\(p.name) такого же возраста, как я"
        }
        return sentence
    }
}

var p1 = Person("Антон", 24)
var p2 = Person("Андрей", 36)
var p3 = Person("Ольга", 24)
var p4 = Person("Наташа", 30)
var p5 = Person("Галина", 31)

print(p1.getAgeComparisonString(p2)) // "Андрей старше меня"
print(p2.getAgeComparisonString(p1)) // "Антон младше меня"
print(p1.getAgeComparisonString(p3)) // "Ольга такого же возраста, как и я"

// MARK: - Задание 2
print(p1.info)
print(p2.info)
print(p3.info)
print(p4.info)
print(p5.info)

// MARK: - Задание 3
class Hero {
    private var lifeCount: Int
    var isLive: Bool {
        print(self.lifeCount)
        if (self.lifeCount > 0) {
            return true
        } else {
            return false
        }
    }
    
    init(_ lifeCount: Int) {
        self.lifeCount = lifeCount
    }
    
    func hit() {
        self.lifeCount -= 2
    }
}

// Герой получил 2 жизни и урон -2, и умер
let hero = Hero(2)
hero.hit()
print(hero.isLive)
// Герой получил 24 жизнии урон -2, но жив
let hero2 = Hero(24)
hero2.hit()
print(hero2.isLive)

// MARK: - Задание 6

class SuperHero: Hero {
    override func hit() {}
}

let superHero = SuperHero(2)
superHero.hit()
superHero.hit()
print(superHero.isLive)
