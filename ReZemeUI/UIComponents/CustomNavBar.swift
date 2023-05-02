//
//  CustomNavBar.swift
//  ReZeme
//
//  Created by Shakhzod on 28/03/23.
//

import SwiftUI


struct CustomNavBar<Content: View>: View {
    
    @Environment(\.presentationMode) var presentationMode
    //MARK: - PROPERTIES
    
    @State private var search: String = ""
    private let content: Content
    private let title: String
    private let style: HeaderStyle
    private let type: HeaderType
    private let image: String
    private let action: (() -> Void)
    private var backHidden: Bool
    
    //MARK: - init
    
    init(
        @ViewBuilder content: () -> Content,
        title: String = "Title",
        style: HeaderStyle = .filteredinput,
        type: HeaderType = .buyer,
        image: String = "",
        action: @escaping () -> Void = {},
        backHide: Bool = true
    ) {
        self.content = content()
        self.title = title
        self.style = style
        self.type = type
        self.image = image
        self.action = action
        self.backHidden = backHide
    }
    
    
    //MARK: - Body
    
    var body: some View {
        GeometryReader { geo in
            
            VStack(spacing: 0) {
                
                HStack {
                    
                    switch style {
                        
                    case .title:
                        
                        titleNavbar()
                        
                    case .filteredtitle:
                        
                        filteredTitle()
                        
                    case .filteredinput:
                        
                        filteredStackedInput()
                        
                    case .filteredstackedinput:
                        
                        filteredInput()
                        
                    case .customimagetitle:
                        
                        customImageTitle()
                        
                    case .newAgentMainFilter:
                        
                        agentMainTitle()
                        
                    case .newTitleAndIcon:
                        
                        agentTitleAndIcon()
                        
                    case .newSearchWithTitle:
                        filterWithTitle()
                    }
                    
                }
                .padding(.top, geo.safeAreaInsets.top)
                .padding(.bottom, 20)
                .frame(width: SCREEN_WIDTH)
                .background(
                    Image(type.bgImageStr)
                        .resizable()
                )
                
                ZStack {
                    Color.clear
                    content
                }
            }
            .edgesIgnoringSafeArea(.top)
            .onTapGesture {
                UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
            }
        }
    }
}



//MARK: - NavBar UI Components

extension CustomNavBar {
    
    func titleNavbar() -> some View {
        ZStack {
            HStack {
                if backHidden {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("arrow-left")
                        
                    }
                    .padding(.leading,20)
                }
                
                Spacer()
            }
            
            Text(title)
                .foregroundColor(.white)
                .semibold22
        }
    }
    
    func filteredTitle() -> some View {
        HStack {
            Spacer()
            Text(title)
                .foregroundColor(.white)
                .bold(size: 26)
                .padding(.top, 10)
                .padding(.trailing, -80)
            Spacer()
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .padding(5)
                    .overlay(ZStack {Image("filter")
                        .frame(width: 60, height: 60)}).padding(.trailing, 20)
            }
        }
    }
    
    func filteredInput() -> some View {
        HStack {
            Spacer()
            Text(title)
                .foregroundColor(.white)
                .bold(size: 26)
                .padding(.top, 10)
                .padding(.trailing, -80)
            Spacer()
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .padding(5)
                    .overlay(
                        ZStack {
                            Image(image)
                                .frame(width: 60, height: 60)
                        }
                    )
                    .padding(.trailing, 20)
                    .onTapGesture { action() }
            }
        }
    }
    
    func filteredStackedInput() -> some View {
        HStack {
            HStack {
                Image("placeholderLocationIcon")
                    .renderingMode(.template)
                    .foregroundColor(.secondaryPurple)
                
                TextField("Queens, NY", text: $search)
                    .light16
                    .foregroundColor(Color.black)
            }
            .padding()
            .background(Color.white)
            .frame(height: 52)
            .cornerRadius(16)
            .glow(radius: 10)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55)
                    .padding(5)
                    .overlay(
                        ZStack {
                            Image("filter")
                                .frame(width: 40, height: 40)
                        }
                    )
                    .padding(.trailing, 20)
                    .onTapGesture {}
            }
        }
        .padding(.leading)
    }
    
    func customImageTitle() -> some View {
        ZStack {
            TextField("Search", text: $search)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(16)
                .foregroundColor(Color(UIColor.lightGray))
                .shadow(radius: 10)
                .light(size: 16)
            
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.secondaryPurple.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .padding(5)
                        .overlay(ZStack {Image("filter-agent")
                            .frame(width: 40, height: 40)})
                }
            }
        }
        .padding([.leading, .trailing])
    }
    
    func agentMainTitle() -> some View {
        HStack {
            HStack {
                Image("placeholderLocationIcon")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                
                TextField("Search", text: $search)
                    .light16
                    .foregroundColor(Color.black)
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color.purpleLow.opacity(0.1))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Button {
                                 action()
                            } label: {
                                Image("filter")
                                    .renderingMode(.template)
                                    .foregroundColor(Color.purpleLow)
                                    .frame(width: 40, height: 40)
                            }
                        )
                        .onTapGesture {}
                }
            }
            .padding(.leading,20)
            .padding([.trailing,.vertical],5)
            .background(Color.white)
            .frame(height: 55)
            .cornerRadius(16)
            .glow(radius: 10)
            
            Button {
                
            } label: {
                Image("person")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40,height: 40)
                    .cornerRadius(20)
            }
        }
        .padding(.horizontal)
    }
    
    func agentTitleAndIcon() -> some View {
        ZStack {
            HStack {
                if backHidden {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("arrow-left")
                        
                    }
                }
                
                Spacer()
                
                Button {

                } label: {
                    Image("person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40,height: 40)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal,20)
            
            Text(title)
                .foregroundColor(.white)
                .semibold22
                .padding(.top, 10)
        }
       
    }
    
    func filterWithTitle() -> some View {
        VStack {
            Text(title)
                .foregroundColor(.white)
                .semibold22
                .padding(.top, 10)
            
            HStack {
                HStack {
                    Image("placeholderLocationIcon")
                        .renderingMode(.template)
                        .foregroundColor(.blue)
                    
                    TextField("Search", text: $search)
                        .light16
                        .foregroundColor(Color.black)
                }
                .frame(height: 50)
                .padding(.horizontal,18)
                .background(Color.white)
                .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.top,15)
        }
        
    }
    
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(content: {
            ZStack {
                Color.green
                Text("Hello")
            }
        }, type: .buyer)
        
        CustomNavBar(content: {
            ZStack {
                Color.white
                Text("Hello")
            }
        }, title:"232",style: .newTitleAndIcon, type: .agent)
        
    }
}
