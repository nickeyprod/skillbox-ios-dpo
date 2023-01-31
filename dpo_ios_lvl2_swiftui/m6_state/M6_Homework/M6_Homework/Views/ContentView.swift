import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        if let safeData = viewModel.animalsData {
            NavigationView {
                List {
                    ForEach(safeData) { animal in                        NavigationLink {
                            DetailsView().environmentObject(animal)
                        } label: {
                            Text(animal.name)
                        }
                        
                    }
                }
                .navigationTitle("Animals")
                
            }.environmentObject(viewModel)
        } else {
            if !viewModel.loadingDataError {
                Text("Загрузка…")
                ProgressView()
            } else {
                Text("Ошибка!").padding(10)
                Button("Обновить данные") {
                    viewModel.reload()
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(service: UnstableNetworkService()))
    }
}
