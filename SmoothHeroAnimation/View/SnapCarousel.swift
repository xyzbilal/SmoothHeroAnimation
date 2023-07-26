//
//  SnapCarousel.swift
//  SmoothHeroAnimation
//
//  Created by Bilal SIMSEK on 25.07.2023.
//

//MARK: Tutoruial Link = https://www.youtube.com/watch?v=GvKUmUA86WM&ab_channel=Kavsoft



import SwiftUI

struct SnapCarousel<Content:View,T:Identifiable>: View {
    var content:(T)->Content
    var list:[T]

    var spacing:CGFloat
    var trailingSpace:CGFloat
    @Binding var index:Int
    
    init(items: [T], spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>,@ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
    }
    
    
    @GestureState var offset:CGFloat = 0
    @State var currentIndex:Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let width = size.width - (trailingSpace - spacing)

            let adjustmentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: 15) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: size.width - trailingSpace)
                        .offset(y:getOffset(item,width))
                }
            }
            .padding(.horizontal,spacing)
            .offset(x:(CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustmentWidth : 0) + offset)
            .gesture(
            DragGesture()
                .updating($offset, body: { value, out, _ in
                    out = value.translation.width / 1.5 // This value adjust drag speed
                })
                .onEnded({ value in
                    let offsetX = value.translation.width
                    let progress = -offsetX / width
                    let roundIndex = progress.rounded()
                    currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1),0)
                })
                .onChanged({ value in
                    let offsetX = value.translation.width
                    let progress = -offsetX / width
                    let roundIndex = progress.rounded()
                    index = max(min(currentIndex + Int(roundIndex), list.count - 1),0)
                })
            )
           
        }
        .animation(.easeInOut, value: offset == 0)
    }
    
    func getOffset(_ item: T,_ width:CGFloat)->CGFloat{
        let progress = (offset/width) * 60
        let topToOffset = -progress < 60 ? progress : -(progress + 120)
        let previous = getIndex(item) - 1 == currentIndex ? topToOffset : 0
        let next = getIndex(item) + 1 == currentIndex ? topToOffset : 0
        let checkBetween = currentIndex >= 0 && currentIndex < list.count ? (getIndex(item) - 1 == currentIndex ? previous : next) : 0

        return getIndex(item) == currentIndex ? -60 - topToOffset : checkBetween
        
        
    }
    
    func getIndex(_ item: T)->Int{
        let index = list.firstIndex { currentItem in
            return currentItem.id == item.id
        } ?? 0
        
        return index
    }
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}
