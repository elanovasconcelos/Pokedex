//
//  ListDetailView.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import SwiftUI
import CachedAsyncImage

struct ListDetailView: View {
    
    @StateObject var viewModel: ViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
        
    var body: some View {
        ScrollView {
            VStack {
                title
                if horizontalSizeClass == .compact && verticalSizeClass == .regular { //portrait
                    image
                    detail
                } else {
                    HStack {
                        image
                        detail
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                favoriteButton
            }
        }
    }
}

private extension ListDetailView {
    var title: some View {
        Text(viewModel.title)
            .accessibilityIdentifier("ListDetailView_Title")
            .font(.title)
            .padding()
    }
    
    var image: some View {
        CachedAsyncImage(url: URL(string: viewModel.imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(maxWidth: 200, maxHeight: 200)
            case .failure:
                Image.noImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            @unknown default:
                EmptyView()
            }
        }
        .padding()
    }
    
    var detail: some View {
        VStack {
            Text(viewModel.baseExperience)
            Text(viewModel.height)
            Text(viewModel.weight)
            Text(viewModel.abilities)
            Text(viewModel.type)
        }
        .font(.headline)
    }
    
    var favoriteButton: some View {
        Button(action: {
            Task {
                await viewModel.toggleFavorite()
            }
        }) {
            Image(systemName: viewModel.favoriteImage)
                .foregroundColor(viewModel.favoriteColor)
        }
    }
}

//#Preview {
//    ListDetailView()
//}
