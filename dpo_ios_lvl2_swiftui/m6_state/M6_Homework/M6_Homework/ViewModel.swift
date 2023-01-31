import Foundation

final class ViewModel: ObservableObject {
    
    private let service: UnstableNetworkService
    
    @Published var animalsData: [Animal]?
    @Published var loadingDataError: Bool = false
    
    init(service: UnstableNetworkService) {
        self.service = service
        loadData()
    }
    
    private func loadData() {
        service.getData { result in
            self.animalsData = result
        } failure: { error in
            self.loadingDataError = true
        }
    }
    
    public func reload() {
        self.loadingDataError = false
        loadData()
    }
}
