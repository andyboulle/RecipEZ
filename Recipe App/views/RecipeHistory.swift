import Foundation
import SwiftUI

struct RecipeHistory: View {
    @EnvironmentObject private var recipeList: RecipeList
    @State var selectedRecipe: Recipe = Recipe(name: "Grilled Cheese", ingredients: ["Bread", "Cheese", "Butter"], rating: 0, meal: "lunch")
    @State var rating: String
    @State var showWindow: Bool = false
    var body: some View {
        ZStack {
            VStack {
                Text("Recently Created Recipes").font(.title)
                VStack {
                    Text("Breakfast").font(.headline)
                    List((recipeList.getCreatedBreakfastRecipes().startIndex..<recipeList.getCreatedBreakfastRecipes().count).reversed(), id:\.self) {
                        i in
                        HStack {
                            Text(recipeList.getCreatedBreakfastRecipes()[i].name).foregroundColor(.blue).padding()
                            Spacer()
                            Text("Rating: \(recipeList.getCreatedBreakfastRecipes()[i].rating)")
                        }.onTapGesture {
                            selectedRecipe = recipeList.getCreatedBreakfastRecipes()[i]
                            showWindow = true
                        }
                    }
                    
                    Text("Lunch").font(.headline)
                    List((recipeList.getCreatedLunchRecipes().startIndex..<recipeList.getCreatedLunchRecipes().count).reversed(), id:\.self) {
                        i in
                        HStack {
                            Text(recipeList.getCreatedLunchRecipes()[i].name).foregroundColor(.blue).padding()
                            Spacer()
                            Text("Rating: \(recipeList.getCreatedLunchRecipes()[i].rating)")
                        }.onTapGesture {
                            selectedRecipe = recipeList.getCreatedLunchRecipes()[i]
                            showWindow = true
                        }
                    }
                    
                    Text("Dinner").font(.headline)
                    List((recipeList.getCreatedDinnerRecipes().startIndex..<recipeList.getCreatedDinnerRecipes().count).reversed(), id:\.self) {
                        i in
                        HStack {
                            Text(recipeList.getCreatedDinnerRecipes()[i].name).foregroundColor(.blue).padding()
                            Spacer()
                            Text("Rating: \(recipeList.getCreatedDinnerRecipes()[i].rating)")
                        }.onTapGesture {
                            selectedRecipe = recipeList.getCreatedDinnerRecipes()[i]
                            showWindow = true
                        }
                    }
                }
            }
            if showWindow == true {
                VStack {
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
    
    
}

