//
//  RenterFilterView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 28/04/23.
//

import SwiftUI

struct RenterFilterView: ViewModifier {
    
    //MARK: - PROPERTIES
    
    @Binding var isActive: Bool
    @StateObject var viewModel: FilterViewModel
    
    @State var easyApplyTipShow = false
    
    // init
    init(isPresent: Binding<Bool>,viewModel: StateObject<FilterViewModel>) {
        self._isActive = isPresent
        self._viewModel = viewModel
    }
    
    
    //MARK: - body
    
    func body(content: Content) -> some View {
        ZStack {
            
            content
            
            if isActive {
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        
                        filterHeaderView { viewModel.deselectAll() }
                            .padding(.top, 19)
                        
                        textFieldUI(text: $viewModel.searchText)
                            .padding(.top, 13)
                        
                        easyApplyPropertyHeader {
                            
                            bedroomsView()
                            
                            bathroomsView()
                        }
                        .padding(.top, 26)
                        
                        
                        monthlyRentView()
                        
                        
                        HeaderWithImageTitleTip(
                            image: "wallet",
                            title: "Total Upfront Cost",
                            tipStr: "Includes first month, broker fee, deposit...etc."
                        ) {
                            
                            VStack(spacing: 0) {
                                
                                upfrontTextField(text: $viewModel.totalUpfrontCost)
                                    .padding(.top,4)
                                
                                
                                totalMonthlyTextField(text: $viewModel.totalMonthlyCost)
                                    .padding(.top, 20)
                                
                                amenitiesView(models: viewModel.amenitiesValues.sorted(by: { $0.key < $1.key })) { key in
                                    viewModel.amenitiesChangeValue(by: key)
                                }
                                .padding(.top, 25)
                                
                                Divider()
                                    .padding(.top,15)
                            }
                            
                        }
                        .padding(.top, 14)
                        
                        squareFootageView()
                        
                        moveInDateView(date: $viewModel.moveInDate)
                        
                        timeToWorkView(timeCount: $viewModel.timeToWorkCount)
                            .padding(.top,17)
                        
                        appleButton {
                            viewModel.applyAction()
                        }
                        .padding(.top, 33)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 17,
                            bottom: 26,
                            trailing: 20
                        )
                    )
                    
                }
                .roundedShadowNew()
                .padding(.horizontal,22)
                .padding(.bottom, 17)
                .offset(y:-5)
                
                .onChange(of: viewModel.totalUpfrontCost) { newValue in
                    viewModel.totalUpfrontCost = formatMoney(value: newValue.digits)
                }
                .onChange(of: viewModel.totalMonthlyCost) { newValue in
                    viewModel.totalMonthlyCost = formatMoney(value: newValue.digits)
                }
                .onChange(of: viewModel.moveInDate) { newValue in
                    viewModel.moveInDate = format(with: "XX/XX/XXX", phone: newValue)
                }
            }
            
        }
    }
}


//MARK: - View Modify

extension View {
    
    func renterFilterView(isPresent: Binding<Bool>, viewModel: StateObject<FilterViewModel>) -> some View {
        modifier(
            RenterFilterView(isPresent: isPresent, viewModel: viewModel)
        )
    }
    
}


struct RenterFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Color.blue
            
            Text("Hello")
            
        }
        
        .renterFilterView(isPresent: .constant(true), viewModel: StateObject(wrappedValue: FilterViewModel()))
    }
}
