import SwiftUI

@main
struct Recipe_AppApp: App {
    @StateObject var recipeList: RecipeList = RecipeList()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(recipeList)
        }
    }
}
