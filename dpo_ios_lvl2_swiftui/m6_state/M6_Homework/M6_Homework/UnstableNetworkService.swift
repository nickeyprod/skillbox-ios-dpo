import Combine
import Foundation

class UnstableNetworkService {
    private var cancellables: Set<AnyCancellable> = []
    
    func getData(
        success: @escaping ([Animal]) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        Just(())
            .delay(for: .seconds(2), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
            .tryMap { response -> [Animal] in
                let success = Bool.random()
                if success {
                    return DataAnimals().animals
                } else {
                    throw ServiceError.noService
                }
            }
            .eraseToAnyPublisher()
            .sink { completion in
                if case .failure = completion {
                    failure(ServiceError.noService)
                }
            } receiveValue: { data in
                success(data)
            }
            .store(in: &cancellables)
    }
}

enum ServiceError: Error {
    case noService
}

struct Breed: Identifiable {
    let name: String
    let url: String
    let id = UUID()
}

class Animal: Identifiable, ObservableObject {
    let name: String
    let breeds: [Breed]
    let id = UUID()
    
    init(name: String, breeds: [Breed]) {
        self.name = name
        self.breeds = breeds
    }
}

struct DataAnimals {
    let animals = [
        Animal(name: "Dog", breeds: [Breed(name: "Bulldog", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4C9uK0aKifAP_AzqJ751RA5_7utMqagTz1A&usqp=CAU"), Breed(name: "German Shepard", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAO0MSHjt7Wb7qb2fz7DgL5IHNVYJcdSflSg&usqp=CAU"), Breed(name: "Golden Retriever", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5A-lNMgybyri7ojG0yV6J7CWKqKzkQq8P0w&usqp=CAU")]),
        Animal(name: "Cat", breeds: [Breed(name: "Siamese", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROFy7QQMPzdltjgsTeFw5soa5Klpv5FzqF9A&usqp=CAU"), Breed(name: "Persian", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-aqtzNhR8u2YIA_O-OsLUD-njmn-MH_fCkQ&usqp=CAU"), Breed(name: "Bengal", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt_0FZPO3mhHPoG21BkDdXT14JZlGe4BrM2w&usqp=CAU")]),
        Animal(name: "Bird", breeds: [Breed(name: "Parrot", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFFWnfpSNcwer4KoAvM9ehTxfFVUnvVPRWhw&usqp=CAU"), Breed(name: "Dove", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWIcWaThzhxzDLFf8SMLHmlqmO-wpWxBrsPA&usqp=CAU"), Breed(name: "Finch", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxEld8cLhXGjTNXm9buaIT0pmNdLkOV-MneQ&usqp=CAU")])
    ]
}
