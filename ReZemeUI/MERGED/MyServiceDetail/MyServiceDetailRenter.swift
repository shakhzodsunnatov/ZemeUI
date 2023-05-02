//
//  MyServiceDetail.swift
//  ReZemeUI
//
//  Created by Shakhzod on 29/04/23.
//

import SwiftUI

struct MyServiceDetailRenter: View {
    
    @State var titleTF = "Enter Title"
    @State var descriptionTF = ""
    @State var images: [UIImage] = []
    @State var date = Date()
    @State var time = "7:00"
    @State var canAccess = false
    @State var showCalendar = false
    @State var selectedTimeTypeIndex: Int = 2
    @State var isYES = true
    private let timeTypes = TimeType.allCases
    private let priorities = PriorityType.allCases
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
        
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 28) {
                
                VStack(spacing: 0) {
                    
                    headerTitleImage(image: "document", title: "Issue")
                    
                    enterTitleTextField(text: $titleTF)
                        .padding(.top,11)
                    
                    headerTitleImage(image: "document-text", title: "Description")
                        .padding(.top, 22)
                    
                    descriptionTextEditor(text: $descriptionTF)
                        .padding(.top, 11)
                    
                    headerTitleImage(image: "gallery", title: "Add Photo")
                        .padding(.top, 22)
                    
                    uploadPhotoView(photos: $images) {  }
                        .padding(.top, 9)
                    
                    headerTitleImage(image: "timer-pause", title: "Select Urgency")
                        .padding(.top, 22)
                    
                    DropDownMenu(
                        titles: priorities.map({ $0.rawValue }),
                        selectedIndex: { selectedIndex in },
                        content: {
                            
                            VStack(spacing: 0) {
                                Text("Service request is not urgent and can be addressed within the next 1-2 weeks")
                                    .regular11
                                    .padding(.top, 21)
                                
                                headerTitleImage(image: "calendar", title: "Preferred Date for Service")
                                    .padding(.top, 24)
                                
                                calendarField(date: $date)
                                    .padding(.top, 11)
                            }
                            
                        }
                    )
                    .padding(.top, 11)
                    
                    headerTitleImage(image: "clock", title: "Preferred Time for Service")
                        .padding(.top, 22)
                    
                    VStack(spacing: 0) {
                        
                        preferredTime(time: $time)
                        
                        headerTitleImage(image: "key", title: "Can the maintenance team access your apartment without you being present?")
                            .padding(.top,22)
                        
                        radioSelectable(selected: $isYES)
                            .padding(.top, 11)
                    }
                    .padding(.top, 11)
                }
                .padding(
                    EdgeInsets(top: 20, leading: 18, bottom: 25, trailing: 18)
                )
                .roundedShadow()
                .padding(.horizontal, 20)
                
                ActionButton("Submit", action: {})
                    .padding(.horizontal, 20)
            }
        }
        .navigationRenter(title: "New Service Request")
        .onChange(of: time) { newValue in
            time = format(with: "XX:XX", phone: newValue)
        }
    }
}


//MARK: - UI Components
extension MyServiceDetailRenter {
    
    private func headerTitleImage(image: String, title: String) -> some View {
        HStack(alignment: .top, spacing: 5) {
            Image(image)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.darkBlue)
                .frame(width: 18, height: 18)
            
            Text(title)
                .regular14
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func enterTitleTextField(text: Binding<String>) -> some View {
        TextField("Enter Title", text: text)
            .autocorrectionDisabled()
            .medium16
            .padding(20)
            .roundedShadow()
    }
    
    private func descriptionTextEditor(text: Binding<String>) -> some View {
        TextEditorWithPlaceholder(text: text, placeHolder: .constant("Enter Description"))
            .padding(10)
            .roundedShadow()
    }
    
    private func uploadPhotoView(photos: Binding<[UIImage]>, uploadAction: @escaping EmptyClosure) -> some View {
        VStack(spacing: 0) {
            
            if !photos.wrappedValue.isEmpty {
                LazyHGrid(
                    rows: [
                        GridItem(.flexible(), spacing: 50),
                        GridItem(.flexible(), spacing: 50)
                    ], spacing: 20
                ) {
                    
                    ForEach((0..<photos.wrappedValue.count), id: \.self) { index in
                        Image(uiImage: photos.wrappedValue[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(radius: 8, corners: .allCorners)
                    }
                    
                }
                .padding(10)
            } else {
                VStack(spacing: 3) {
                    
                    Text("Tap to upload a photo")
                        .medium16
                    
                    Text("You can add multiple photos")
                        .regular14
                }
                .foregroundColor(.black)
                .padding(.horizontal, 20)
            }
            
        }
        .padding(10)
        .frame(minHeight: 120)
        .frame(maxWidth: .infinity)
        .background(Color.purpleLow.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.purpleLow, style: StrokeStyle(lineWidth: 1, dash: [3]))
        )
        .makeButton(action: uploadAction)
    }
    
    private func calendarField(date: Binding<Date>) -> some View {
        VStack(spacing: 10) {
            HStack {
                Text(formatter.string(from: date.wrappedValue))
                    .medium16
                    .foregroundColor(.black)
                
                Spacer()
                
                Image("calendar_ic")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding(11)
                    .frame(width: 46, height: 46)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blueGradient.toLinearGradient)
                    )
                    .makeButton {
                        withAnimation {
                            showCalendar.toggle()
                        }
                    }
            }
            
            if showCalendar {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .roundedShadowNew()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showCalendar.toggle()
                            }
                        }
                    DatePicker("select", selection: date,in: Date()..., displayedComponents: .date)
                        .frame(height: 300)
                        .datePickerStyle(.graphical)
                        .zIndex(1)
                }
            }
        }
        .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 6))
        .roundedShadow()
    }
    
    private func preferredTime(time: Binding<String>) -> some View {
        HStack {
            TextField("7:00", text: time)
                .autocorrectionDisabled()
                .keyboardType(.numberPad)
                .medium16
                .foregroundColor(.black)
            
            Spacer()
            
            HStack(spacing: 6) {
                
                Picker(
                    selection: $selectedTimeTypeIndex,
                    label:
                        Text("Time Type")
                        .foregroundColor(.black)
                        .medium16
                ) {
                    ForEach((0..<timeTypes.count), id:\.self) { index in
                        Text(self.timeTypes[index].rawValue)
                            .medium16
                            .foregroundColor(.black)
                            .tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                
            }
            .frame(width: 80)
        }
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 14))
        .roundedShadowNew()
    }

    private func radioSelectable(selected: Binding<Bool>) -> some View {
        HStack(spacing: 50) {
            
            HStack(spacing:5) {
                Image(systemName: "\(isYES ? "checkmark." : "")circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.darkBlue)
                    .frame(width: 20, height: 20)
                    .makeButton {
                        withAnimation {
                            isYES = true
                        }
                    }
                
                Text("Yes")
                    .regular14
                    .foregroundColor(.black)
            }
            
            
            HStack(spacing:5) {
                Image(systemName: "\(!isYES ? "checkmark." : "")circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.darkBlue)
                    .frame(width: 20, height: 20)
                    .makeButton {
                        withAnimation {
                            isYES = false
                        }
                    }
                
                Text("No")
                    .regular14
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MyServiceDetailRenter_Previews: PreviewProvider {
    static var previews: some View {
        MyServiceDetailRenter()
    }
}
