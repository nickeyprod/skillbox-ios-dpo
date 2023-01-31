import SwiftUI

/// реализуйте протокол Identifiable
/// для работы с линивой загрузкой
/// добавте для генерация уникального id
/// свойтсво let id = UUID()
struct Breed {
    let name: String
    let url: String
}

struct Animal: Identifiable {
    let id = UUID()
    let name: String
    var url: String?
    var breeds: [Animal]?
}

struct DataAnimals {
    let animals = [
        Animal(name: "Dog", breeds: [Animal(name: "Bulldog", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4C9uK0aKifAP_AzqJ751RA5_7utMqagTz1A&usqp=CAU"), Animal(name: "German Shepard", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAO0MSHjt7Wb7qb2fz7DgL5IHNVYJcdSflSg&usqp=CAU"), Animal(name: "Golden Retriever", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5A-lNMgybyri7ojG0yV6J7CWKqKzkQq8P0w&usqp=CAU")]),
        
        Animal(name: "Cat", breeds: [Animal(name: "Siamese", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROFy7QQMPzdltjgsTeFw5soa5Klpv5FzqF9A&usqp=CAU"), Animal(name: "Persian", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-aqtzNhR8u2YIA_O-OsLUD-njmn-MH_fCkQ&usqp=CAU"), Animal(name: "Bengal", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt_0FZPO3mhHPoG21BkDdXT14JZlGe4BrM2w&usqp=CAU")]),
        Animal(name: "Bird", breeds: [Animal(name: "Parrot", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFFWnfpSNcwer4KoAvM9ehTxfFVUnvVPRWhw&usqp=CAU"), Animal(name: "Dove", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWIcWaThzhxzDLFf8SMLHmlqmO-wpWxBrsPA&usqp=CAU"), Animal(name: "Finch", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxEld8cLhXGjTNXm9buaIT0pmNdLkOV-MneQ&usqp=CAU")])
    ]
}
