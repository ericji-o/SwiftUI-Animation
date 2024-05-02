//
//  SlideButton.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI

struct SlideButton: View {
  
  @State var position: CGPoint = .zero
  @State var isFinished: Bool = false
  
  @GestureState private var startLocation: CGPoint? = nil
  
  let color1 = UIColor.purple
  let color2 = UIColor.black
  
  let textTransition: AnyTransition = .asymmetric(
    insertion: .offset(y: 40).combined(with: .opacity),
    removal: .offset(y: -40).combined(with: .opacity)
  )
  
  let initialLength: CGFloat = 100
  
  func makeDragGesture(_ proxy: GeometryProxy) -> some Gesture {
    
    DragGesture()
      .onChanged { value in
        withAnimation {
          var newLocation = startLocation ?? position
          
          let initialOffset = -proxy.size.width/2
          let newLocationX = newLocation.x + value.translation.width
          
          if newLocationX - initialOffset >= proxy.size.width * 0.8 {
            newLocation.x =  proxy.size.width / 2
          } else {
            newLocation.x = newLocationX
          }
          
          newLocation.y = proxy.size.height / 2
          
          position = newLocation
        }
        
      }
      .onEnded { value in
        
        withAnimation {
          
          let newLocation = startLocation ?? position
          
          let initialOffset = -proxy.size.width/2
          let newLocationX = newLocation.x + value.translation.width
          
          if newLocationX - initialOffset < proxy.size.width * 0.8 {
            /// original location. same to the setting onAppear{}
            position = .init(x: -proxy.size.width/2 + initialLength, y: proxy.size.height/2)
            isFinished = false
          } else {
            isFinished = true
          }
          
        }
        
      }
      .updating($startLocation) { (value, startLocation, transaction) in
        startLocation = startLocation ?? position
      }
  }
  
  var body: some View {
    
    VStack {
      
//      Text("X:\(position.x), Y:\(position.y)")
      
      RoundedRectangle(cornerRadius: 50)
        .fill(.pink)
        .frame(maxWidth: .infinity, maxHeight: 100)
        .overlay(
          GeometryReader{ proxy in
            RoundedRectangle(cornerRadius: 50)
              .fill(
                LinearGradient(
                  gradient: Gradient(
                    colors: [
                      Color(uiColor: color1),
                      Color(uiColor: color2)
                    ]),
                  startPoint: .leading,
                  endPoint: .trailing
                )
              )
              .frame(width: proxy.size.width, height: proxy.size.height)
              .overlay(
                HStack {
                  Spacer()
                  Circle()
                    .fill(.clear)
                    .frame(width: proxy.size.height, height: proxy.size.height)
                    .overlay(
                      Image("right_arrow")
                        .renderingMode(.original)
                    )
                }.background(
                  ZStack {
                    if isFinished {
                      _GradientText()
                        .transition(textTransition)
                    }
                  }
                )
              )
              .position(position)
              .gesture(makeDragGesture(proxy))
              .onAppear{
                position = .init(x: -proxy.size.width/2 + initialLength, y: proxy.size.height/2)
              }
          }
          
        )
        .clipShape(RoundedRectangle(cornerRadius: 50))
    }.padding(.horizontal, 24)
    
  }
  
}

private struct _GradientText: View {
  
  @State private var flag = false
  
  var body: some View {
    
    Rectangle()
      .fill(.yellow)
      .overlay {
        Circle()
          .fill(
            LinearGradient(
              colors: [.white, .white],
              startPoint: .bottomLeading,
              endPoint: .topTrailing
            )
          )
          .scaleEffect(flag ? 5 : 1)
          .animation(.easeIn(duration: 1), value: flag)
          .offset(
            x: -100,
            y: 60
          )
        
      }
      .clipped()
      .mask {
        Text("Im super rich!")
          .font(
            .system(size: 20, weight: .bold)
          )
          .multilineTextAlignment(.center)
      }
      .onAppear {
        flag = true
      }
    
  }
}
