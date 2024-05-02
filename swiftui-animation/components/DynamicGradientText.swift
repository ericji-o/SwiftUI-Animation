//
//  DynamicGradientText.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI

struct DynamicGradientText: View {
  
  @State private var flag = false
  
  var body: some View {
    
    Rectangle()
      .fill(.yellow)
      .overlay {
        Circle()
          .fill(
            LinearGradient(
              colors: [.purple, .black],
              startPoint: .bottomLeading,
              endPoint: .topTrailing
            )
          )
          .scaleEffect(flag ? 5 : 1)
          .animation(.easeIn(duration: 4), value: flag)
          .offset(
            x: -300,
            y: 180
          )
        
      }
      .clipped()
      .mask {
        Text("Im Eric.An iOS Developer!")
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
