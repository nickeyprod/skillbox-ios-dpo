import Foundation

// MARK: - Задание 1

print("========== ЗАДАНИЕ 1 =========")

protocol CalorieCountProtocol {
     var calories: Int { get }
     func description() -> String
}

class Cookie: CalorieCountProtocol {
    
    var calories: Int
    
    init(calories: Int) {
        self.calories = calories
    }
    
    func description() -> String {
        return "Вкусное печенье - \(calories) калорий"
    }
}

var cookie = Cookie(calories: 15)
print(cookie.calories)
print(cookie.description())



struct Apple: CalorieCountProtocol {
    var calories: Int
    
    func description() -> String {
        return "Полезное яблоко - \(calories) калорий"
    }
}

var apple = Apple(calories: 10)
print(apple.calories)
print(apple.description())



enum Cake:  CalorieCountProtocol {
    
    var calories: Int {
        return 221
    }
    
    case calories
    
    func description() -> String {
            return "Калорийнейший торт - \(calories) калорий"
    }
}

let caloriesCase = Cake.calories

print(caloriesCase.calories)
print(caloriesCase.description())



// MARK: - Задание 2

print("========== ЗАДАНИЕ 2 =========")

enum BalanceType {
    case positive, negative, neutral
}

struct Balance: Equatable {
    static func == (lhs: Balance, rhs: BalanceObject) -> Bool {
        return lhs.amount == rhs.amount && lhs.type == rhs.type
    }
    
    let type: BalanceType
    let amount: Int
}

class BalanceObject: Equatable {
    static func == (lhs: BalanceObject, rhs: BalanceObject) -> Bool {
        return lhs.amount == rhs.amount && lhs.type == rhs.type
    }
    
    var type: BalanceType
    var amount: Int
    
    init(type: BalanceType, amount: Int) {
        self.type = type
        self.amount = amount
    }
}

let neutralBalance = BalanceType.neutral
let positiveBalance = BalanceType.positive
let negativeBalance = BalanceType.negative

let balanceClass1 = BalanceObject(type: positiveBalance, amount: 5)
let balanceClass2 = BalanceObject(type: neutralBalance, amount: 15)
let balanceClass3 = BalanceObject(type: positiveBalance, amount: 5)

let balanceStructure1 = Balance(type: neutralBalance, amount: 5)
let balanceStructure2 = Balance(type: neutralBalance, amount: 5)
let balanceStructure3 = Balance(type: positiveBalance, amount: 5)

// Сравниваем структуры и классы
print(balanceStructure1 == balanceClass1)
print(balanceStructure3 == balanceClass3)
print(balanceStructure2 == balanceClass2)

// Сравниваем структуры
print(balanceStructure1 == balanceStructure2)
print(balanceStructure1 == balanceStructure3)
print(balanceStructure2 == balanceStructure3)

// Сравниваем классы
print(balanceClass1 == balanceClass2)
print(balanceClass1 == balanceClass3)
print(balanceClass2 == balanceClass3)





// MARK: - Задание 3

print("========== ЗАДАНИЕ 3 =========")
protocol Dog {
    var name: String { get set }
    var color: String { get set }
}

struct Haski: Dog {
    var name: String
    var color: String
}

class Corgi: Dog {
    var name: String
    var color: String

    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}

struct Hound: Dog {
    var name: String
    var color: String
}

extension Dog {
    func speak() -> String {
        return "\(name) гавкает"
    }
}

let animals: [Dog] = [Haski(name: "Лоя", color: "Рыжый"), Corgi(name: "Борсик", color: "Черный"), Hound(name: "Пиля", color: "Буро-серый"), Corgi(name: "Масик", color: "Серо-кориченвый")]

for dog in animals {
    print(dog.speak())
}

print("================================")
