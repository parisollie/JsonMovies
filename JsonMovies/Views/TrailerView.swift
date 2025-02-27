//
//  TrailerView.swift
//  JsonMovies
//
//  Created by Paul Jaime Felix Flores on 31/07/24.
//


import SwiftUI
//Vid 357 ,incrustacion de un video.
import WebKit
struct TrailerView: View {
    
    /*p1aso 34, esperamos que esto funcione como parámetro que seria lo mismo que -var id : string-
    espera un MoviesViewModel como dato*/
    @StateObject var movies : MoviesViewModel
    
    
    var body: some View {
        //Paso 43, ponemos el video.
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VideoView(videoID: movies.key)
            //Para que nos ponga el video centrado en la vista.
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3 )
                .cornerRadius(12)
                .padding(.all)
                .task {
                    //Paso 44
                    await movies.fetchVideo()
                }
        }
    }
}

//Vid 357-Paso 42,incrustar un video de yotube en nuestra app

struct VideoView: UIViewRepresentable {
    
    let videoID : String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //(embed)para incurstar nuestro video,le ponemos la URL de Yotube
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url:url))
    }
    
}



#Preview {
    TrailerView(movies: MoviesViewModel()) // Se pasa un objeto MoviesViewModel
}

