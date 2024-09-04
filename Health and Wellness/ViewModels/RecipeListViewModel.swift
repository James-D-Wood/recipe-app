//
//  RecipeListViewModel.swift
//  Health and Wellness
//
//  Created by James Wood on 8/18/24.
//

import Foundation

/// RecipeListViewModel is a class that represents the data needed by the RecipeListView
/// Handles the data fetching for recipes from the api.jameswood.dev backend
/// implementation inspired by https://peterfriese.dev/blog/2021/swiftui-concurrency-essentials-part1/
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = MockData.sampleRecipes
    @Published var state = LoadingState.idle
    
    @MainActor
    func load() async {
        state = .loading
        
        // load recipes
        let url = URL(string: "https://api.jameswood.dev/api/v1/recipes")!
        let client = HTTPClient()
        do {
            let resp = try await client.get(url: url)
            let results = try JSONDecoder().decode([Recipe].self, from: resp.body!)
            state = .loaded
            recipes = results
        } catch {
            state = .failed("\(error)")
        }
    }
}
