//
//  Home.swift
//  SwiftUI_CollapsableHeader
//
//  Created by park kyung seok on 2022/11/07.
//

import SwiftUI

struct Home: View {
    
    //Max Height
    let maxHeight = UIScreen.main.bounds.height / 2.3
    let navHeight: CGFloat = 80
    var topEdge: CGFloat
    var maxCornerRadius: CGFloat = 50
    // Offset
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15) {
                
                // ヘッダー周り
                GeometryReader { proxy in
                    
                    TopBar(topEdge: topEdge, offset: $offset, maxHeight: maxHeight)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: getHeaderHeight(), alignment: .bottom)
                        .background(Color("TopBar"), in: CustomCorner(corners: [.bottomRight], radius: getCornerRadius()))
                        .overlay(
                            
                            // Top Nav View
                            HStack(spacing: 15) {
                                
                                Button(action: {}, label: {
                                    Image(systemName: "xmark")
                                        .font(.body.bold())
                                })
                                
                                // --------------------------------------------------------
                                // ヘッダーを固定した時にこちらを表示
                                Image("Pic")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                    .opacity(navBarTitleOpacity())
                                Text("iJustine")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .opacity(navBarTitleOpacity())
                                // --------------------------------------------------------
                                
                                Spacer()
                                
                                Button(action: {}, label: {
                                    Image(systemName: "line.3.horizontal.decrease")
                                        .font(.body.bold())
                                })
                            }
                                .padding(.horizontal)
                                .frame(height: navHeight)
                                .foregroundColor(.white)
                                .padding(.top, topEdge)

                            , alignment: .top
                        )
                    
                }
                .frame(height: maxHeight)
                .offset(y: -offset)
                .zIndex(1)

                // コンテンツ周り
                VStack(spacing: 15) {
                    ForEach(allMessages) { message in
                        
                        // Card View
                        MessageCardView(message: message)
                    }
                }
                .padding()
                .zIndex(0)
                
            }
            .modifier(OffsetModifier(offset: $offset))
        }
        // setting coordinate space.
        .coordinateSpace(name: "SCROLL")
    }
    
    func getHeaderHeight() -> CGFloat {
    
        // ヘッダーのトップを固定するためにここで計算を行う
        let topHeight = maxHeight + offset
        
        if topHeight > navHeight + topEdge {
            return topHeight
        } else {
            return navHeight + topEdge
        }
    }
    
    func getCornerRadius() -> CGFloat {
        
        // navHeader + topEdge以外のヘッダの高さ内でスクロールした分CornerRadiusのvalueを調整
        let progress = -offset / (maxHeight - (navHeight + topEdge))
        
        let value = 1 - progress

        // value = 1 ... 0
        let radius = value * maxCornerRadius
        
        return offset < 0 ? radius : maxCornerRadius
    }
    
    func navBarTitleOpacity() -> CGFloat {
        
        let progress = -offset / (maxHeight - topEdge)
        let opacity = progress < 0 ? 0 : progress
        return opacity
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TopBar: View {
    
    var topEdge: CGFloat
    @Binding var offset: CGFloat
    var maxHeight: CGFloat
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            Image("Pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            Text("iJustine")
                .font(.largeTitle.bold())
            
            Text("Justine Ezarik is an American YouTuber, host, authorm she is best known as iJustine")
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .padding(.bottom)
        .opacity(getOpacity())
    }
    
    // 透明度計算
    func getOpacity() -> CGFloat {
        
        let progress = -offset / 90
        
        let opacity = 1 - progress
        return offset > 0 ? 1 : opacity
    }
}

struct MessageCardView: View {
    
    var message: Message
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Circle()
                .fill(message.tintColor)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(message.userName)
                    .fontWeight(.bold)
                
                Text(message.message)
                    .foregroundColor(.secondary)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
