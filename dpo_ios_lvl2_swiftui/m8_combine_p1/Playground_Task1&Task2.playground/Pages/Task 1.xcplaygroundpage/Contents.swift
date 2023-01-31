import Combine

// Задание - 1

// Выведите в консоль пять случайных чисел от 1 до 100 с помощью Combine:
// 1 Создайте новый Swift Playground в Xcode, в качестве шаблона можно использовать blank.
// 2 Создайте последовательность случайных чисел из пяти элементов.
// 3 Воспользуйтесь Publisher последовательности и подпишитесь на него.
// 4 Запустите код и проверьте, что он работает корректно.

let publisher = [
    Int.random(in: 1...100),
    Int.random(in: 1...100),
    Int.random(in: 1...100),
    Int.random(in: 1...100),
    Int.random(in: 1...100)
].publisher

let subscription = publisher.sink(receiveCompletion: { _ in
    print("finished")
}, receiveValue: { value in
    print(value)
})
