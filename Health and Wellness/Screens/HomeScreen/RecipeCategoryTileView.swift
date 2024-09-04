//
//  RecipeCategoryTileView.swift
//  Health and Wellness
//
//  Created by James Wood on 3/3/24.
//

import SwiftUI



struct RecipeCategoryTileView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    let categories = [
        RecipeCategory(title: "breakfast", imageURI: "https://insanelygoodrecipes.com/wp-content/uploads/2020/12/Chocolate-Chip-Pancakes.png"),
        RecipeCategory(title: "lunch", imageURI: "https://hips.hearstapps.com/hmg-prod/images/fully-loaded-veggie-sandwiches-6553977868999.jpg?crop=1.00xw:0.669xh;0,0.162xh&resize=640:*"),
        RecipeCategory(title: "dinner", imageURI: "https://cookingwithcocktailrings.com/wp-content/uploads/2016/05/Cedar-Plank-Salmon-with-Brown-Sugar-and-Black-Pepper-39-scaled.jpg"),
        RecipeCategory(title: "appetizer", imageURI: "https://www.thespruceeats.com/thmb/J_U7tE2Sw-1Mhg3Dg4l9Wde4kIs=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/devils-on-horseback-478714-hero-01-799b6f22a95b4c1a881bc96ea47bbd22.jpg"),
        RecipeCategory(title: "dessert", imageURI: "https://realfood.tesco.com/media/images/RFO-1400x919-classic-chocolate-mousse-69ef9c9c-5bfb-4750-80e1-31aafbd80821-0-1400x919.jpg"),
        RecipeCategory(title: "cocktail", imageURI: "https://hips.hearstapps.com/hmg-prod/images/delish-230412-maitai-0735-ns-index-644ae01d67be5.jpg?crop=0.8888888888888888xw:1xh;center,top&resize=1200:*"),
    ]
            
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Recipe Categories")
                        .font(.title3)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .fontWeight(.bold)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(categories, id: \.title) {
                            category in
                            NavigationLink {
                                RecipeListView(
                                    viewModel: RecipeListViewModel(),
                                    title: "\(category.title.capitalized) Recipes",
                                    filter: category.title)
                                
                            } label: {
                                CategoryTile(category: category)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
    
struct CategoryTile: View {
    let category: RecipeCategory
    
    var body: some View {
        AsyncImage(
            url: URL(string: category.imageURI),
            content: { image in
                ZStack {
                    image
                        .resizable()
                        .frame(width: 175, height: 125)
                        .aspectRatio(contentMode: .fill)
                        
                   
                    HStack(alignment: .bottom) {
                        Text(category.title.capitalized)
                            .frame(
                                maxWidth: .infinity
                            )
                            .padding(7.5)
                            .background(Color(.systemBackground))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.label))
                            
                    }
                    .frame(
                        maxWidth: .infinity, maxHeight: .infinity,
                        alignment: .bottom
                    )
                    
                }
                .frame(width: 175, height: 125)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                        .stroke(.gray, lineWidth: 1)
                )


            },
            placeholder: {
                Text("Loading...")
            }
        )
    }
}

struct RecipeCategoryTileView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryTileView()
    }
}
