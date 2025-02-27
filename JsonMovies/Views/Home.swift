//
//  Home.swift
//  JsonMovies
//
//  Created by Paul Jaime Felix Flores on 31/07/24.
//


import SwiftUI
//V-349,creamos la vista Home
struct Home: View {
    //V-350,Paso 1.4, ponemos 2 variables, para buscar.
    @State private var search = ""
    /*
       Aqui mandaremos a llamar a la siguiente vista, pero sin utilizar un tipo de valor como lo hacemos
    con el NavigationStack*/
    @State private var buscar = false
    
    var body: some View {
       //V-349,Paso 1.2
        NavigationStack{
            ZStack {
                //Paso 1.3,haremos un degradado con este código.
                //.top, endPoint: .bottom, donde inicia y donde termina el degradado.
                LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                //V-350,nueva navegación.
                VStack{
                    //Paso 1.5, creamos el texfield y ponemos el binding de search.
                    TextField("Search", text: $search)
                        //Paso 1.10, le ponemos estilos al TextField.
                        .textFieldStyle(.roundedBorder)
                        //para que no este tan pegado arriba le ponemos top
                        .padding(.top, 15)
                        .padding(.bottom, 20)
                        //.OnAppear,para poder borrar la última búsqueda.
                        .onAppear{
                            search = ""
                        }
                    //Paso 1.6,ponemos nuestro botón.
                    Button {
                        buscar.toggle()
                    } label: {
                        Text("Search")
                            .font(.title2)
                            .bold()
                    }
                    //Paso 1.11, diseños al botón.
                    .buttonStyle(.bordered)
                    .tint(.white)
                    //el spacer es para que me lo mueve hacia arriba
                    Spacer()
                    /*Paso 1.8, ponemos el .navigationDestination, es como si fuera el navigationLink,pero ahora será este.
                     is presented, para activarlo como un booleano
                     ,para sin preocuparnos por enviar un dato*/
                    .navigationDestination(isPresented: $buscar) {
                        //Paso 1.9,ponemos nuestra vista y el search que declaramos anteriormente.
                        MoviesView(movie: search)
                    }
                    //Paso 1.12, ponemos un padding all y le ponemos su título.
                }.padding(.all)
                    .navigationTitle("App Movie Search")
            }
        }
    }
}

#Preview {
    Home()
}
