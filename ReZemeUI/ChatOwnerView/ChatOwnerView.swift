//
//  ChatOwnerView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 06/05/23.
//

import SwiftUI

struct ChatOwnerView: View {
    
    //MARK: - PROPERTIES
    
    @State var searchText = ""
    @State var selectedIndex = 0
    
    @State var tenantProperties = propertiesMockData
    
    @State var applicationProperties = propertiesMockData
    
    @State var agents = agentsMock
    
   
    
    //MARK: - body
    
    var body: some View {
        GeometryReader { geo in
            
            VStack(alignment: .center, spacing: 0) {  //MARK: - NAV BAR
                
                VStack(spacing: 13) {
                    
                    navbarTitleWithImage
                        .frame(maxWidth: SCREEN_WIDTH - 40)
                        .padding(.top, geo.safeAreaInsets.top)
                    
                    searchFieldNavBar { searchText = "" }
                        .padding(.bottom, 20)
                    
                }
                .frame(width: SCREEN_WIDTH)
                .background(
                    Image("top-background-secondary")
                        .resizable()
                        .overlay(
                            Color.white.opacity(0.3)
                        )
                )
                
                if searchText.isEmpty {
                    ToggleUI(
                        changeValue: $selectedIndex,
                        titles: ["Tenants","Applicants", "Agents"]) { index in
                            selectedIndex = index
                        }
                        .padding(.top, 19)
                        .padding(.horizontal, 20)


                    TabView(selection: $selectedIndex) {

                        listOfTenants(properties: tenantProperties)
                            .frame(width: SCREEN_WIDTH)
                            .tag(0)

                        listOfApplications(properties: [mockProperty,mockProperty,mockProperty,mockProperty,mockProperty])
                            .frame(width: SCREEN_WIDTH)
                            .tag(1)

                        listOfAgnets(agents: agents)
                            .frame(width: SCREEN_WIDTH)
                            .tag(2)

                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                } else {
                    searchView()
                }
                
            }
            .ignoresSafeArea()
            .onTapGesture {
                dismissKeyboard()
            }
            .onChange(of: searchText) { newValue in
                
                if newValue.isEmpty {
                    tenantProperties = propertiesMockData
                    applicationProperties = propertiesMockData
                    agents = agentsMock
                } else {
                    agents = agents.filter({ $0.name.uppercased().contains(newValue) })
                    tenantProperties = tenantProperties.filter({ ($0.generalInformation?.propertyName ?? "").uppercased().contains(newValue) })
                    applicationProperties = applicationProperties.filter({ ($0.generalInformation?.propertyName ?? "").uppercased().contains(newValue) })
                }
                
            }
            
        }
        .ignoresSafeArea()
    }
}


//MARK: - UI Components

extension ChatOwnerView {
    
    private var navbarTitleWithImage: some View {
        HStack(alignment: .center, spacing: 0) {
            
            Spacer()
            
            Text("Chat")
                .semibold22
                .foregroundColor(.white)
                .padding(.leading,36)
            
            Spacer()
            
            AsyncImage(
                url: "/",
                placeHolderState: .circle,
                placeHolderFor: .AGENT
            )
                .scaledToFill()
                .frame(width: 36,height: 36)
                .clipped()
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(1), lineWidth: 5)
                )
                .background(Color.white)
                .clipShape(Circle())
        }
    }
    
    private func searchFieldNavBar(settingBtnAction action: @escaping ()->Void) -> some View {
        HStack(spacing: 10) {
            
            Image("location_ic")
                .resizable()
                .scaledToFit()
                .frame(width: 16)
            
            TextField("Search", text: $searchText)
                .autocorrectionDisabled()
            
            Spacer()
            
            if !searchText.isEmpty {
                Button(action: action) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.secondaryPurple)
                        .padding(.trailing, 25)
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.leading, 17)
        .frame(width: SCREEN_WIDTH-40, height: 50)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func listOfApplications(properties models: [Property]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ForEach((0..<models.count), id: \.self) { index in
                
                ChatCard(
                    completedUntilNumber: 3,
                    model: models[index]
                ) {
                    //TODO: - Open Chat View
                }
                .roundedShadowNew()
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
            }
            .padding(.top, 15)
            
        }
    }
    
    private func listOfTenants(properties models: [Property]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ForEach((0..<models.count), id: \.self) { index in
                
                TenantsCard(
                    completedUntilNumber: 3,
                    model: models[index]
                ) {
                    //TODO: - Open Chat View
                }
                .roundedShadowNew()
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
            }
            .padding(.top, 15)
        }
    }
    
    private func listOfAgnets(agents models: [AgentModel]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ForEach((0..<models.count), id: \.self) { index in
                
                HStack(spacing: 12) {
                    
                    Image("profilewoman")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(models[index].name)
                            .medium16
                        
                        Text(models[index].company)
                            .medium12
                    }
                    
                    Spacer()
                    
                    Image("chat_ic")
                        .resizable()
                        .scaledToFill()
                        .padding(11)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.secondaryPurple)
                        )
                        .makeButton {}
                    
                }
                .padding(.horizontal, 15)
                .frame(height: 77)
                .frame(maxWidth: .infinity)
                .roundedShadowNew()
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
            }
            .padding(.top, 15)
            
        }
    }
    
    private func searchView() -> some View {
        ScrollView(showsIndicators: false) {
            
            ForEach((0..<3), id: \.self) { sectionIndex in
                let section = ["Agent","Tenants","Applicants"]
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(section[sectionIndex])
                        .semibold18
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                    
                    switch sectionIndex {
                        
                    case 0:
                        
                        listOfAgnets(agents: agents)
                            .frame(width: SCREEN_WIDTH)
                        
                    case 1:
                        
                        listOfTenants(properties: tenantProperties)
                        .frame(width: SCREEN_WIDTH)
                        
                        
                    case 2:
                        
                        listOfApplications(properties: applicationProperties)
                        .frame(width: SCREEN_WIDTH)
                        
                    default: EmptyView()
                    }
                }
                
            }
            
        }
    }
}



struct ChatOwnerView_Previews: PreviewProvider {
    static var previews: some View {
        ChatOwnerView()
    }
}
