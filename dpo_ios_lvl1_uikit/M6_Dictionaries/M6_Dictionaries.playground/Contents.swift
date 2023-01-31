import Foundation

// Задание 1
let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

// Получить по названию дня недели его номер
let dict = [
    "Monday": 1,
    "Tuesday": 2,
    "Wednesday": 3,
    "Thursday": 4,
    "Friday": 5,
    "Saturday": 6,
    "Sunday": 7
]

dict[days[0]]
dict[days[6]]

// MARK: -
// Задание 2
for (key, value) in dict {
    print("\(key) at num \(value)" )
}
// MARK: -
// Задание 3

let userPasswords = [
    "Вася": "12345678",
    "Вадим": "dG4sfsgs",
    "G0BLIN": "Gh444t6gt"
]

// MARK: -
// Задание 4
enum CustomError: Error, LocalizedError {
    case invalidPassword
    case userNotFound
    case invalidUsername(Character)
    
    public var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return "Неправильный пароль"
        case .userNotFound:
            return "Пользователь не найден"
        case let .invalidUsername(char):
            return "Неверный символ в имени - \(char)"
        }
    }
}

// MARK: -
// Задание 5
func validate(name: String, pass: String) throws {
    for character in name {
        guard character.isLetter else {
            throw CustomError.invalidUsername(character)
        }
    }
    
    if let userFound = userPasswords[name] {
        print("Вход успешный, \(name)")
    } else {
        throw CustomError.userNotFound
    }
}

// MARK: -
// Задание 6
func onUserInputName(username: String, password: String) {
    print((try? validate(name: username, pass: password)) == nil)
}

func onUserInputName2(username: String, password: String) {
    do {
        try validate(name: username, pass: password)
    } catch {
        print(error.localizedDescription)
    }
        
}

onUserInputName(username: "Вася", password: "12345678")
onUserInputName2(username: "Вася", password: "12345678")

onUserInputName(username: "Маша23", password: "1678")
onUserInputName2(username: "Маша23", password: "54746gd")

onUserInputName(username: "Маша", password: "1678")
onUserInputName2(username: "Маша", password: "54746gd")
