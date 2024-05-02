//
//  CascadingCard.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI

struct CascadingCard: View {
  
  @State var shouldMove0: Bool = false
  @State var shouldMove1: Bool = false
  @State var shouldMove2: Bool = false
  @State var shouldMove3: Bool = false
  
  @State private var currentAnimationStep: Int = 0
  
  @State var zIndex: [Double] = [0, -1, -2, -3]

  var body: some View {
      
      VStack {
          ZStack {
              RoundedRectangle(cornerRadius: 8)
                  .fill(.red)
                  .frame(width: 100, height: 100)
                  .rotationEffect(.degrees(10), anchor: .center)
                  .animation(.easeOut(duration: 0.2), value: shouldMove3)
                  .offset(x: 25, y: -30)
                  .offset(
                      x: shouldMove3 ? 20 : 0,
                      y: shouldMove3 ? -100 : 0
                  )
                  .zIndex(zIndex[3])
                  .onChange(of: shouldMove3) { newValue in
                      Task {
                          if newValue {
                              try await Task.sleep(nanoseconds: 200_000_000)
                              shouldMove3 = false
                              updateZIndices()
                          }
                      }
                  }
         
              RoundedRectangle(cornerRadius: 8)
                  .fill(.yellow)
                  .frame(width: 100, height: 100)
                  .rotationEffect(.degrees(15), anchor: .center)
                  .animation(.easeOut(duration: 0.2), value: shouldMove2)
                  .offset(x: 30, y: 15)
                  .offset(
                      x: shouldMove2 ? 30 : 0,
                      y: shouldMove2 ? -100 : 0
                  )
                  .zIndex(zIndex[2])
                  .onChange(of: shouldMove2) { newValue in
                      Task {
                          if newValue {
                              try await Task.sleep(nanoseconds: 200_000_000)
                              shouldMove2 = false
                              updateZIndices()
                          }
                      }
                  }
              
              RoundedRectangle(cornerRadius: 8)
                  .fill(.green)
                  .frame(width: 100, height: 100)
                  .rotationEffect(.degrees(-10), anchor: .center)
                  .animation(.easeOut(duration: 0.2), value: shouldMove1)
                  .offset(x: -40, y: 20)
                  .offset(
                      x: shouldMove1 ? -30 : 0,
                      y: shouldMove1 ? -100 : 0
                  )
                  .zIndex(zIndex[1])
                  .onChange(of: shouldMove1) { newValue in
                      Task {
                          if newValue {
                              try await Task.sleep(nanoseconds: 200_000_000)
                              shouldMove1 = false
                              updateZIndices()
                          }
                      }
                  }
              
              RoundedRectangle(cornerRadius: 8)
                  .fill(.blue)
                  .frame(width: 100, height: 100)
                  .scaleEffect(1.3)
                  .animation(.easeOut(duration: 0.2), value: shouldMove0)
                  .offset(
                      y: shouldMove0 ? -100 : 0
                  )
                  .zIndex(zIndex[0])
                  .onChange(of: shouldMove0) { newValue in
                      Task {
                          if newValue {
                              try await Task.sleep(nanoseconds: 200_000_000)
                              shouldMove0 = false
                              updateZIndices()
                          }
                      }
                  }
                  
          }
          Spacer(minLength: 50)
              .fixedSize()
          Button("Next!!!") {
              triggerAnimation()
          }.foregroundColor(.black)
      }

  }
  
  func updateZIndices() {
      for index in zIndex.indices {
          zIndex[index] += 1
          
          if zIndex[index] == 1 {
              zIndex[index] = -3
          }
      }
  }
  
  func triggerAnimation() {
         switch currentAnimationStep {
         case 0:
             shouldMove0 = true
         case 1:
             shouldMove1 = true
         case 2:
             shouldMove2 = true
         case 3:
             shouldMove3 = true
         default:
             break
         }
         
         currentAnimationStep = (currentAnimationStep + 1) % 4
     }
  
}

#Preview {
    CascadingCard()
}
