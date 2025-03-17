//
//  ScrollingCarousel.swift
//  ScrollingCarousel
//
//  Created by Eric Valera Miller on 14/03/25.
//

#if !os(macOS)

import SwiftUI

public struct ScrollingCarousel<Content: View>: View {
    @State private var horizontalPadding: CGFloat = 20
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var dynamicWidth: CGFloat = 248
    @State private var dynamicHeight: CGFloat = 0
    @State private var index: Int? = nil
    
    let content: [Content]
    let gap: CGFloat
    let normalState: CGFloat
    let reducedState: CGFloat
    let showIndicators: Bool
    let indicatorSize: CGFloat
    let indicatorColor: Color
    let indicatorGap: CGFloat
    let currentIndex: (Int) -> Void
    
    public init(content: [Content],
                gap: CGFloat = 20,
                normalState: CGFloat = 1,
                reducedState: CGFloat = 0.85,
                showIndicators: Bool = true,
                indicatorSize: CGFloat = 8,
                indicatorColor: Color = .gray,
                indicatorGap: CGFloat = 4,
                currentIndex: @escaping (Int) -> Void = { _ in }) {
        self.content = content
        self.gap = gap
        self.normalState = normalState
        self.reducedState = reducedState
        self.currentIndex = currentIndex
        self.indicatorColor = indicatorColor
        self.indicatorSize = indicatorSize
        self.indicatorGap = indicatorGap
        self.showIndicators = showIndicators
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
                                .background(GeometryReader { aproxy in
                                    Color.clear
                                        .onAppear {
                                            if dynamicHeight == 0 { dynamicHeight = aproxy.size.height }
                                        }
                                })
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
            .frame(height: dynamicHeight > 0 ? dynamicHeight : 80)
            .scrollClipDisabled()
            .scrollPosition(id: $index)
            .scrollTargetBehavior(.viewAligned)
            
            if showIndicators {
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: indicatorGap) {
                            ForEach(0..<content.count, id: \.self) { itemIndex in
                                Circle()
                                    .fill(indicatorColor.opacity(itemIndex == self.index ?? 0 ? 1 : 0.3))
                                    .frame(width: itemIndex == self.index ? indicatorSize * 1.5 : indicatorSize)
                                    .animation(.easeInOut(duration: 0.3), value: self.index)
                                    .id(itemIndex)
                            }
                        }
                        .frame(width: dynamicWidth)
                        .onChange(of: index) { _, newValue in
                            if let newValue = newValue {
                                withAnimation {
                                    proxy.scrollTo(newValue, anchor: .center)
                                }
                            }
                        }
                    }
                }
                .frame(width: dynamicWidth / 2)
                .padding(.vertical, 16)
                .allowsHitTesting(false)
            }
        }
        .frame(maxHeight: .infinity)
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
