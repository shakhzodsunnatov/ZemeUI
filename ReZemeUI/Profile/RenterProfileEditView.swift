//
//  EditProfileView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 25/04/23.
//

import SwiftUI

struct RenterProfileEditView: View {
    
    //MARK: - PROPERTIES
    
    @StateObject var viewModel = RenterProfileViewModel()
    
    @State var selectedNeighborhoodIDs: [Int] = []
    @State var timeCount = 1
    @State var timeType: TimeFormatType = .hr
    let timeTypes = TimeFormatType.allCases
    @State var transportOptions = ["Subway", "Car", "Train"]
    
    private let mockdata = neighMockData
    
    @State var importantHomeModels = [
        CheckableModel(title: "Parking", image: "Park"),
        CheckableModel(title: "Parking", image: "agent_doorman"),
        CheckableModel(title: "Parking", image: "agent_gym"),
        CheckableModel(title: "Parking", image: "roofdeck"),
        CheckableModel(title: "Parking", image: "agent_elevator"),
        CheckableModel(title: "Parking", image: "agent_pool"),
        CheckableModel(title: "Parking", image: "Park"),
        CheckableModel(title: "Parking", image: "agent_doorman"),
        CheckableModel(title: "Parking", image: "agent_gym"),
        CheckableModel(title: "Parking", image: "roofdeck"),
        CheckableModel(title: "Parking", image: "agent_elevator"),
        CheckableModel(title: "Parking", image: "agent_pool")
    ]
    @State var importHameSelectedIDs: [Int] = []
    
    private let incomeRanges = [
        "<$25K",
        "$75K–$100K",
        "$25K-$50K",
        "$100K–$150K",
        "$50K–$75K",
        ">$150K"
    ]
    private let creditScore = [
        "<550",
        "650-700",
        "550-600",
        "700-750",
        "600-650",
        ">750"
    ]
    @State var incomeRangesSelectedStr: [String] = []
    @State var creditScoreSelectedStr: [String] = []
    
    private let columns = [
        GridItem(.flexible(),spacing: 18),
        GridItem(.flexible(),spacing: 18)
    ]
    
    
    //MARK: - body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                textFields()
                    .padding(.top, 22)

                ExpandableProfileCell("What’s most Important to you in a neighborhood?") {

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Select in order of importance")
                            .regular16

                        gridNeighborhoodGrid(importance: mockdata)
                    }

                }

                ExpandableProfileCell("Work Commute Info") {

                    VStack(spacing: 0) {

                        TextFieldWithIcon(
                            image: "mapPin_red",
                            topTitle: "Where do you work?",
                            placeHolder: "Location" ,
                            text: $viewModel.workPlace,
                            textFiledStyle: .simple,
                            accType: .AGENT,
                            emailError: .constant(false)
                        )
                        .padding(.top, 17)

                        iconAndTitleHeader(image: "clock", title: "What is the time you take to get to work?")
                            .padding(.top,24)

                        timePicker(time: $timeCount)
                            .padding(.top, 9)

                        iconAndTitleHeader(image: "briefcase", title: "How do you get to work?")
                            .padding(.top, 24)

                        ExpandableSimpleCell(options: transportOptions) { transportIndex in
                            debugPrint("Transport: \(transportOptions[transportIndex])")
                        }
                        .padding(.top, 9)
                    }

                }
                
                ExpandableProfileCell("What’s most Important in your home?") {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("Select all that apply")
                            .regular16
                        
                        importantHomeGrid(array: $importantHomeModels)
                            .padding(.top, 9)
                            .padding(.horizontal, -18)
                        
                    }
                    .padding(.top, 5)
                }
                
                ExpandableProfileCell("Income and Credit Score") {
                    VStack(spacing: 24) {

                        paymentGridViews(
                            title: "What’s your approximate yearly household income range?",
                            values: incomeRanges,
                            selectedStr: incomeRangesSelectedStr
                        ) { index in
                            let selectedValue = incomeRanges[index]

                            if incomeRangesSelectedStr.contains(selectedValue) {
                                incomeRangesSelectedStr.removeAll(where: { $0 == selectedValue })
                            } else {
                                incomeRangesSelectedStr.append(selectedValue)
                            }
                        }

                        paymentGridViews(
                            title: "What’s your approximate credit score?",
                            values: creditScore,
                            selectedStr: creditScoreSelectedStr
                        ) { index in
                            let selectedValue = creditScore[index]

                            if creditScoreSelectedStr.contains(selectedValue) {
                                creditScoreSelectedStr.removeAll(where: { $0 == selectedValue })
                            } else {
                                creditScoreSelectedStr.append(selectedValue)
                            }
                        }

                    }
                    .padding(.top, 11)
                }
                
                
                ActionButton("Save", action: {

                })
                .padding(.horizontal,65)
                .padding(.top,20)
            }
        }
        .navigationRenter(
            title: "Edit Profile",
            rightButton: navBarButton {
                //TODO: - Nav Bar Profile Button action
            }
        )
    }
}


//MARK: - UI Components

extension RenterProfileEditView {
    
    private func textFields() -> some View {
        VStack(spacing: 20) {
            
            TextFieldWithIcon(
                image: "profile_agent_red",
                topTitle: "Full Name",
                placeHolder: "Full Name" ,
                text: $viewModel.fullName,
                textFiledStyle: .simple,
                accType: .AGENT,
                emailError: .constant(false)
            )
            
            TextFieldWithIcon(
                image: "mail-agent",
                topTitle: "Email",
                placeHolder: "Email" ,
                text: $viewModel.email,
                textFiledStyle: .simple,
                accType: .AGENT,
                emailError: .constant(false)
            )
            
            TextFieldWithIcon(
                image: "lock-agent",
                topTitle: "Password",
                placeHolder: "Password" ,
                text: $viewModel.password,
                textFiledStyle: .simple,
                accType: .AGENT,
                emailError: .constant(false)
            )
            
            TextFieldWithIcon(
                image: "mapPin_red",
                topTitle: "Location",
                placeHolder: "Location" ,
                text: $viewModel.location,
                textFiledStyle: .simple,
                accType: .AGENT,
                emailError: .constant(false)
            )
        }
        .padding(EdgeInsets(top: 16, leading: 18, bottom: 24, trailing: 16))
        .roundedShadow()
        .padding(.horizontal, 20)
    }
    
    private func gridNeighborhoodGrid(importance: [NeighborhoodModel]) -> some View {
        LazyVGrid(columns: columns, spacing: 6) {
            ForEach((0..<importance.count), id: \.self) { index in
                neighborhoodItem(
                    image: importance[index].imageName,
                    title: importance[index].name,
                    index: (selectedNeighborhoodIDs.firstIndex(of: importance[index].id) ?? 1)+1,
                    isActive: selectedNeighborhoodIDs.contains(importance[index].id)
                )
                .makeButton {
                    if selectedNeighborhoodIDs.contains(importance[index].id) {
                        selectedNeighborhoodIDs.removeAll(where: { importance[index].id == $0 })
                    } else {
                        selectedNeighborhoodIDs.append(importance[index].id)
                    }
                }
            }
        }
    }
    
    private func neighborhoodItem(image: String, title: String, index: Int, isActive: Bool) -> some View {
        ZStack(alignment: .topTrailing) {
            
            HStack(spacing: 4) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .padding(6)
                    .frame(width: 30, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondaryPurple.opacity(0.15))
                    )
                
                Text("Parks Nearby")
                    .medium12
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(6)
            .frame(minHeight: 43)
            .frame(maxWidth: .infinity)
            .roundedShadow()
            .padding(.top, 10)
            
            if isActive {
                Image(systemName: "\(index).circle")
                    .resizable()
                    .scaledToFill()
                    .font(.title.weight(.light))
                    .foregroundColor(.darkBlue)
                    .frame(width: 25, height: 25)
                    .background(
                        Circle()
                            .fill(Color.white)
                    )
            }
        }
        
    }
    
    private func navBarButton(action: @escaping ()->Void) -> AnyView {
        AnyView(
            ZStack {
                Image("profile-agent")
                    .resizable()
                    .scaledToFill()
                    .padding(15)
                    .frame(width: 50, height: 50)
                    .roundedShadow(cornerRadius: 16)
                
                
            }.makeButton(action: action)
        )
    }
    
    private func iconAndTitleHeader(image: String, title: String) -> some View {
        HStack(spacing: 7) {
            
            Image(image)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.secondaryPurple)
                .scaledToFill()
                .frame(width: 18, height: 18)
            
            Text(title)
                .regular14
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
    
    private func timePicker(time: Binding<Int>) -> some View {
        TimePickerUI(time: $timeCount) { type in
            timeType = type
        }
    }
    
    private func importantHomeGrid(array models: Binding<[CheckableModel]>) -> some View {
        ScrollView(showsIndicators: true) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach((0..<models.wrappedValue.count), id: \.self) { index in
                    CheckableImageWithTitle(
                        model: models[index].wrappedValue,
                        isSelected: importHameSelectedIDs.contains(index)
                        
                    ) { isSelected in
                        if isSelected {
                            importHameSelectedIDs.append(index)
                        } else {
                            importHameSelectedIDs.removeAll(where: {$0 == index })
                        }
                    }
                }
            }
            .padding(5)
            .padding(.horizontal, 18)
        }
        
        .frame(height: 150)
    }
    
    private func paymentGridViews(title: String, values: [String], selectedStr: [String], selectedIndex: @escaping (Int)->Void) -> some View {
        VStack(spacing: 10) {
            
            HStack(alignment: .top, spacing: 7) {
                Image("card-receive_ic")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.secondaryPurple)
                    .frame(width: 18, height: 18)
                
                Text(title)
                    .regular14
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            
            LazyVGrid(columns: columns, spacing: 17) {
                ForEach((0..<values.count), id: \.self) { index in
                    
                    HStack(spacing: 9) {
                        
                        Image(systemName: "\(selectedStr.contains(values[index]) ? "checkmark." : "")circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.blue)
                            .frame(width: 20, height: 20)
                        
                        Text(incomeRanges[index])
                            .regular14
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .makeButton {
                        selectedIndex(index)
                    }
                }
            }
        }
    }
}


struct RenterProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        RenterProfileEditView()
    }
}
