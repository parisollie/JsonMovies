//
//  MoviesViewModel.swift
//  JsonMovies
//
//  Created by Paul Jaime Felix Flores on 31/07/24.
//

import Foundation
/*Paso 15,traemos el @MainActor porque trabajaremos en segundo plano y necesitamos que esto ejecute, para que no haya problemas viene a reemplazar lo que es el Dispatch*/
@MainActor
class MoviesViewModel: ObservableObject {
   //Paso 16),será tipo result ,por que lo despegaremos en la estructura de result
    @Published var dataMovies : [Result] = []
    //Vid  355,paso 31
    @Published var titulo = ""
    //enviaremos el id de la pelicula con esta variable.
    @Published var movieId = 0
    //Esta variable activa la ventana modal.
    @Published var show = false
    @Published var key = ""

    //Paso 17, funcion fetch , y esto debe ser asíncrono async
    func fetch(movie:String) async {
        //Paso 18, hacemos nuestro Do-Catch
        do{
            //Vid 352,ponemos un let, donde ira nuestra ruta.
            let urlString = "https://api.themoviedb.org/3/search/movie?api_key=98318564922497e017997cb6e72f5948&language=en-US&query=\(movie)&page=1&include_adult=false"
            
            //Paso 19,ponemos la url
            /* Vid 352, .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "")
             Le ponemos esto,para que pueda leer los espacios porque sino nos marcaria error : The Batman., de
             esta manera ya puede leer el espacio.*/
            guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") else { return }
            /*Paso 20 ,ponemos un let data y  try await , trata de tarerme esta api,pero espera la respuesta,pero espera.
            Cuando usamos async le debemos poner el await.*/
            let (data, _) = try await URLSession.shared.data(from: url)
            /*Paso 21,primero traemos Movies para que despleque el resultado
            trae,ponemos Movies,porque primero necesitamos entrar ahi para desplegar los resultados
             y la data que tenemos arriba, el la línea 35.*/
            let json = try JSONDecoder().decode(Movies.self, from: data)
            
            //Vid  353,paso 30, con esto llevamos el array de results.
            self.dataMovies = json.results
            
            //Vid 352,imprimimos los resultados
            print(json.results)
            
        }catch let error as NSError {
            //error.localizedDescription, nos da una descripcion del error.
            print("Error en la api: ", error.localizedDescription)
        }
    }
    //paso 39
    func fetchVideo() async {
        do{
            //para buscar la pelicula
            let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=98318564922497e017997cb6e72f5948&language=en-US"
            
            guard let url = URL(string: urlString) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            //Paso 40, ponemos el videoModel
            let json = try JSONDecoder().decode(videoModel.self, from: data)
            /*Paso 41,creamos el filtro para buscar el trailer y traéme todo lo que diga trailer y usamos un comodin $0
            para acceder , en este caso a type*/
            let res = json.results.filter({$0.type.contains("Trailer")})
            //traéme el primero que encuentres
            self.key = res.first?.key ?? ""
            
        }catch let error as NSError {
            print("Error en la api: ", error.localizedDescription)
        }
    }
    
    /*Paso 32, para el trailer es tipo result ,porque ahi viene el id.*/
    func sendItem(item: Result){
        titulo = item.original_title
        //Paso 33, le mandamos el id de la pelicula que es con lo que buscaremos a la pelicula
        movieId = item.id
        //para que se active la ventana modal.
        show.toggle()
    }

    
}
