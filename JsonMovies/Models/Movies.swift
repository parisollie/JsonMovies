//
//  MoviesViewModel.swift
//  JsonMovies
//
//  Created by Paul Jaime Felix Flores on 31/07/24.
//

//------------------------------------Vid 351, estructura para el JSON ---------------------------------------------

import Foundation

/*Protocolo Codable lo códifica a un JSON o un JSON lo códifica a esto. */

//Usamos struct, para estructuras.
struct Movies: Codable {
    /*V-351,Paso 1.13,necesitamos entrar primero a page y luego a results, por eso ponemos estas variables de acuerdo al
    al JSON que modificamos.*/
    let page: Int
    //manda a llamar otra estructura llamada [Result] del JSON
    let results: [Result]
}

// MARK: - Result
//Paso 1.14, le ponemos Identifiable, para que lo podamos usar en un forEach y siempre debe ir id que es un int.
struct Result: Codable, Identifiable {
    //Los campos que usaremos son estos y deben llamarse como estan en la api.
    let id: Int
    let original_title : String
    //Vid 352,le pone opcional(?) porque no sabe si vendra ese dato o no , a veces las apis no tienen todos los datos.
    let poster_path : String?
    //sipnosis
    let overview : String
}

//------------------------------------------------- Videos -------------------------------------------------

//V-356,Paso 1.38,para los trailers, hacemos una nueva structora JSON ,para poder revisar los videos.
struct videoModel: Codable {
    let id: Int
    let results: [videoResult]
}

struct videoResult: Codable{
    let key : String
    //type para hacer filtro de todos los que digan trailer 
    let type : String
}

