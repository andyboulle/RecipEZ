import Foundation

struct Ingredient: Hashable {
    var name: String
    var selected: Bool = false
}
struct Recipe: Hashable {
    var name: String
    var ingredients: [String] = []
    var rating:Int
    var meal:String
}

class RecipeList: ObservableObject {
    @Published var _allRecipes: [Recipe] = [
        Recipe(name: "Grilled Cheese", ingredients: ["Bread", "Cheese", "Butter"], rating: 0, meal: "lunch"),
        Recipe(name: "Beef Tacos", ingredients: ["Tortillas", "Ground Beef", "Cheese", "Lettuce"], rating: 0, meal: "dinner"),
        Recipe(name: "Chicken Quesadilla", ingredients: ["Tortillas","Chicken", "Cheese", "Butter"], rating: 0, meal: "dinner"),
        Recipe(name: "Chicken Dinner", ingredients: ["Chicken", "Rice"], rating: 0, meal: "dinner"),
        Recipe(name: "Bacon Cheeseburger", ingredients: ["Buns", "Ground Beef", "Cheese", "Bacon"], rating: 0, meal: "dinner")
    ]
    @Published var _allIngredients: [Ingredient] = [
        Ingredient(name:"Bread"),
        Ingredient(name:"Tortillas"),
        Ingredient(name:"Buns"),
        Ingredient(name:"Chicken"),
        Ingredient(name:"Ground Beef"),
        Ingredient(name:"Butter"),
        Ingredient(name:"Lettuce"),
        Ingredient(name:"Cheese"),
        Ingredient(name:"Bacon"),
        Ingredient(name:"Rice")
    ]
    
    @Published var _recents: [Recipe] = []
    
    func addRecipe(recipe: Recipe) {
        _allRecipes.append(recipe)
    }
    
    func addRecent(recipe: Recipe) {
        if _recents.contains(recipe) == false {
            _recents.append(recipe)
        }
    }
    
    func searchRecipe(name: String) -> Recipe? {
        for r in _allRecipes {
            if r.name == name {
                return r
            }
        }
        return nil
    }
    
    func addIngredient(ing: String) {
        let i = Ingredient(name:ing)
        if let index = _allIngredients.firstIndex(of:i) {
            _allIngredients.remove(at:index)
        }
        _allIngredients.append(i)
    }
    
    func getRecipes(ingred: [String]) -> [Recipe] {
        var canBeMade: [Recipe] = []
        let ingredSet = Set(ingred)
        for r in _allRecipes {
            let currIngredSet = Set(r.ingredients)
            if currIngredSet.isSubset(of: ingredSet) {
                canBeMade.append(r)
            }
        }
        return canBeMade
    }
    
    func getCreatedRecipes() -> [Recipe] {
        return _allRecipes
    }
    
    func getCreatedBreakfastRecipes() -> [Recipe] {
        var bfast:[Recipe] = []
        for i in _recents.startIndex..<_recents.count{
            if _recents[i].meal == "breakfast" {
                bfast.append(_recents[i])
            }
        }
        return bfast
    }
    
    func getCreatedLunchRecipes() -> [Recipe] {
        var lunch:[Recipe] = []
        for i in _recents.startIndex..<_recents.count {
            if _recents[i].meal == "lunch" {
                lunch.append(_recents[i])
            }
        }
        return lunch
    }
    
    func getCreatedDinnerRecipes() -> [Recipe] {
        var dinner:[Recipe] = []
        for i in _recents.startIndex..<_recents.count {
            if _recents[i].meal == "dinner" {
                dinner.append(_recents[i])
            }
        }
        return dinner
    }
    
    func ingredientsList() -> [Ingredient] {
        return _allIngredients
    }
}
