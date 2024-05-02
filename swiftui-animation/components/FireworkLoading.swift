//
//  FireworkLoading.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI

struct FireworkLoading: View {
  
  @State private var isScaled = false
  
  private let scaleAnimation: Animation = .easeOut(duration: 0.5)
  private let scaleSize = 3.0
  
  var body: some View {
    ZStack {
      
      ForEach(0 ..< 9, id: \.self) { i in
        _BombView(shouldStart: $isScaled, delayDuration: (0.8 - 0.1 * Double(i)))
          .offset(y: -80)
          .rotationEffect(.degrees(360 - 40 * Double(i)))
      }
    }.onAppear {
      isScaled = true
    }.onChange(of: isScaled) { newValue in
      
      if newValue {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          isScaled = false
        }
      } else {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          isScaled = true
        }
      }
    }
  }
}

private struct _BombView: View {
  
  @Binding var shouldStart: Bool
  @State private var shouldBomb = false

  private let scaleAnimation: Animation = .easeOut(duration: 0.5)
  private let scaleSize = 2.5
  
  let gradient = LinearGradient(
      gradient: Gradient(
          stops: [
            Gradient.Stop(color: .purple, location: 0),
            Gradient.Stop(color: .green, location: 0.53),
            Gradient.Stop(color: .yellow, location: 1),
          ]
      ),
      startPoint: .leading,
      endPoint: .trailing
  )
  
  private let delayDuration: Double
  
  init(
    shouldStart: Binding<Bool>,
    delayDuration: Double
  ) {
    self._shouldStart = shouldStart
    self.delayDuration = delayDuration
  }
  
  var body: some View {
   
    Circle()
      .fill(
        gradient
      )
      .frame(width: 20)
      .scaleEffect(shouldStart ? scaleSize : 1)
      .animation(
        scaleAnimation.delay(delayDuration),
        value: shouldStart
      )
      .background {
        __FireworkView(shouldStart: $shouldBomb)
      }
      .onChange(of: shouldStart) { newValue in
        Task { @MainActor in
          if newValue {
            
            let bombTime = (delayDuration + 0.6) * 1_000_000_000
            try await Task.sleep(nanoseconds: UInt64(bombTime))
            shouldBomb = true
            try await Task.sleep(nanoseconds: 400_000_000)
            shouldBomb = false
          }
          
        }
      }
    
  }
}

private struct __FireworkView: View {
  
  @State private var shouldMove = false
  @State private var shouldScale = false
  private let moveAnimation: Animation = .easeOut(duration: 0.5)
  private let scaleAnimation: Animation = .easeOut(duration: 0.2).delay(0.3)
  
  @Binding var shouldStart: Bool
  private let width: CGFloat = 12
  
  private let colors = [
    Color.green,
    Color.yellow,
    Color.purple
  ]
  
  var body: some View {
    ZStack {
      
      ForEach(0 ..< 9, id: \.self) { i in
        Circle()
          .fill(
            colors[i%3]
          )
          .frame(width: width)
          .scaleEffect(shouldScale ? 0 : 1)
          .offset(y: shouldMove ? -100 : 0)
          .rotationEffect(.degrees(360 - 40 * Double(i)))
          .animation(moveAnimation, value: shouldMove)
          .animation(scaleAnimation, value: shouldScale)
      }

    }
    .opacity(shouldStart ? 1 : 0)
    .onChange(of: shouldStart) { newValue in
        shouldMove = shouldStart
        shouldScale = shouldStart
    }
  }
}
