//
//  AgentMainView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 24.04.2023.
//

import SwiftUI

struct AgentMainView: View {
    
    @Environment(\.presentationMode) var presentationMode
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
                ZStack(alignment: .top) {
                    ScrollView(.vertical,showsIndicators: false) {
                        ForEach(0..<2, id: \.self) { property in
                            AgentPropertyItemView(property: mockProperty, push: .constant(false), properID: .constant(1))
                                .padding(.horizontal,11)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                    }
                    
                    if filter {
                        filterView()
                            .offset(y:-8)
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
        
        VStack(alignment: .leading, spacing: 0) {
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
            ScrollView(.vertical,showsIndicators: false) {
                VStack(alignment: .leading,spacing: 0) {
                    FileterCheckView(isSelected: $filter1, title: "Notifications Pending", type: .agent) { t in
                        
                    }
                    
                    FileterCheckView(isSelected: $filter2,title: "Messages Pending", type: .agent) { t in
                        
                    }
                    
                    FileterCheckView(isSelected: $filter3, title: "New Application", type: .agent) { t in
                        
                    }
                    .padding(.top,4)
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Sort By")
                            .semibold18
                        
                        VStack(alignment: .leading,spacing: 0) {
                            Text("Alphabetical")
                                .regular14
                            
                            FileterCheckView(isSelected: $filter4,title: "Alphabetical A-Z", type: .agent) { t in
                                
                            }
                            
                            FileterCheckView(isSelected: $filter5, title: "Alphabetical Z-A", type: .agent) { t in
                                
                            }
                        }
                        .padding(.top,10)
                        
                        VStack(alignment: .leading,spacing: 0) {
                            Text("Date Range")
                                .regular14
                            
                            FileterCheckView(isSelected: $filter6,title: "Newest to Oldest", type: .agent) { t in
                                
                            }
                            FileterCheckView(isSelected: $filter7, title: "Oldest to Newest", type: .agent) { t in
                                
                            }
                        }
                        .padding(.top,10)
                        
                    }
                    .padding(.top,10)
                    
                }
            }
            
            ActionButton("Apply", action: {
                withAnimation {
                    filter.toggle()
                }
            })
            .padding(.horizontal, 56)
            .padding(.top, 38)
            .padding(.bottom,30)
        }
        .padding(EdgeInsets(top: 11, leading: 20, bottom: 19, trailing: 20))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadowCustom()
        )
        .padding(.horizontal,20)
        .padding(.bottom,120)
    }
}

struct AgentMainView_Previews: PreviewProvider {
    static var previews: some View {
        AgentMainView()
    }
}


