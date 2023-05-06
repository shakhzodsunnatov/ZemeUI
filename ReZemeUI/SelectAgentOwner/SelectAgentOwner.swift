//
//  SelectAgentOwner.swift
//  ReZemeUI
//
//  Created by Shakhzod on 05/05/23.
//

import SwiftUI

struct SelectAgentOwner: View {
    
    @State var searchText = ""
    @State var agents = agentsMock
    @State var originalMock = agentsMock
    @State var emailText = "john.doe@gmail.com"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing:0) {
                
                propertyUI()
                    .padding(.top,17)
                    .padding(.horizontal,20)
             
                searchTextFieldUI(searchText: $searchText)
                    .padding(.top,16)
                    .padding(.horizontal, 20)
                
                listOfAgents(models: $agents)
                    .padding(.top,12)
                
                
                
                if !searchText.isEmpty {
                    
                    LineView()
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing:2) {
                        Text("Can’t find your agent?")
                            .semibold14
                        
                        Text("Send them an invite to join zeme")
                            .medium14
                        
                        TextField("Email", text: $emailText)
                            .foregroundColor(.black)
                            .autocorrectionDisabled()
                            .medium14
                            .padding(.vertical,17)
                            .padding(.horizontal,20)
                            .roundedShadow()
                            .padding(.top, 16)
                        
                    }
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top,18)
                }
            }
            .onTapGesture {
                dismissKeyboard()
            }
            
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    agents = originalMock
                } else {
                    agents = originalMock.filter({ $0.name.uppercased().contains(searchText.uppercased()) })
                }
            }
        }
        .navigationOwner(title: "Select an Agent")
    }
    
}


//MARK: - UI Components

extension SelectAgentOwner {
    
    private func propertyUI() -> some View {
        HStack(spacing: 12) {
            
            Image("mockHomeImage")
                .resizable()
                .scaledToFill()
                .frame(width: 107, height: 84)
            
            VStack(alignment: .leading, spacing: 2) {
                
                Text("Sven LIC")
                    .semibold16
                
                Text("29-59 Northern Blvd, Long Island City, NY 11101")
                    .medium12
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                
                Text("Unit 39F")
                    .regular12
            }
            .multilineTextAlignment(.leading)
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .roundedShadow()
    }
    
    private func searchTextFieldUI(searchText text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing:7) {
            
            Text("Looking for an agent not on this list?")
                .medium14
            
            HStack(spacing:8) {
                Image("search_")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.darkBlue)
                    .frame(width: 16, height: 16)
                
                TextField("Search here", text: text)
                    .autocorrectionDisabled()
                    .regular14
            }
            .frame(height: 50)
            .padding(.horizontal, 20)
            .roundedShadowNew()
        }
    }
    
    private func listOfAgents(models: Binding<[AgentModel]>) -> some View {
        VStack(spacing: 15) {
         
            ForEach((0..<models.wrappedValue.count), id: \.self) { index in
                    
                HStack(spacing: 0) {
                    
                    Image("profilewoman")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        
                        Text(models[index].wrappedValue.name)
                            .semibold18
                        
                        Text(models[index].wrappedValue.company)
                            .regular14
                    }
                    .foregroundColor(.black)
                    .padding(.leading, 12)
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        
                        Image("chat_ic")
                            .resizable()
                            .scaledToFill()
                            .padding(9)
                            .frame(width: 35, height: 35)
                            .background(
                                Circle()
                                    .fill(Color.secondaryPurple)
                            )
                            .makeButton {}
                        
                        Image(systemName: models[index].wrappedValue.isSelected ? "checkmark.circle" : "circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.darkBlue)
                            .frame(width: 22, height: 22)
                        
                    }
                }
                .padding(EdgeInsets(top: 13, leading: 25, bottom: 9, trailing: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .roundedShadowNew()
                .makeButton {
                    agents[index].isSelected.toggle()
                    originalMock[index].isSelected.toggle()
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct SelectAgentOwner_Previews: PreviewProvider {
    static var previews: some View {
        SelectAgentOwner()
    }
}

struct AgentModel {
    let name: String
    let company: String
    var isSelected: Bool = false
}

let agentsMock = [
    AgentModel(name: "John Doe", company: "Castle Realtor Group"),
    AgentModel(name: "Jane Smith", company: "Lighthouse Realtor Group"),
    AgentModel(name: "Bob Johnson", company: "Jackson Realty"),
    AgentModel(name: "Alice Williams", company: "Lighthouse Realtor Group"),
    AgentModel(name: "Tom Lee", company: "Jackson Realty")
]
