//
//  ContentView.swift
//  SwiftUIDrawer
//
//  Created by Jakub Slawecki on 11/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            TitleView()
            
            Text("\(bottomState.height)").offset(y: -300)
            
            DrawerView()
                .offset(x: 0, y: 680)
                .offset(y: self.bottomState.height)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .gesture(
                DragGesture().onChanged { value in
                    self.bottomState = value.translation
                    if self.showFull {
                        self.bottomState.height += -550
                    }
                    
                    if self.bottomState.height < -550 {
                        self.bottomState.height = -550
                    }
                    
                }
                .onEnded { value in
                    
                    if self.bottomState.height < -70 && !self.showFull  {
                        self.bottomState.height = -550
                        self.showFull = true
                    } else if self.bottomState.height < -500 && self.showFull {
                        self.bottomState.height = -550
                        self.showFull = true
                    } else {
                        self.bottomState = .zero
                        self.showFull = false
                    }
                    
                }
            )
            
        }
        .background(Color.gray).edgesIgnoringSafeArea(.vertical)
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct DrawerView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            
            Text("Drawer")
                .multilineTextAlignment(.center)
                .font(.headline)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 5)
    }
}


struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Drawer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            .padding(.top, 40)
            Spacer()
        }
    }
}
