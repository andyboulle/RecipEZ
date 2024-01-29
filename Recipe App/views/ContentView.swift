import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var recipeList: RecipeList
    @State private var buildButtonText = "Build Recipe"
    @State private var recipeText = "Matched Recipe"
    var body: some View {
        TabView {
            DisplayIngredientsView().environmentObject(recipeList).tabItem {
                Label("Ingredients", systemImage: "list.bullet.circle")
            }
            AddRecipeView().environmentObject(recipeList).tabItem {
                Label("Add Recipe", systemImage: "plus.circle")
            }
            RecipeHistory(rating: "5").environmentObject(recipeList).tabItem() {
                Label("History", systemImage: "clock")
            }
            SearchRecipeView().environmentObject(recipeList).tabItem() {
                Label("Search", systemImage: "magnifyingglass.circle")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @EnvironmentObject private var recipeList: RecipeList
    static var previews: some View {
        ContentView().environmentObject(RecipeList())
    }
}
