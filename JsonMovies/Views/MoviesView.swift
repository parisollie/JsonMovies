//
//  MoviesView.swift
//  JsonMovies
//
//  Created by Paul Jaime Felix Flores on 31/07/24.
//

import SwiftUI

struct MoviesView: View {
    //paso 7) nuestros parametros 
    var movie : String
    //Paso 22,ponemos movies a nuestro modelo.
    @StateObject var movies = MoviesViewModel()
    
    
    var body: some View {
        VStack{
            List{
                //Paso 29, dataMovies viene de MoviesViewModel
                ForEach(movies.dataMovies){ item in
                    //Paso 30, ponemos la CardView y le ponemos vacio "", porque ya tenemos el opcional.
                    //de si viene o no el poster.
                    CardView(poster: item.poster_path ?? "", title: item.original_title, overview: item.overview) {
                        //Paso 35,le mandamos el item donde va toda la informacion
                        movies.sendItem(item: item)
                    }
                    //Paso 36, le ponemos que lo active con .show
                    .sheet(isPresented: $movies.show) {
                        //Paso 37,Es el contenido enviaremos movies que es tipo MoviesViewModel el tipo de dato.
                        TrailerView(movies: movies)
                    }
                }
            }
        }.navigationTitle(movie)
        //Paso 23,para poder ejecutar ponemos Task
        .task {
            //paso 24,y le ponemos nuestro parámetro movie ,que viene desde el buscador.
            await movies.fetch(movie: movie)
        }
    }
}

//Vid 353,Paso 25,para poner el póster de las películas.
struct CardView: View {
    
    var poster : String
    var title : String
    var overview: String
    var action : () -> Void
    
    var body: some View {
        //Paso 26, creamos la card para el póster de la imágen.
        //El texto será alineado a la izqierda.
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(poster)")){ image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 5)
            }placeholder: {
                //Paso 27, en caso que no tengamos imagén,le ponemos la imagén de no póster esta en assets
                Image("no_poster")
            }
            Text(title)
                .font(.title)
            Text(overview)
                .foregroundColor(.gray)
        }.padding(.all)
        //Paso 28, al momento de tocar le ponemos una acción para poder mostrar el video.
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    MoviesView(movie: "Inception")
        .environmentObject(MoviesViewModel()) // Asegura que el ViewModel esté disponible
}

