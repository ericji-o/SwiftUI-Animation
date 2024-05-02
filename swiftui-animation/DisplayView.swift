//
//  DisplayView.swift
//  swiftui-animation
//
//  Created by Eric JI on 2024/05/02.
//

import SwiftUI

struct DisplayView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink("SlideButton") {
          SlideButton()
        }
        NavigationLink("FireworkLoading") {
          FireworkLoading()
        }
        NavigationLink("DynamicGradientText") {
          DynamicGradientText()
        }
        NavigationLink("CascadingCard") {
          CascadingCard()
        }
        NavigationLink("DripEffectView") {
          DripEffectView()
        }
        NavigationLink("ThemeSelectBar") {
          ThemeSelectBar()
        }
        NavigationLink("Radar") {
          Radar()
        }
        NavigationLink("GPTAnimatedText") {
          VStack(spacing: 20) {
            GPTAnimatedText(
              """
              OpenAI is a research organization advancing AI technology for the benefit of humanity. Founded in 2015, it focuses on creating safe and beneficial AI. OpenAI conducts cutting-edge research, promotes transparency, and aims to develop AI systems that are capable, reliable, and ethical.\n\n\n
               OpenAIは、人類の利益のためにAI技術を進化させる研究機関です。2015年に設立され、安全で有益なAIを作成することを目指しています。OpenAIは最先端の研究を行い、透明性を推進し、能力があり信頼性があり倫理的なAIシステムの開発を目指しています。
              """
            )
            Spacer()

          }.padding(.horizontal, 20)
        }
      }
      .navigationTitle("Components")
    }
  }
}
