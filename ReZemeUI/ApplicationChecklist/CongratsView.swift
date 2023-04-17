//
//  CongratsView.swift
//  ReZeme
//
//  Created by Shakhzod on 20/03/23.
//

import SwiftUI

struct CongratsView: View {
    
    
    var body: some View {
        NavigationNavBar(title: "Congrats!", withBeckBtn: false) {
            VStack(spacing:0) {
                
                VStack(spacing: 0) {
                    
                    VStack {
                        imageComponent()

                        streetNames
                        
                        wishTitles
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadowCustom()
                    .padding(20)
                    
                }
                
                Spacer()
                
                NavigationLink(
                    destination: { ContentView() }) {
                        Text("Go Home")
                            .semibold18
                            .foregroundColor(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .fill(Color.blueGradient.toLinearGradient)
                            )
                            .padding(.horizontal, 76)
                    }

            }
        }
    }
}


//MARK: - UI Components

extension CongratsView {
    
    private func navBar(geo: GeometryProxy) -> some View {
        HStack {
            
            Text("Congrats!")
                .semibold22
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            
        }
        .padding(.top, geo.safeAreaInsets.top)
        .padding(.bottom, 25)
        .frame(width: SCREEN_WIDTH)
        .background(
            Image("top-background")
                .resizable()
        )
        .ignoresSafeArea(edges: .top)
    }
    
    private func imageComponent() -> some View {
        ZStack(alignment: .bottom) {
            Image("mockHomeImage")
                .resizable()
                .scaledToFill()
                .frame(height: 246)
                .frame(maxWidth: .infinity)
            
            Text("Seven LIC")
                .semibold18
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 30)
                .padding(.horizontal, 9)
                .background(Color.black.opacity(0.4))
        }
        .cornerRadius(8)
    }
    
    private var streetNames: some View {
        VStack( alignment: .leading, spacing: 5) {
            
            Text("29-59 Northern Blvd, Long Island City, NY 11101")
                .fixedSize(horizontal: false, vertical: false)
                .medium14
            
            Text("Unit 39F")
                .fixedSize(horizontal: false, vertical: false)
                .regular12
        }
    }
    
    private var wishTitles: some View {
        VStack(spacing: 11) {
            
            Text("Thank you for submitting your application!")
                .semibold18
            
            Text("We have notified the agent and they will get back to you soon!")
                .regular16
            
        }
        .multilineTextAlignment(.center)
        .padding(.top, 55)
    }
}


struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratsView()
    }
}
