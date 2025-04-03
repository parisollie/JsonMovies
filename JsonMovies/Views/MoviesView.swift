//
//  MoviesView.swift
//  JsonMovies
//
//  Created by Paul Jaime Felix Flores on 31/07/24.
//

import SwiftUI

struct MoviesView: View {
    //V-350,paso 1.7,nuestros párametros 
    var movie : String
    //Paso 1.22,ponemos movies a nuestro modelo.
    @StateObject var movies = MoviesViewModel()
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                List{
                    //Paso 1.30, dataMovies viene de MoviesViewModel
                    ForEach(movies.dataMovies){ item in
                        /*Ponemos la CardView y le ponemos vacio "", porque ya tenemos el opcional.
                         de si viene o no el poster.*/
                        CardView(poster: item.poster_path ?? "", title: item.original_title, overview: item.overview) {
                            //V-355,Paso 1.35,le mandamos el item donde va toda la informacion
                            movies.sendItem(item: item)
                        }
                        //Paso 1.36, le ponemos que lo active con .show
                        .sheet(isPresented: $movies.show) {
                            //Paso 1.37,Es el contenido enviaremos movies que es tipo MoviesViewModel el tipo de dato.
                            TrailerView(movies: movies)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                               .background(Color.clear)
            }
            .navigationTitle(movie)
            //Paso 1.23,para poder ejecutar ponemos Task para ejecutar una tarea asíncrona
            .task {
                //Paso 1.24,y le ponemos nuestro parámetro movie ,que viene desde el buscador.
                await movies.fetch(movie: movie)
            }
        }
    }
}



#Preview {
    MoviesView(movie: "Inception")
        .environmentObject(MoviesViewModel()) // Asegura que el ViewModel esté disponible
}

