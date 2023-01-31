

// Задание 1
func nextNumber(_ number: Int) -> Int {
    return number + 1
}

nextNumber(5)
nextNumber(10)
nextNumber(1023)

// Задание 2
func getSquare(_ number: Int) -> Int {
    return number * number
}

let value = getSquare(3)
print(value)


// Задание 3
func getMinutesAndSeconds(seconds: Int) -> (min: Int, sec: Int) {
    let minutes = seconds / 60
    let seconds = seconds % 60
    let result = (minutes, seconds)
    return result
}

let result: (min: Int, sec: Int)  = getMinutesAndSeconds(seconds: 850)
print(result.min)
print(result.sec)

// Задание 4
let string1 = "Writing Swift code "
let string2 = "is interactive and fun"

func concat(_ str1: String, _ str2: String) -> String {
    return str1 + str2
}

let fullString = concat(string1, string2)
print(fullString)

// Задание 5
import Foundation

func getDate(_ dateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    let todayDate: Date = Date()
    print(todayDate)
    
    let result: Date = formatter.date(from: dateString) ?? todayDate
    print(result)
    
    return result
}

getDate("2004-11-23")
