//
//  CardView.swift
//  JsonMovies
//
//  Created by Paul F on 02/04/25.
//

import SwiftUI

//V-353,Paso 1.25,para poner el póster de las películas.
struct CardView: View {
    
    var poster : String
    var title : String
    var overview: String
    var action : () -> Void
    
    var body: some View {
        /*Paso 1.26, creamos la card para el póster de la imágen.
        El texto será alineado a la izqierda.*/
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(poster)")){ image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 15)
            }placeholder: {
                //Paso 1.27, en caso que no tengamos imagén,le ponemos la imagén de no póster esta en assets
                Image("no_poster")
            }
            Text(title)
                .font(.title)
            Text(overview)
                .foregroundColor(.blue)
        }
        .padding(.all)
        //Paso 1.28, al momento de tocar le ponemos una acción para poder mostrar el video.
        .onTapGesture {
                action()
        }
    }
}

#Preview {
    CardView(
        poster: "no_poster",
        title: "Sample Movie",
        overview: "This is a sample movie description.",
        action: {}
    )
}
