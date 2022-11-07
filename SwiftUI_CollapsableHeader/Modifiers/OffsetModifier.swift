//
//  OffsetModifier.swift
//  SwiftUI_CollapsableHeader
//
//  Created by park kyung seok on 2022/11/07.
//

import SwiftUI

// Getting ScrollView offset.
struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        
        content
            .overlay(
                
                GeometryReader { proxy -> Color in
                    
                    // getting value for coordinate space called "SCROLL"
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return Color.clear
                }
                , alignment: .top
            )
        
    }
}
