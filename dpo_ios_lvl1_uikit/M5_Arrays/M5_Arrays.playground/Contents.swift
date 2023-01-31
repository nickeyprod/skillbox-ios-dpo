
// Задание 1

var empty = [Int]()
var oneInt = [5]
var ints = [5, 8, 9, 10, 12]

func addDigits(massive: [Int]) -> Int {
    let count = massive.count;
    if count >= 2 {
        return massive[0] + massive[1]
    } else if count >= 1 {
        return massive[0] + 0
    } else {
        return 0
    }
}

addDigits(massive: empty)
addDigits(massive: oneInt)
addDigits(massive: ints)


// MARK: -
// Задание 2

func getNewMassive(massive: [Int]) -> [Int?]? {
    guard massive.count > 2 else {
        return nil
    }

    let first = massive.first
    let last = massive.last
    
    let result = [first, last]
    
    return result
}

getNewMassive(massive: empty)
getNewMassive(massive: oneInt)
getNewMassive(massive: ints)

// MARK: -
// Задание 3
import Foundation

var dates = [Date]()
var datesString = [String]()

for _ in 0 ..< 15 {
    dates.append(Date(timeIntervalSinceNow: TimeInterval(Int.random(in: -1000000000 ... 1000000000))))
}

let formatter = DateFormatter()
formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

for date in dates {
    datesString.append(formatter.string(from: date))
}

print(datesString)
print("<<<<  --------------------------------- >>>>")

// MARK: -
// Задание 4

let closure: (Date) -> String = { formatter.string(from: $0) }
let mapped = dates.map(closure)
print(mapped)

// MARK: -
// Задание 5

var fruits = Set<String>()
fruits.insert("orange")
fruits.insert("apple")
fruits.insert("banana")
fruits.insert("grapefruit")

let redFood: Set = ["apple", "tomato", "grapefruit", "strawberry"]
// множество красных фруктов
let redFruits = fruits.intersection(redFood)
print(redFruits)
// множество красных продуктов, но не фруктов
let redFoodWithoutFruits = redFruits.symmetricDifference(redFood)
print(redFoodWithoutFruits)
// множество всей еды, кроме красных фруктов.
let allFood = redFood.union(redFruits).union(fruits)
let allFoodWithoutRedFruits = allFood.symmetricDifference(redFruits)
print(allFoodWithoutRedFruits)

// MARK -
// Задание 6*
func deleteDuplicates(massive: [String]) -> Set<String> {
    let cleanSet = Set(massive.map { $0})
    return cleanSet
}

var fruitsList = ["apple", "tomato", "tomato", "grapefruit", "strawberry", "strawberry"]
deleteDuplicates(massive: fruitsList)



