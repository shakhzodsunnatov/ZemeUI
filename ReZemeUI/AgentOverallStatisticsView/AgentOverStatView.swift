//
//  AgentOverStatView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 27.04.2023.
//

import SwiftUI

struct AgentOverStatView: View {
    
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
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "gradientPurpleLow")
              UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "gradientPurpleLow")!.withAlphaComponent(0.1)
           }
    
    @State var selectIndex: Int = 0
    @State var buttonID: Int = 1
    
    var body: some View {
        CustomNavBar(
            content: {
                ZStack(alignment: .bottom) {
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(alignment: .leading,spacing: 0) {
                            
                            tabView()
                            
                            propertyView()
                            
                            scrollWithproperty(model: fistArray)
                            
                            listView()
                            
                            buttonsView()
                            
                            chartLineview()
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

extension AgentOverStatView {
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
                .padding([.leading],5)
                .padding(.bottom,10)
            }
        }
        .padding(.horizontal,20)
    }
    
    func tabView() -> some View{
        
        HStack(alignment: .center) {
            Button {
                withAnimation {
                    self.selectIndex = 0
                }
            } label: {
                Text("Currently Listed")
                    .semibold14
                    .foregroundColor((self.selectIndex == 0) ? .white : Color(hexString: "545454"))
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    .background(
                        self.selectIndex == 0 ? Color.purpleLow : .white
                    )
                    .cornerRadius(8)
            }

            Button {
                withAnimation {
                    self.selectIndex = 1
                }
            } label: {
                Text("Total Historically")
                    .semibold14
                    .foregroundColor((self.selectIndex == 1) ? .white : Color(hexString: "545454"))
                    .frame(maxWidth: .infinity,maxHeight: 30)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    .background((self.selectIndex == 1)  ? Color.purpleLow : Color.white)
                    .cornerRadius(8)
            }
        }
        .padding(EdgeInsets(top: 5, leading: 6, bottom: 4, trailing: 6))
        .background (
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hexString: "DBE1E3"),lineWidth: 1)
        )
        .padding(.vertical,10)
        .padding(.horizontal,20)
    }
    
    func propertyView() -> some View {
        HStack(spacing: 8){
            Image("buliding_ic")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(Color.darkBlue)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.darkBlue.opacity(0.1))
                )
                .frame(width: 42, height: 42)
            
            Text("Total Properties")
                .semibold16
            
            Spacer()
            
            Text("23")
                .foregroundColor(.purpleLow)
                .semibold16
                
        }
        .padding(EdgeInsets(top: 9, leading: 9, bottom: 9, trailing: 20))
        .roundedShadowNew()
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 15, trailing: 20))
    }
    
    
    func chartLineview() -> some View {
        
        VStack(spacing: 15) {
            HStack {
                Text("Average Rent Price")
                    .semibold14
                    .padding(.horizontal,10)
                    .padding(.vertical,7)
                Spacer()
                Text("23 Properties")
                    .semibold14
                    .foregroundColor(.purpleLow)
                    .padding(.horizontal,10)
                    .padding(.vertical,7)
                    .background(Color.purpleLow.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal,5)
            }
            LineAreaChartView()
        }
        .padding(10)
        .roundedShadow()
        .padding(.horizontal,20)
        .padding(.vertical,10)
    }
    
    func buttonsView() -> some View{
        
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 34) {
                ForEach(1..<6,id: \.self) { id in
                    Button {
                        buttonID = id
                    } label: {
                        VStack(alignment: .leading,spacing: 0) {
                            if buttonID == id {
                                Text("\(id) Bedroom")
                                    .semibold16
                                    .foregroundColor(.darkBlue)
                            } else {
                                Text("\(id) Bedroom")
                                    .regular16
                                    .foregroundColor(.darkBlue)
                            }
                            
                            RoundedRectangle(cornerRadius: 1.5)
                                .fill(Color.darkBlue)
                                .frame(width: 16, height: 3)
                                .opacity(buttonID == id ? 1 : 0)
                        }
                    }
                }
            }
            .padding(.horizontal,20)
        }
        .padding(.vertical,6)
    }
    
    func listView() -> some View {
        TabView {
            ForEach(0..<4,id: \.self) { id in
                HStack {
                    VStack {
                        HStack(alignment: .top,spacing: 16) {
                            Image("homeMockImg")
                                .resizable()
                                .frame(width: 112, height: 90)
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Text("Oriana")
                                        .medium12
                                    
                                    Spacer()
                                    
                                    Text("↑ +$200")
                                        .medium14
                                        .foregroundColor(.darkBlue)
                                }
                                
                                HStack {
                                    Image("pin")
                                        .renderingMode(.template)
                                        .frame(width: 12, height: 12)
                                        .padding(.horizontal,6)
                                        .padding(.vertical,10)
                                        .foregroundColor(Color.blue)
                                    Text("420 E 54th St, New York, NY 10022")
                                        .medium12
                                }
                                
                                HStack(alignment: .center) {
                                    HStack {
                                        HStack {
                                            Image("heart")
                                                .renderingMode(.template)
                                                .frame(width: 12, height: 12)
                                                .padding(.vertical,10)
                                                .foregroundColor(Color.blue)
                                            Text("30k")
                                                .medium12
                                        }
                                    }
                                    
                                    HStack {
                                        HStack {
                                            Image("eye")
                                                .resizable()
                                                .renderingMode(.template)
                                                .frame(width: 15, height: 15)
                                                .scaledToFill()
                                                .padding(.vertical,10)
                                                .foregroundColor(Color.blue)
                                            Text("7k")
                                                .medium12
                                        }
                                    }
                                    
                                    HStack {
                                        HStack {
                                            Image("profile-agent")
                                                .resizable()
                                                .renderingMode(.template)
                                                .frame(width: 15, height: 15)
                                                .scaledToFit()
                                                .padding(.vertical,10)
                                                .foregroundColor(Color.blue)
                                            Text("5k")
                                                .medium12
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal,10)
                                .padding(.vertical,0)
                                .background(Color.darkBlue.opacity(0.05))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.trailing,10)
                        
                    }
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                    .roundedShadowNew()
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
            }
            .padding(.bottom,30)
        }
        .frame(height: 170)
        .tabViewStyle(.page(indexDisplayMode: .always))
        
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        
    }
    
}

struct AgentOverStatView_Previews: PreviewProvider {
    static var previews: some View {
        AgentOverStatView()
    }
}
