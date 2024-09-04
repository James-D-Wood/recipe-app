//
//  RecipeListView.swift
//  Health and Wellness
//
//  Created by James Wood on 3/3/24.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeListViewModel
    let title: String
    let filter: String?
    var body: some View {
        
        VStack {
            switch viewModel.state {
            case .loading:
                Text("Loading")
            case .failed(let error):
                Text("Error: \(error)")
            default:
                List {
                    ForEach(viewModel.recipes) { recipe in
                        // TODO: implement tags on the backend
                        // none exist at the moment
                        if (filter == nil ||
                                recipe.tags == nil ||
                                recipe.tags!.contains(filter!)
                            ) {
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                Text(recipe.name)
                            }
                        }
                    }
                }
                .navigationTitle(title)
            }
        }
        .onAppear {
            print("onAppear called")
            Task {
                await viewModel.load()
                print("view model loaded")
            }
        }
    }
}
    

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(
            viewModel: RecipeListViewModel(),
            title: "Recipes",
            filter: "dinner"
        )
    }
}
