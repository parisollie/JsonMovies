//
//  CardView.swift
//  JsonMovies
//
//  Created by Paul F on 02/04/25.
//

import SwiftUI

//V-353,Paso 1.25,para poner el póster de las películas.
struct CardView: View {
    
    var poster: String
    var title: String
    var overview: String
    var action: () -> Void
    
    var body: some View {
        /*Paso 1.26, creamos la card para el póster de la imagen.
        El texto será alineado a la izquierda.
        🔹 Espaciado entre elementos*/
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(poster)")) { image in
                image.resizable()
                    .scaledToFill() // 🔹 Mejor ajuste visual
                    .frame(height: 250) // 🔹 Control del tamaño
                    .clipped() // 🔹 Evita que la imagen se desborde
                    .cornerRadius(12) // 🔹 Bordes redondeados
                    .shadow(radius: 8) // 🔹 Sombra más sutil
            } placeholder: {
                //Paso 1.27, en caso que no tengamos imagen, le ponemos la imagen de no póster que está en assets
                Image("no_poster")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(12)
                    .shadow(radius: 8)
            }

            Text(title)
                .font(.headline) // 🔹 Más compacto que .title
                .foregroundColor(.primary) // 🔹 Soporte para modo oscuro

            Text(overview)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3) // 🔹 Evita que el texto sea demasiado largo
                .multilineTextAlignment(.leading) // 🔹 Mantiene la alineación izquierda
        }
        .padding()
        .background(Color(UIColor.systemBackground)) // 🔹 Mejor integración con el fondo
        .cornerRadius(12)
        .shadow(radius: 5) // 🔹 Sombra para destacar la tarjeta
        //Paso 1.28, al momento de tocar el poster le ponemos una acción para poder mostrar el video.
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
