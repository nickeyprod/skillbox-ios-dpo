//: [Previous](@previous)

import Combine
import Foundation

// Задание - 2

// Сделайте запрос при помощи Publisher для URLSession:
// 1 Добавьте новую страницу в Playground из предыдущего задания (File → New → Playground Page).
// 2 Сделайте запрос с помощью Publisher для URLSession к любому веб-ресурсу. В консоль требуется вывести код ответа сервера.
// 3 Обработайте ошибку запроса, выведя в консоль сообщение об ошибке, если публикация завершилась неудачей.
// 4 Попробуйте указывать разные URL для запроса и проверьте, что ваш pipeline работает корректно: при успешном запросе выводится код ответа, при провале — ошибка.
// 5 Объявите собственный тип ошибки и при возникновении ошибки в pipeline заменяйте её на свой тип. Проверьте, что при завершении публикации ошибкой в консоли выводится ошибка вашего типа.

let successURL = URL(string: "http://www.ya.ru")!
let url404 = URL(string: "http://www.skillbox.ru/1")!
let failureURL = URL(string: "http://unknown/unknown")!

enum MyError: Error {
    case wrongResponse
    case wrongStatusCode
    case myCustomError(Error)
}

let subscription = URLSession.shared.dataTaskPublisher(for: successURL)
    .mapError{
        MyError.myCustomError($0)
    }
    .tryMap{ tuple -> Int in
        guard let response = tuple.response as? HTTPURLResponse else {
            throw MyError.wrongResponse
        }
        if response.statusCode != 200 {
            throw MyError.wrongStatusCode
        }
        return response.statusCode
    }
    
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("finished")
        case .failure(error: let error):
            print("finished with error: \(error)")
        }
    }, receiveValue: { value in
        print(value)
    })

//: [Next](@next)

