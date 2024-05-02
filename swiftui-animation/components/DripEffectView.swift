//
//  DripEffectView.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI

struct DripEffectView: View {
  
  @State private var oldCount: Int = 0
  @State private var newCount: Int = 0
  
  @State private var shouldAnimate = false
  
  var body: some View {
    VStack(spacing: 20) {
      
      ZStack {
        
        Text("\(newCount)")
          .font(.largeTitle)
          .foregroundColor(.pink)
          .bold()
          .offset(y: shouldAnimate ? 0 : -40)
          .opacity(shouldAnimate ? 1 : 0)
        
        Text("\(oldCount)")
          .font(.largeTitle)
          .foregroundColor(.pink)
          .bold()
          .offset(y: shouldAnimate ? 40 : 0)
          .opacity(shouldAnimate ? 0 : 1)
        
      }.onChange(of: shouldAnimate) { newValue in
        if newValue {
          newCount += 1
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            shouldAnimate = false
            oldCount = newCount
          }
        }
      }
      
      Button("add") {
        withAnimation(.easeOut(duration: 0.5)) {
          shouldAnimate.toggle()
        }
      }.foregroundColor(.black)
    }
    
  }
}

#Preview {
  DripEffectView()
}
