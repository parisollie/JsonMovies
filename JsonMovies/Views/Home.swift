//
//  Home.swift
//  JsonMovies
//
//  Created by Paul Jaime Felix Flores on 31/07/24.
//


import SwiftUI
//Vid 349
struct Home: View {
    //Vid 350,paso 4), ponemos 2 variables, para buscar.
    @State private var search = ""
    /*Aqui mandaremos a llamar a la siguiente vista, pero sin utilizar un tipo de valor como lo hacemos
    con el NavigationStack*/
    @State private var buscar = false
    
    var body: some View {
       //Paso 2
        NavigationStack{
            ZStack {
                //Paso 3,haremos un degradado con este código.
                //.top, endPoint: .bottom, donde inicia y donde termina el degradado.
                LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                //Vid 350,nueva navegación.
                VStack{
                    //Paso 5, creamos el texfield y ponemos el binding de search.
                    TextField("Search", text: $search)
                    //Paso 10, le ponemos estilos al TextField.
                        .textFieldStyle(.roundedBorder)
                    //para que no este tan pegado arriba le ponemos top
                        .padding(.top, 15)
                        .padding(.bottom, 20)
                        //.OnAppear,para poder borrar la última búsqueda.
                        .onAppear{
                            search = ""
                        }
                    //Paso 6),ponemos nuestro botón.
                    Button {
                        buscar.toggle()
                    } label: {
                        Text("Search")
                            .font(.title2)
                            .bold()
                    }
                    //Paso 11, diseños al botón.
                    .buttonStyle(.bordered)
                    .tint(.white)
                    //el spacer es para que me lo mueve hacia arriba
                    Spacer()
                    /*Paso 8, ponemos el .navigationDestination, es como si fuera el navigationLink,pero ahora será este.
                     is presented, para activarlo como un booleano
                     ,para sin preocuparnos por enviar un dato*/
                    .navigationDestination(isPresented: $buscar) {
                        //Paso 9,ponemos nuestra vista y el search que declaramos anteriormente.
                        MoviesView(movie: search)
                    }
                    //Paso 12, ponemos un padding all y le ponemos su título.
                }.padding(.all)
                    .navigationTitle("App Movie Search")
            }
        }
    }
}

#Preview {
    Home()
}
