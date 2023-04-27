//
//  AgentOverStatView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 27.04.2023.
//

import SwiftUI

struct AgentOverStatVieww: View {
    
    var grid: [GridItem] = [
        GridItem(.flexible(), spacing: 10 , alignment: .leading),
        GridItem(.flexible(), spacing: 10 , alignment: .leading),
        GridItem(.flexible(), spacing: 10 , alignment: .leading)
    ]
    
    let fistArray: [AgentProStatisticDM] = [
        .init(icon: "eye", title: "200", subtitle: "Total Views"),
        .init(icon: "heart", title: "200", subtitle: "Total Saves"),
        .init(icon: "redo", title: "300", subtitle: "Total Shares")
    ]
    
    var body: some View {
        CustomNavBar(
            content: {
                ZStack(alignment: .bottom) {
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(alignment: .leading,spacing: 0) {
                            scrollWithproperty(model: fistArray)
                        }
                        .padding(.bottom,50)
                    }
                }
            },
            title: "Overall Statistics",
            style: .newTitleAndIcon,
            type: .agent
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}

extension AgentOverStatVieww {
    func scrollWithproperty(model: [AgentProStatisticDM]) -> some View {
        
        LazyVGrid(columns: grid, spacing: 14) {
            ForEach(model,id: \.self) { model in
                VStack(spacing: 6) {
                    HStack {
                        Image(model.icon)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.blue)
                        Text(model.title)
                            .semibold14
                            .foregroundColor(.darkBlue)
                    }
                    Text(model.subtitle)
                        .regular11
                    
                }
                .frame(width: 110, height: 70)
                .roundedShadowNew()
                .padding([.trailing,.leading],5)
                .padding(.bottom,10)
            }
        }
    }
}

struct AgentOverStatView_Previews: PreviewProvider {
    static var previews: some View {
        AgentOverStatVieww()
    }
}
