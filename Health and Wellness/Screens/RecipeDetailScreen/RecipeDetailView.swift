//
//  RecipeDetailView.swift
//  Health and Wellness
//
//  Created by James Wood on 3/3/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack{
            Spacer()
            Text(recipe.name)
                .font(.title)
            Text(recipe.serves != nil
                 ? "Serves: \(recipe.serves!)"
                 : ""
            )
            ForEach(recipe.ingredients) { ingredient in
                Text(ingredient.displayText)
            }
            Spacer()
            Button {
                print("button click")
            } label: {
                Text("Add to Grocery List")
            }
            
            if recipe.url != nil {
                // TODO: decide whether to use UIViewControllerRepresentable for an embedded SafariView
                Link("Visit Recipe", destination: URL(string: recipe.url!)!)
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let randomIndex = Int.random(in: 0..<MockData.sampleRecipes.count)
        RecipeDetailView(recipe: MockData.sampleRecipes[randomIndex])
    }
}
