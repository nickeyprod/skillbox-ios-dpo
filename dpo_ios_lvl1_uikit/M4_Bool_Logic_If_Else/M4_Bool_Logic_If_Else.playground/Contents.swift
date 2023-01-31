// Задание 1
func equalityTrue(_ num1: Int, _ num2: Int) {
    if num1 == num2 {
        print("Равно")
    } else if (num1 > num2) {
        print("Больше")
    } else {
        print("Меньше")
    }
}

equalityTrue(3, 3)
equalityTrue(2, 3)
equalityTrue(4, 3)

// Задание 2
func checkInput(str: String) -> Int {
    if let num = Int(str) {
        if (num > 100 || num < 1) {
            print("\(num) вне диапазона")
            return num
        }
        print(num)
        return num
    } else {
        print("Ошибка")
        return -1
    }
}

checkInput(str: "ups")
checkInput(str: "100")
checkInput(str: "1000")
checkInput(str: "0")

// Задание 3
func findLargestNum(_ listOfInt: [Int]) -> Int {
    var largestNum = 0
    for int in listOfInt {
        if int > largestNum {
            largestNum = int
        }
    }
    return largestNum
}
findLargestNum([4, 5, 1, 3])
findLargestNum([300, 200, 600, 150])
findLargestNum([1000, 1001, 857, 1])

// Задание 4
func cubic(_ num: Int) {
    switch num {
    case 1, 2, 3:
        print("Проигрыш")
    case 4, 5, 6:
        print("Победа")
    default:
        print("У кубика только 6 граней!?")
    }
}

cubic(0)
cubic(2)
cubic(5)
cubic(10)


