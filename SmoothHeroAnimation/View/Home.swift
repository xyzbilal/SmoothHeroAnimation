//
//  Home.swift
//  SmoothHeroAnimation
//
//  Created by Bilal SIMSEK on 25.07.2023.
//

import SwiftUI

struct Home: View {
    @State var currentIndex:Int = 0
    @State var currentTab:String = "Films"
    
    @State var detailMovie:Movie?
    @State var showDetailView:Bool = false
    @State var currentCardSize:CGSize = .zero
    
    @Namespace var animation
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            // BG
            BGView()
            
            
            VStack {
                NavBar()
                
                SnapCarousel(items: movies, index: $currentIndex) { movie in
                    GeometryReader{ proxy in
                        let size = proxy.size
                        Image(movie.artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width,height: size.height)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: movie.id, in: animation)
                            .onTapGesture {
                                currentCardSize = size
                                detailMovie = movie
                                withAnimation(.easeInOut) {
                                    showDetailView = true
                                }
                            }
                    }
                    
                    
                }
                .padding(.top,90)
                
                // Custom Indicator
                CustomIndicator()
                
                HStack{
                    Text("Popular")
                        .font(.title3.bold())
                    Spacer()
                    Button("See More") {
                        
                    }
                    .font(.system(size:16,weight: .semibold))
                }.padding()
                
                ScrollView (.horizontal,showsIndicators: false){
                    HStack(spacing:15){
                        ForEach(movies) { movie in
                            Image(movie.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100,height: 120)
                                .cornerRadius(15)
                        }
                    }
                }.padding(.horizontal,8)
                
            }
            
            .overlay{
                if let movie = detailMovie,showDetailView{
                    DetailView(movie: movie, showDetailView: $showDetailView, detailMovie: $detailMovie, currentCardSize: $currentCardSize, animation: animation)
                }
            }
           
        }
       
    }
    
    @ViewBuilder
    func CustomIndicator()->some View{
        HStack(spacing: 5) {
            ForEach(movies.indices,id:\.self) { index in
                let current = currentIndex == index
                Circle()
                    .fill(current ? .blue : .gray.opacity(0.5))
                    .frame(width: current ? 10 : 6, height: current ?  10 : 6)
            }
        }
        .animation(.easeOut, value: currentIndex)
        
    }
    
    
    @ViewBuilder
    func NavBar()->some View{
        HStack(spacing:0){
            ForEach(["Films","Localities"],id:\.self){tab in
                Button {
                    withAnimation {
                        currentTab = tab
                    }
                } label: {
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background{
                            if currentTab == tab{
                                Capsule()
                                    .fill(.ultraThinMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                
                            }
                        }
                }

                
                
            }
        }
        .padding()
       
    }
    
    
    @ViewBuilder
    func BGView()->some View{
        GeometryReader { geometry in
            let size = geometry.size
            TabView(selection: $currentIndex) {
                ForEach(movies.indices,id:\.self) { index in
                    Image(movies[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeOut, value: currentIndex)
            let color:Color = (colorScheme == .dark ? .black : .white)
            
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            Rectangle()
                .fill(.ultraThinMaterial)
            
        }
        .ignoresSafeArea()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}
