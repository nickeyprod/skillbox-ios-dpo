import Foundation

// Задание 1
class Animal {
    var name: String
    var energy: Int = 0
    var weight: Int
    var age: Int = 0
    var maxAge: Int
    
    var isTooOld: Bool {
        if (age >= maxAge) {
            return true
        } else {
            return false
        }
    }
    
    init(name: String, energy: Int, weight: Int, maxAge: Int) {
        self.name = name
        self.energy = energy
        self.weight = weight
        self.maxAge = maxAge

    }
    
    func tryIncrementAge() {
        if (Bool.random()) {
            age += 1
        }
    }
    
    func sleep() {
        energy += 5
        age += 1
        print("\(name) спит...")
    }
    
    func eat() {
        energy += 3
        weight += 1
        
        // Может увеличиться возраст
        tryIncrementAge()
        
        print("\(name) ест")
    }
    
    func move() -> Bool {
        if (isTooOld || energy <= 4 || weight == 0) {
            return false
        }
        energy -= 5
        weight -= 1
        
        // Может увеличиться возраст
        tryIncrementAge()
        
        print("\(name) передвигается... ")
        
        return true
    }
    
    func giveBirthTo() -> Animal {
        let childName = self.name
        let childEnergy = 1//10
        let childWeight = 1//5
        let childMaxAge = self.maxAge
        
        let child = Animal(name: childName, energy: childEnergy, weight: childWeight,  maxAge: childMaxAge)
        
        print("Рождено потомство: \(childName), энергия: \(childEnergy), вес: \(childWeight), максимальный возраст: \(childMaxAge)")
        
        return child
    }
}

// Наследники класса Animal

class Bird: Animal {
    override func move() -> Bool {
        guard true == super.move() else {
            return false
        }
        print("летит!")
        return true
    }
    
    override func giveBirthTo() -> Animal {
        let childName = self.name
        let childEnergy = Int.random(in: 1...10)
        let childWeight = Int.random(in: 1...5)
        let childMaxAge = self.maxAge
        
        let child = Bird(name: childName, energy: childEnergy, weight: childWeight,  maxAge: childMaxAge)
        
        print("Рождено потомство: \(childName), энергия: \(childEnergy), вес: \(childWeight), максимальный возраст: \(childMaxAge)")
        
        return child
    }
}

class Fish: Animal {
    override func move() -> Bool {
        guard true == super.move() else {
            return false
        }
        print("плывёт!")
        return true
    }
    
    override func giveBirthTo() -> Animal {
        let childName = self.name
        let childEnergy = Int.random(in: 1...10)
        let childWeight = Int.random(in: 1...5)
        let childMaxAge = self.maxAge
        
        let child = Fish(name: childName, energy: childEnergy, weight: childWeight,  maxAge: childMaxAge)
        
        print("Рождено потомство: \(childName), энергия: \(childEnergy), вес: \(childWeight), максимальный возраст: \(childMaxAge)")
        
        return child
    }
}

class Dog: Animal {
    override func move() -> Bool {
        guard true == super.move() else {
            return false
        }
        print("бежит!")
        return true
    }
    
    override func giveBirthTo() -> Animal {
        let childName = self.name
        let childEnergy = Int.random(in: 1...10)
        let childWeight = Int.random(in: 1...5)
        let childMaxAge = self.maxAge
        
        let child = Dog(name: childName, energy: childEnergy, weight: childWeight,  maxAge: childMaxAge)
        
        print("Рождено потомство: \(childName), энергия: \(childEnergy), вес: \(childWeight), максимальный возраст: \(childMaxAge)")
        
        return child
    }
}

let bobik = Dog(name: "Бобик", energy: 20, weight: 10, maxAge: 11)
bobik.move()
bobik.eat()
bobik.sleep()

let bobikChild = bobik.giveBirthTo()
bobikChild.eat()
bobikChild.sleep()

let dynkan = Fish(name: "Дункан", energy: 10, weight: 4, maxAge: 4)
dynkan.move()
dynkan.eat()
dynkan.sleep()

let dynkanChild = dynkan.giveBirthTo()
dynkanChild.move()
dynkanChild.eat()
dynkanChild.sleep()

let gusa = Bird(name: "Гуся", energy: 44, weight: 7, maxAge: 8)
gusa.move()
gusa.sleep()
gusa.eat()

let gusaChild = gusa.giveBirthTo()
gusaChild.eat()
gusaChild.sleep()
print(gusaChild.isTooOld)

class NatureReserve {
    var natureReserve: [Animal]
    
    init(natureReserve: [Animal]) {
        self.natureReserve = natureReserve
    }
}

var nature = [ Bird(name: "Орёл", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 9),
               Bird(name: "Гусь", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 6),
               Bird(name: "Ворон", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 4),
               Bird(name: "Колибри", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 5),
               Bird(name: "Голубь", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 5),
               Fish(name: "Сомик", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 6),
               Fish(name: "Вобла", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 6),
               Fish(name: "Лещ", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 7),
               Dog(name: "Питбуль", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 10),
               Dog(name: "Шиба Ину", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 11),
               Animal(name: "Лемур", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 13),
               Animal(name: "Бурый медведь", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 15),
               Animal(name: "Слон", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 25),
               Animal(name: "Черепаха", energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maxAge: 75)
]

while (nature.count < 100) {
    
    for (index, animal) in nature.enumerated() {
        let randomNum = Int.random(in: 1...4)
        if (randomNum == 1) {
            animal.eat()
        } else if (randomNum == 2) {
            animal.move()
        } else if (randomNum == 3) {
            animal.sleep()
        } else {
            let newChild = animal.giveBirthTo()
            nature.append(newChild)
        }
        
        if (animal.isTooOld) {
            nature.remove(at: index)
            print("\(animal.name) умирает от старости <<<<----------------------")
        } else if nature.count == 0 {
            print("Все животные умерли")
        }
    }
    print("+++++++++++++++++++++++++++++++++++++++++++++")
    print("Сейчас в заповеднике \(nature.count) животных")
    print("+++++++++++++++++++++++++++++++++++++++++++++")

}
