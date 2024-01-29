import Foundation


import SwiftUI

struct SearchRecipeView: View {
    
    @EnvironmentObject var recipeList: RecipeList
    @State var recipeName: String = String()
    @State var recipe: Recipe = Recipe(name: "", ingredients: [], rating: 0, meal: "")
    
    var body: some View {
        VStack {
            HStack {
                Text("Recipe Name: ")
                TextField("Recipe Name", text: $recipeName) {
                }
            }.padding()
            Button("Search") {
                recipe = recipeList.searchRecipe(name: recipeName) ?? Recipe(name: "", ingredients: [], rating: 0, meal: "")
                recipeName = ""
            }.padding()
            Spacer()
            Text("Name: \(recipe.name)").foregroundColor(.blue).padding()
            Text("Meal: \(recipe.meal)").foregroundColor(.blue).padding()
            Text("Rating: \(recipe.rating)").foregroundColor(.blue).padding()
            List(recipe.ingredients.startIndex..<recipe.ingredients.count, id:\.self) {
                    i in
                    HStack {
                        Text(recipe.ingredients[i]).foregroundColor(.blue).padding()
                        Spacer()
                    }
                    
            }
            
        }
    }
    
    
}
