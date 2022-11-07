//
//  ContentView.swift
//  SwiftUI_CollapsableHeader
//
//  Created by park kyung seok on 2022/11/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // To Ignore and get safe Area size
        GeometryReader { proxy in
            
            let topEdge = proxy.safeAreaInsets.top
            Home(topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
