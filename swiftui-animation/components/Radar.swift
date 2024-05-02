//
//  Radar.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI

struct Radar: View {
  
  @State private var startDisplay1: Bool = false
  @State private var startDisplay2: Bool = false
  @State private var startDisplay3: Bool = false

  var body: some View {
    
    ZStack {
      _SingleRadarView()
      if startDisplay2 {
        _SingleRadarView()
      }
      if startDisplay3 {
        _SingleRadarView()
      }
    }.task {
      try? await Task.sleep(nanoseconds: 800_000_000)
      startDisplay2 = true
      try? await Task.sleep(nanoseconds: 800_000_000)
      startDisplay3 = true
    }
  }
}

private struct _SingleRadarView: View {
  
  @State private var shouldRepeat: Bool = false
  @State private var shouldScale: Bool = false
  @State private var shouldDisplay: Bool = false

  var body: some View {
    ZStack {
      Circle()
        .fill(.purple.opacity(0.5))
        .frame(width: 100)
        .aspectRatio(1, contentMode: .fit)
        .scaleEffect(
          shouldRepeat ?
            .init(width: 1.1, height: 1) :
              .init(width: 1, height: 1.1)
        )
        
    }
    .scaleEffect(shouldScale ? 2 : 0)
    .opacity(shouldDisplay ? 0 : 1)
    .onAppear {
      
      withAnimation(.easeInOut(duration: 0.4).repeatForever()) {
        shouldRepeat = true
      }
      withAnimation(.easeOut(duration: 2)) {
        shouldScale = true
      }
      withAnimation(.easeInOut(duration: 1.8).delay(0.2)) {
        shouldDisplay = true
      }
    }
    .onChange(of: shouldScale) { newValue in
      if newValue {
        Task { @MainActor in
          try await Task.sleep(nanoseconds: 2_400_000_000)
          shouldScale = false
          shouldDisplay = false
        }
      } else {
        Task { @MainActor in
          withAnimation(.easeOut(duration: 2.4)) {
            shouldScale = true
          }
          withAnimation(.easeInOut(duration: 2).delay(0.4)) {
            shouldDisplay = true
          }
        }
      }
    }
  }
  
}
