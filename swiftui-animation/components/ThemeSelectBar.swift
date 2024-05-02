//
//  ThemeSelectBar.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI

fileprivate let itemWidth: CGFloat = 80
fileprivate let itemHeight: CGFloat = 40

fileprivate let lineWidth: CGFloat = 60
fileprivate let lineHeight: CGFloat = 2

struct ThemeSelectBar: View {
  
  let datasource: [(Int, Color)]
  
  let barLength: CGFloat
  let screenWidth = UIScreen.main.bounds.width
  
  @State private var currentIndex: Int = 0
  
  init(count: Int = 21) {
      self.datasource = Array(stride(from: 0, to: count, by: 1)).map{ ($0, .init(uiColor: .random.withAlphaComponent(0.3))) }
      self.barLength = itemWidth * CGFloat(count)
  }
  
  var body: some View {
      ScrollViewReader { proxy in
          ScrollView(.horizontal) {
              HStack(spacing: 0) {
                  ForEach(datasource, id: \.self.0) { data in
                      Card(
                          num: data.0,
                          color: data.1,
                          onTap: {
                              withAnimation(.spring(duration: 0.4, bounce: 0.5, blendDuration: 0.5)) {
                                  currentIndex = data.0
                                  proxy.scrollTo(data.0, anchor: .center)
                              }
                          }
                      ).id(data.0)
                  }
              }.overlay(alignment: .leading) {
                  VStack {
                      Spacer()
                      Color.black
                          .frame(width: lineWidth, height: lineHeight)
                          .offset(x: updateLineOffsetX())
                  }.padding(.horizontal, (itemWidth - lineWidth) / 2)
              }
          }
      }.scrollIndicators(.hidden)
  }
  
  func updateLineOffsetX() -> CGFloat {
      CGFloat(currentIndex) * itemWidth
  }
  
}

private struct Card: View {
    
    private let title: String
    private let color: Color
    private let onTap: () -> Void

    init(
        num: Int,
        color: Color,
        onTap: @escaping () -> Void
    ) {
        self.title = String(num)
        self.color = color
        self.onTap = onTap
    }
    
    var body: some View {
        Text(title)
            .font(.headline)
            .frame(width: itemWidth, height: itemHeight)
            .background(color)
            .cornerRadius(4.0)
            .onTapGesture {
                onTap()
            }
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

#Preview {
  ThemeSelectBar()
}
