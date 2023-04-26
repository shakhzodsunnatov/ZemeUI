//
//  AgentProStatisticView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 26.04.2023.
//

import SwiftUI
import Charts

struct AgentProStatisticView: View {
    
    let fistArray: [AgentProStatisticDM] = [
        .init(icon: "eye", title: "200", subtitle: "Total Views"),
        .init(icon: "heart", title: "200", subtitle: "Total Saves"),
        .init(icon: "redo", title: "300", subtitle: "Total Shares")
    ]
    
    let secondArray: [AgentProStatisticDM] = [
        .init(icon: "eye", title: "100", subtitle: "Total Views"),
        .init(icon: "eye", title: "10", subtitle: "Total Saves"),
        .init(icon: "clock 1", title: "1 min", subtitle: "Total Shares")
    ]
    
    let thirdArray: [AgentProStatisticDM] = [
        .init(icon: "wallet", title: "85K", subtitle: "Total Views"),
        .init(icon: "card-tick", title: "700", subtitle: "Total Saves"),
        .init(icon: "", title: "", subtitle: "")
    ]
    
    var grid: [GridItem] = [
        GridItem(.flexible(), spacing: 10 , alignment: .leading),
        GridItem(.flexible(), spacing: 10 , alignment: .leading),
        GridItem(.flexible(), spacing: 10 , alignment: .leading)
    ]
    
    var body: some View {
        CustomNavBar(
            content: {
                ZStack(alignment: .bottom) {
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(alignment: .leading,spacing: 0) {

                            topView()
                            
                            chartViews()
                            
                            VStack(spacing: 15) {
                                scrollWithproperty(title: "Property Statistics", model: fistArray)
                                scrollWithproperty(title: "Interaction Statistics", model: secondArray)
                                scrollWithproperty(title: "Applicant Statistics", model: thirdArray)
                            }
                            .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
                            
                            chartLineview()
                        }
                        .padding(.bottom,50)
                    }
                }
            },
            title: "Property Statistics",
            style: .newTitleAndIcon,
            type: .agent
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}

extension AgentProStatisticView {
    func topView() -> some View {
        ZStack {
            VStack(alignment: .leading,spacing: 2) {
                
                Image("homeMockImg")
                    .resizable()
                    .scaledToFill()
                    .overlay (
                        VStack {
                            Spacer()
                            
                            ItemImageBottomTextView(
                                firstText: "Oriana",
                                secondText: "$3,894/mo"
                            )
                        }
                    )
                    .frame(height: 120)
                    .padding(.top, 9)
                
                VStack(alignment: .leading ,spacing: 5) {
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
                    
                    HStack {
                        Text("Days on market")
                            .regular12
                            .padding(.horizontal,13)
                            .padding(.vertical,7)
                        Spacer()
                        Text("23 Days")
                            .semibold14
                            .foregroundColor(.purpleLow)
                            .padding(.horizontal,11)
                        
                    }
                    .background(Color.purpleLow.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.top,5)
            }
            .padding(10)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadowCustom()
        .padding(20)
    }
    
    func chartViews() -> some View {
        HStack(spacing: 10) {
            
            VStack(alignment: .leading,spacing: 4) {
                Text("Applications per day")
                    .medium12
                
                Text("Last 6 days")
                    .regular11
                
                HomeChart(data: [55,98,52,88,87,65], purpleMode: false)
                    .frame(height: 150)
                    .padding(.top,5)
            }
            .padding(10)
            .padding(.bottom,20)
            .roundedShadow()
            
            VStack(alignment: .leading,spacing: 4) {
                Text("Applications per day")
                    .medium12
                
                Text("Last 6 days")
                    .regular11
                
                HomeChart(data: [55,98,52,88,87,65], purpleMode: false)
                    .frame(height: 150)
                    .padding(.top,5)
            }
            .padding(10)
            .padding(.bottom,20)
            .roundedShadow()
        }
        .padding(.horizontal,20)
    }
    
    func chartLineview() -> some View {
        
        VStack(spacing: 15) {
            HStack {
                Text("Historical Rent Prices")
                    .semibold14
                    .padding(.horizontal,10)
                    .padding(.vertical,7)
                Spacer()
                Text("↑ +$200")
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
    
    func scrollWithproperty(title: String, model: [AgentProStatisticDM]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .medium12
            
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
}

struct AgentProStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        AgentProStatisticView()
    }
}

struct AgentProStatisticDM: Hashable {
    var icon: String
    var title: String
    var subtitle: String
}

