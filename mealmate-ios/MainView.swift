import SwiftUI

struct MainView: View {
    
    let viewModel: AppViewModel
    var body: some View {
        TabView {
            RefrigeratorView(viewModel: viewModel)
                .tabItem {
                    Label("Kühlschrank", systemImage: "refrigerator.fill")
                }
            RecipesView(viewModel: viewModel)
                .tabItem {
                    Label("Rezepte", systemImage: "menucard")
                }
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Label("Profil", systemImage: "person")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: AppViewModel(fridgeItems: []))
    }
}
