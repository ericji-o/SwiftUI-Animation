//
//  GPTAnimatedText.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI
import NaturalLanguage
import Combine

struct GPTAnimatedText: View {
  
  private var words: [String] = []
  @State private var currentWordIndex: Int = 0
  @State private var timer: Timer.TimerPublisher = Timer.publish(every: 0.04, on: .main, in: .common)
  @State private var cancellable: AnyCancellable?
  
  init(_ text: String) {
      let tokenizer = NLTokenizer(unit: .word)
      tokenizer.string = text
      var currentIndex = text.startIndex
      for range in tokenizer.tokens(for: text.startIndex..<text.endIndex) {
          if currentIndex < range.lowerBound {
              words.append(String(text[currentIndex..<range.lowerBound]))
          }
          words.append(String(text[range]))
          currentIndex = range.upperBound
      }
      if currentIndex < text.endIndex {
          words.append(String(text[currentIndex..<text.endIndex]))
      }
  }
  
  var body: some View {
      Text(words.prefix(currentWordIndex + 1).joined())
          .onAppear {
              self.cancellable = timer.autoconnect().sink { _ in
                  if currentWordIndex < words.count - 1 {
                      currentWordIndex += 1
                  } else {
                      self.cancellable?.cancel()
                  }
              }
          }
          .font(.system(size: 19))
          .frame(maxWidth: .infinity, alignment: .leading)
          .lineSpacing(5)
  }
}

#Preview {
  GPTAnimatedText("test test test")
}
