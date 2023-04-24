//
//  AgentMainView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 24.04.2023.
//

import SwiftUI

struct AgentMainView: View {
    @State var filter: Bool = false
    
    @State var filter1: Bool = false
    @State var filter2: Bool = false
    @State var filter3: Bool = false
    @State var filter4: Bool = false
    @State var filter5: Bool = false
    @State var filter6: Bool = false
    @State var filter7: Bool = false
    
    @State var selectTitle: String = "Select All"
    var body: some View {
        
        CustomNavBar(
            content: {
                ZStack {
                    ScrollView(.vertical,showsIndicators: false) {
                        ForEach(0..<2, id: \.self) { property in
                            AgentPropertyItemView(property: mockProperty, push: .constant(false), properID: .constant(1))
                        }
                    }
                    if filter {
                        filterView()
                    }
                }
            },
            title: "",
            style: .newAgentMainFilter,
            type: .agent) {
                withAnimation(.easeInOut) {
                    filter.toggle()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
    }
}

extension AgentMainView {
    
    func filterView() -> some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .offset(x: 0 ,y:-5)
                .padding(.horizontal,30)
                .padding(.bottom,100)
                .shadowCustom()
            
            VStack(alignment: .leading){
                HStack {
                    Text("Filter By")
                        .semibold18
                    Spacer()
                    Button {
                        filter1.toggle()
                        filter2.toggle()
                        filter3.toggle()
                        filter4.toggle()
                        filter5.toggle()
                        filter6.toggle()
                        filter7.toggle()
                        if filter1 && filter2 && filter3 && filter4 && filter5 && filter6 && filter7 {
                            filter1 = true
                            filter2 = true
                            filter3 = true
                            filter4 = true
                            filter5 = true
                            filter6 = true
                            filter7 = true
                            selectTitle = "Deselect All"
                        } else {
                            filter1 = false
                            filter2 = false
                            filter3 = false
                            filter4 = false
                            filter5 = false
                            filter6 = false
                            filter7 = false
                            
                            selectTitle = "Select All"
                        }
                    } label: {
                        Text(selectTitle)
                            .underline()
                            .bold14
                            .foregroundColor(.purpleLow)
                    }
                }
                Group {
                    FileterCheckView(isSelected: $filter1, title: "Notifications Pending", type: .agent) { t in
                        
                    }
                    FileterCheckView(isSelected: $filter2,title: "Messages Pending", type: .agent) { t in
                        
                    }
                    FileterCheckView(isSelected: $filter3, title: "New Application", type: .agent) { t in
                        
                    }
                    
                    Text("Sort By")
                        .semibold18
                    
                    Text("Alphabetical")
                        .regular14
                    
                    FileterCheckView(isSelected: $filter4,title: "Alphabetical A-Z", type: .agent) { t in
                        
                    }
                    FileterCheckView(isSelected: $filter5, title: "Alphabetical Z-A", type: .agent) { t in
                        
                    }
                    
                    Text("Date Range")
                        .regular14
                    
                    FileterCheckView(isSelected: $filter6,title: "Newest to Oldest", type: .agent) { t in
                        
                    }
                    FileterCheckView(isSelected: $filter7, title: "Oldest to Newest", type: .agent) { t in
                        
                    }
                }
                
                ActionButton("Apply", action:{
                    withAnimation {
                        filter.toggle()
                    }
                })
                .padding(50)
                
                
            }
            .padding(.horizontal,40)
            .padding()
        }
    }
}

struct AgentMainView_Previews: PreviewProvider {
    static var previews: some View {
        AgentMainView()
    }
}


