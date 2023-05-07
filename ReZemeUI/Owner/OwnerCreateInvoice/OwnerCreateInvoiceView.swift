//
//  OwnerCreateInvoiceView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI

struct OwnerCreateInvoiceView: View {
    
    @State var titleTF = "Enter Title"
    @State var descriptionTF = ""
    @State var categotyName = ""
    @State var amount = ""
    @State var images: [UIImage] = []
    @State var date = Date()
    @State var canAccess = false
    @State var showCalendar = false
    private let priorities = ["Rent","Late Fee","Other Fees"]
    private let players = ["John Doe","Melissa Reed", "Jake Jackson","Michael Green", "Jake Jackson", "Michael Green"]
    private let currens = ["Dollar","EURO", "RUB"]
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
        
    @State var switchButton: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 28) {
                
                VStack(spacing: 0) {
                    headerTitleImage(image: "category", title: "Category")
                        .padding(.top, 22)
                    DropDownMenu(
                        titles: priorities.map({ $0}),
                        selectedIndex: { selectedIndex in },
                        content: { }
                    )
                    .padding(.top, 11)
                    
                    TextFieldWithIcon(image: "category", topTitle: "Category Name", text: $categotyName, textFiledStyle: .simple, emailError:.constant(false))
                        .padding(.top,18)
                    
                    Group {
                        headerTitleImage(image: "calendar", title: "Due On")
                            .padding(.top, 24)
                        
                        calendarField(date: $date)
                            .padding(.top, 11)
                        
                        VStack {
                            headerTitleImage(image: "dollar-circle", title: "Amount")
                            
                            HStack {
                                TextField("Amount", text: $amount)
                                    .keyboardType(.numberPad)
                                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                    
                                HStack {
                                    LineView()
                                        .rotated(Angle(degrees: 90))
                                    
                                    Text("Dollar")
                                        .foregroundColor(Color.black)
                                    
                                    Image("arrow-down")
                                }
                                .padding(10)
                                
                                .makeButton {
                                    
                                }
                            }
                            .roundedShadowNew()
                        }
                        .padding(.top,10)
                        
                        CustomSwitch(title: "Mark as paid") { t in
                            print(t)
                        }
                        
                        headerTitleImage(image: "profile", title: "Payer / Payee")
                            .padding(.top, 22)
                        
                        DropDownMenu(
                            titles: players.map({ $0 }),
                            selectedIndex: { selectedIndex in },
                            content: {}
                        )
                        .padding(.top,10)
                        
                        TextFieldWithIcon(image: "document-text", topTitle: "Details",placeHolder: "Some details about this invoice", text: $descriptionTF, textFiledStyle: .textView, emailError:.constant(false))
                            .padding(.top,18)
                        headerTitleImage(image: "cloudUpload", title: "Upload a File")
                            .padding(.top, 22)
                        
                        uploadPhotoView(photos: $images) {  }
                            .padding(.top, 8)
                    }
                    
                    
                    CustomSwitch(title: "Reoccurring Payment") { t in
                        print(t)
                    }
                    .padding(.top,10)
                }
                .padding(
                    EdgeInsets(top: 0, leading: 18, bottom: 25, trailing: 18)
                )
                .roundedShadow()
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ActionButton("Create", action: {})
                    .padding(.horizontal, 20)
            }
            .onTapGesture {
                UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
            }
        }
        .navigationOwner(title: "Create Invoice")
        
    }
}

//MARK: - UI Components
extension OwnerCreateInvoiceView {
    
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
    
}

struct OwnerCreateInvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerCreateInvoiceView()
    }
}




