import Foundation

// Задание - 1
// Прочитайте статью про структуры данных

// --
// --

// Задание - 2
// Реализуйте класс linked list, работающий только со строками. Сделайте в нём функцию поиска строки.
class LLNode<String: Equatable> {
    var key: String?
    var next: LLNode<String>?
    var previous: LLNode<String>?
    
    init(value: String) {
        key = value
    }
    
    convenience init(values: [String]) {
        self.init(value: values.first ?? "" as! String)
        var current = self
        for i in 1..<values.count {
            let next = LLNode(value: values[i])
            current.next = next
            current = next as! Self
            if i != 1 {
                current.previous = LLNode(value: values[i - 1])
            }
        }
    }
    
    func search(for key: String) -> LLNode<String>? {
        
        var current = self
        guard var next = self.next else { return nil }
        var found: LLNode<String>? = nil
        
        repeat {
            
            if current.key == key {
                found = current
                return found
            } else {
                current = next
            }
            
            if let newNext = next.next {
                next = newNext
            } else {
                if (current.key == key) {
                    found = current
                }
            }
            
        } while(found?.key != key)
        return found
    }
}

print("=== START TASK 2 - [Linked List] ===")
let list = LLNode(values: ["1", "2", "5", "10", "GO"])
list.key == list.next?.key
list.next?.next?.previous?.key

let one = list.search(for: "1")
let ten = list.search(for: "10")
let go = list.search(for: "GO")

print("Found = \(String(describing: one?.key))")
print("Found = \(String(describing: ten?.key))")
print("Found = \(String(describing: go?.key))")
print("=== END TASK 2 - [Linked List] ===")
print("\n")
print("V")
print("V")
print("V")
print("\n")
// Задание - 3
// Реализуйте класс для бинарного дерева поиска, работающий только со строками. Сделайте в нём функцию поиска.

class TreeNode<String: Equatable & Comparable> {
    
    var value: String
    
    var left: TreeNode<String>?
    var right: TreeNode<String>?
    
    init(value: String) {
        self.value = value
    }
    
    func search(for element: String ) -> TreeNode<String>? {
        var found: TreeNode<String> = self
        var current: TreeNode<String> = self
        
        while (found.value != element) {
            // if element lesser we go to left
            if element < current.value {
                if let haveLeft = current.left {
                    current = haveLeft
                } else {
                    return nil
                }
                // else we go to right
            } else {
                if let haveRight = current.right {
                    current = haveRight
                } else {
                    return nil
                }
            }
            
            found = current
        }
        return found
    }
}

print ("=== START TASK 3 - [Binary Trees] ===")
let top = TreeNode(value: "6")
let left = TreeNode(value: "3")
let right = TreeNode(value: "8")

let topLeftLeftChild = TreeNode(value: "1")
let topLeftRigitChild = TreeNode(value: "5")

let topRightLeftChild = TreeNode(value: "7")
let topRightRightChild = TreeNode(value: "GO")


top.left = left
top.right = right

left.left = topLeftLeftChild
left.right = topLeftRigitChild

right.left = topRightLeftChild
right.right = topRightRightChild

let one1 = top.search(for: "1")
let six1 = top.search(for: "6")
let go1 = top.search(for: "GO")

print("Found: " + String(describing: one1?.value))
print("Found: " + String(describing: six1?.value))
print("Found: " + String(describing: go1?.value))

print("=== END TASK 3 - [Binary Trees] ===")
print("\n")
print("V")
print("V")
print("V")
print("\n")

// Задание - 4
// Реализуйте класс для графа со станциями метро, где рёбра хранят в себе длительность переезда между двумя станциями. Сделайте в нём поиск пути (любым способом) с одной станции на другую.


// Ребро - путь в минутах до нужной станции
class Path {
    var duration: Int
    var toStation: Station
    
    init(duration: Int, toStation: Station) {
        self.duration = duration
        self.toStation = toStation
    }
}

// Вершина - станция метро
class Station {
    var name: String
    var paths: [Path]
    
    init(name: String, paths: [Path]) {
        self.name = name
        self.paths = paths
    }
    
    func searchPath(to station: Station) -> String {
        
        let toStationName = station.name
        var pathFound: Path? = nil
        
        for path in self.paths {
            if (toStationName == path.toStation.name) {
                pathFound = path
            }
            
        }
        if let pathDidFound = pathFound {
            return "От cтанции [\(self.name)] до станции [\(station.name)] ехать \(pathDidFound.duration) минут."
        }
        return "Путь не найден"
    }
}

let улица1905года = Station(name: "Улица 1905 года", paths: [])

let китайГород = Station(name: "Китай-город", paths: [
    Path(duration: 10, toStation: улица1905года)
])

let кузнецкийМост = Station(name: "Кузнецкий мост", paths: [
    Path(duration: 3, toStation: китайГород)
])

let краснопресненская = Station(name: "Краснопресненская", paths: [])
let тверская = Station(name: "Тверская", paths: [])
let баррикадная = Station(name: "Баррикадная", paths: [
    Path(duration: 3, toStation: улица1905года),
    Path(duration: 3, toStation: краснопресненская),
    Path(duration: 7, toStation: тверская)
])

let пушкинская = Station(name: "Пушкинская", paths: [
    Path(duration: 7, toStation: кузнецкийМост),
    Path(duration: 3, toStation: тверская),
    Path(duration: 4, toStation: баррикадная),
    Path(duration: 6, toStation: улица1905года)
])


print("=== START TASK 4 - [Graphs] ===")

print(пушкинская.searchPath(to: улица1905года))
print(баррикадная.searchPath(to: тверская))
print(китайГород.searchPath(to: улица1905года))

print("=== END TASK 4 - [Graphs] ===")
print("\n")
print("V")
print("V")
print("V")
print("\n")
print("=== START TASK 5 - [ARRAY SORTING] ===")


// Задание - 5
// Реализуйте функцию сортировки массива ещё двумя способами, кроме рассказанных на уроке.

extension Array where Element:Comparable {
    
    func countingSort() -> [Element] {
        var array = self
        
        var size = array.count
        var output = [Int](repeating: 0, count: size )
        var max = 0
        for elem in array {
            if (elem as! Int > max) {
                max = elem as! Int
            }
        }
        
        // Initialize count array
        var count = [Int](repeating: 0, count: max + 1)
        
        // Store the count of each elements in count array
        for i in 0..<size {
            count[array[i] as! Int] += 1
        }
        
        // Store the cummulative count
        for i in 1...max {
            count[i] += count[i - 1]
        }
        
        // Find the index of each element of the original array in count array
        // place the elements in output array
        var i = size - 1
        while i >= 0 {
            output[count[array[i] as! Int] - 1] = array[i] as! Int
            count[array[i] as! Int] -= 1
            i -= 1
        }
        
        // Copy the sorted elements into original array
        for i in 0..<size {
            array[i] = output[i] as! Element
        }
        return array
    }
    
    func insertionSort() -> [Element] {
        var array = self
        for step in 1..<array.count {
            var key = array[step]
            var j = step - 1
            
            // Compare key with each element on the left of it until an element smaller than it is found
            while j >= 0 && key < array[j] {
                array[j + 1] = array[j]
                j = j - 1
                
                // Place key at after the element just smaller than it.
                array[j + 1] = key
            }
        }
        return array
    }
}

print("Insertion sort: \([9, 5, 1, 4, 3].insertionSort())")
print("Insertion sort: \([66, 35, 10, 4, 11].insertionSort())")
print("Counting sort: \([9, 5, 1, 4, 3].countingSort())")
print("Counting sort: \([66, 35, 10, 4, 11].countingSort())")

print("=== END TASK 5 - [ARRAY SORTING] ===")
