import SwiftUI

struct DisplayIngredientsView: View {
    @EnvironmentObject private var recipeList: RecipeList
    @State private var buildButtonText = "Build Recipe"
    @State var selected: [String] = []
    @State var showWindow: Bool = false
    @State var selectedRecipe: Recipe = Recipe(name: "Grilled Cheese", ingredients: ["Bread", "Cheese", "Butter"], rating: 0, meal: "lunch")
    var body: some View {
        ZStack {
            VStack {
                    Text("Choose Ingredients").font(.title).foregroundColor(.black)
                    List(recipeList.ingredientsList().startIndex..<recipeList.ingredientsList().count, id:\.self) {
                        i in
                        let ingredient = recipeList.ingredientsList()[i]
                        HStack {
                            Text(ingredient.name).foregroundColor(.blue).padding()
                            Spacer()
                            if selected.contains(ingredient.name) {
                                Text("Selected").foregroundColor(.green)
                            } else {
                                Text("Not Selected").foregroundColor(.red)
                            }
                        }.onTapGesture(count:1) {
                            selected.append(ingredient.name)
                        }.onLongPressGesture {
                            if let index = selected.firstIndex(of:ingredient.name) {
                                selected.remove(at:index)
                            }
                        }
                    }
                Text("Recipes possible ").foregroundColor(.black).padding()
                List {
                    let possibleRecipes = recipeList.getRecipes(ingred: selected)
                    ForEach(possibleRecipes.startIndex..<possibleRecipes.count, id:\.self) {
                        i in
                        HStack {
                            Text(possibleRecipes[i].name)
                        }.onTapGesture {
                            recipeList.addRecent(recipe: possibleRecipes[i])
                            selectedRecipe = possibleRecipes[i]
                            showWindow = true
                        }.onLongPressGesture {
                            if let index = recipeList._recents.firstIndex(of:possibleRecipes[i]) {
                                recipeList._recents.remove(at:index)
                            }
                        }
                    }
                }
            }
            if showWindow == true {
                VStack(spacing: 20) {
                    Text("\(selectedRecipe.name)").font(.headline).padding()
                    List(selectedRecipe.ingredients.startIndex..<selectedRecipe.ingredients.count, id:\.self) {
                            i in
                            HStack {
                                Text("-\(selectedRecipe.ingredients[i])")
                            }
                            
                    }
                    Button(action: {showWindow = false}) {
                        Text("Close").foregroundColor(Color.red)
                    }.padding()
                }.padding().frame(width: 300, height: 400).shadow(radius:20).background(Color.white).border(Color.black, width: 2)
            }
        }
    }
    func getRecipe() {
        var ingredients: [String] = []
    }
}


