//
//  ScrollingCarousel.swift
//  ScrollingCarousel
//
//  Created by Eric Valera Miller on 14/03/25.
//

#if canImport(UIKit) && !os(macOS)

import SwiftUI

public struct ScrollingCarousel<Content: View>: View {
    @State private var horizontalPadding: CGFloat = 20
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var dynamicWidth: CGFloat = 248
    @State private var index: Int? = nil
    
    let content: [Content]
    let gap: CGFloat
    let normalState: CGFloat
    let reducedState: CGFloat
    let currentIndex: (Int) -> Void
    
    public init(content: [Content],
         gap: CGFloat = 20,
         normalState: CGFloat = 1,
         reducedState: CGFloat = 0.85,
         currentIndex: @escaping (Int) -> Void = { _ in }) {
        self.content = content
        self.gap = gap
        self.normalState = normalState
        self.reducedState = reducedState
        self.currentIndex = currentIndex
    }
    
    public var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: self.gap) {
                    ForEach(content.indices, id: \.self) { index in
                        GeometryReader { proxy in
                            content[index]
                                .frame(width: proxy.size.width) // Usa el ancho dinámico
                                .scrollTransition(.interactive, axis: .horizontal) { effect, phase in
                                    effect.scaleEffect(phase.isIdentity ? self.normalState : self.reducedState)
                                }
                                .onAppear {
                                    self.dynamicWidth = proxy.size.width
                                    self.horizontalPadding = (screenWidth - dynamicWidth) / 2
                                }
                                .frame(maxHeight: .infinity)
                        }
                        .frame(width: dynamicWidth)
                    }
                }
                .padding(.horizontal, self.horizontalPadding)
                .scrollTargetLayout()
            }
            .scrollClipDisabled()
            .scrollPosition(id: $index)
            .scrollTargetBehavior(.viewAligned)
        }
        .onAppear {
            self.horizontalPadding = (screenWidth - dynamicWidth) / 2
            if index == nil { index = 0 }
            
        }
        .onChange(of: index) { oldValue, newValue in
            if let newValue = newValue, newValue != oldValue {
                currentIndex(newValue)
            }
        }
    }
}

#endif
