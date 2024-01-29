import SwiftUI

struct AddRecipeView: View {
    @EnvironmentObject private var recipeList: RecipeList
    @State private var recipeName: String = String()
    @State private var rating: String = String()
    @State private var meal: String = String()
    @State private var ingredient: String = String()
    @State private var allIngredients: [String] = []
    var body: some View {
        VStack {
            HStack {
                Text("Recipe Name: ")
                TextField("Recipe Name", text: $recipeName) {
                }
            }.padding()
            HStack {
                Text("Ingredients: ")
                TextField("Ingredients", text: $ingredient) {
                    allIngredients.append(ingredient)
                    recipeList.addIngredient(ing: ingredient)
                    ingredient = String()
                }
            }.padding()
            HStack {
                Text("Rating: ")
                TextField("Enter Rating 1-5", text: $rating) {
                }
                Picker("Choose Meal", selection: $meal) {
                    Text("Breakfast").tag("breakfast")
                    Text("Lunch").tag("lunch")
                    Text("Dinner").tag("dinner")
                }
            }.padding()
            VStack {
                Text("Name: \(recipeName)").font(.title).padding()
                Text("Ingrendients:")
                List {
                    ForEach(allIngredients.startIndex..<allIngredients.count, id:\.self) {
                        i in
                        HStack {
                            Text(allIngredients[i])
                        }
                    }
                }
                Text("Meal: \(meal)")
                Text("Rating: \(rating)")
               
            }
            Button("Add Recipe") {
                if (Int(rating) ?? 0) > 5 || (Int(rating) ?? 0) < 0 || Int(rating) == nil {
                    rating = "0"
                }
                let recipe = Recipe(name: recipeName, ingredients: allIngredients, rating: Int(rating) ?? 0, meal: meal)
                recipeList.addRecipe(recipe: recipe)
                recipeName = String()
                ingredient = String()
                rating = ""
                allIngredients = []
            }.padding()
            Spacer()
        }
    }
}


