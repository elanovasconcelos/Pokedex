//
//  ListView.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import SwiftUI
import CachedAsyncImage

struct ListView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Group {
            if viewModel.pokemons.isEmpty {
                ProgressView()
                    .scaleEffect(2)
            } else {
                list
            }
        }
        .navigationTitle("Pokemons")
        .task {
            await viewModel.onAppear()
        }
    }
    
    var list: some View {
        List(viewModel.pokemons) { pokemon in
            ListItem(pokemon: pokemon)
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.didSelect(pokemon: pokemon)
            }
            .onAppear {
                Task {
                    await viewModel.tryLoadNextPage(currentPokemon: pokemon)
                }
            }
        }
    }
}

private struct ListItem: View {
    let pokemon: Pokemon

    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: pokemon.spriteUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                case .failure:
                    Image.noImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(25)
            
            Text(pokemon.name.capitalized)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .accessibilityIdentifier("ListView_ListItem_\(pokemon.id)")
    }
}

//#Preview {
//    ListView(viewModel: ListView.ViewModel())
//}
