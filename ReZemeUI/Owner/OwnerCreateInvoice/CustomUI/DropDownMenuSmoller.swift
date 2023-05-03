//
//  DropDownMenuSmoller.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI


struct DropDownMenuSmoller<Content: View>: View {
    
    //MARK: - PROPERTIES

    @State private var selectedTitle: String
    private let titles: [String]
    private let selectedIndex: (Int)->Void
    
    private let content: ()->Content
    
    @State private var isActive = false
    var borderColor: Color = .blue
    
    init(
        selectedTitle: String? = nil,
        titles: [String],
        selectedIndex: @escaping (Int)->Void,
        borderColor: Color = .white,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selectedTitle = State(wrappedValue: (selectedTitle != nil ? selectedTitle! : titles.first ?? "Place Holder"))
        self.titles = titles
        self.selectedIndex = selectedIndex
        self.content = content
        self.borderColor = borderColor
    }
    
    
    //MARK: - body
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(spacing: 0) {
                
                HStack {
                    
                    Text(selectedTitle)
                        .regular11
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .rotated(Angle(degrees: isActive ? 180:0))
                }
                .foregroundColor(.black)
                .makeButton {
                    withAnimation {
                        isActive.toggle()
                    }
                }
                
                
                if isActive {
                    VStack(spacing: 0) {

                        LineView()
                            .padding(.top, 15)


                        ForEach((0..<titles.count), id: \.self) { index in
                            menuItem(title: titles[index])
                                .makeButton {
                                    selectedTitle = titles[index]
                                    selectedIndex(index)
                                    withAnimation {
                                        isActive.toggle()
                                    }
                                }

                            Divider()
                                .opacity(index == titles.count-1 ? 0:1)
                        }
                    }
                }
                
            }
            .padding(10)
            .roundedShadowNew()
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
    }
}


//MARK: - UI

extension DropDownMenuSmoller {
    
    private func menuItem(title: String) -> some View {
        HStack {
            Text(title)
                .regular11
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .frame(height: 30)
        .padding(.horizontal,10)
    }
    
}

struct DropDownMenuSmoller_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenuSmoller(titles: ["a", "b", "C"], selectedIndex: {_ in} ,content: {
            Text("Service request is not urgent and can be addressed within the next 1-2 weeks")
                .regular11
                .padding(.top, 11)
        })
    }
}


struct DropDownMenuNew<Content: View>: View {
    
    //MARK: - PROPERTIES

    @State private var selectedTitle: String
    private let titles: [String]
    private let selectedIndex: (Int)->Void
    
    private let content: ()->Content
    
    @State private var isActive = false
    
    init(
        selectedTitle: String? = nil,
        titles: [String],
        selectedIndex: @escaping (Int)->Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selectedTitle = State(wrappedValue: (selectedTitle != nil ? selectedTitle! : titles.first ?? "Place Holder"))
        self.titles = titles
        self.selectedIndex = selectedIndex
        self.content = content
    }
    
    
    //MARK: - body
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            VStack(spacing: 0) {
                
                HStack {
                    
                    Text(selectedTitle)
                        .medium16
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .rotated(Angle(degrees: isActive ? 180:0))
                }
                .foregroundColor(.black)
                .makeButton {
                    withAnimation {
                        isActive.toggle()
                    }
                }
                
                
                if isActive {
                    VStack(spacing: 0) {

                        LineView()
                            .padding(.top, 15)

                        linkButton(title: "Manage Maintenance List",type: .RENTER,stoke: true) {
                            
                        }
                        .padding(.vertical,12)
                        
                        ForEach((0..<titles.count), id: \.self) { index in
                            menuItem(title: titles[index])
                                .makeButton {
                                    selectedTitle = titles[index]
                                    selectedIndex(index)
                                    withAnimation {
                                        isActive.toggle()
                                    }
                                }

                            Divider()
                                .opacity(index == titles.count-1 ? 0:1)
                        }
                    }
                }
                
            }
            .padding(19)
            .roundedShadowNew()
            
        }
    }
}


//MARK: - UI

extension DropDownMenuNew {
    
    private func menuItem(title: String) -> some View {
        HStack {
            Text(title)
                .medium14
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal,10)
    }
    
    func linkButton(title: String,type:AccountType = .AGENT,stoke: Bool = false ,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                
                if stoke {
                    RoundedRectangle(cornerRadius: 23.5)
                        .stroke(type == .AGENT ? Color.purpleGradient.toLinearGradient : Color.blueGradient.toLinearGradient,lineWidth: 1)
                        .frame(height: 47)
                        .overlay (
                            Text(title)
                                .foregroundColor(type == .AGENT ? Color.purpleLow : Color.darkBlue )
                                .bold18
                        )
                } else {
                    RoundedRectangle(cornerRadius: 23.5)
                        .fill(type == .AGENT ? Color.purpleGradient.toLinearGradient : Color.blueGradient.toLinearGradient)
                        .frame(height: 47)
                        .overlay (
                            Text(title)
                                .foregroundColor(.white)
                                .bold18
                        )
                }
            }
            
        }
    }
    
}

struct DropDownMenuNew_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenuNew(titles: ["a", "b", "C"], selectedIndex: {_ in} ,content: {
            Text("Service request is not urgent and can be addressed within the next 1-2 weeks")
                .regular11
                .padding(.top, 11)
        })
    }
}
