//
//  RenterPropertyDetailView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 26/04/23.
//

import SwiftUI

struct RenterPropertyDetailView: View {
    
    var property: Property = mockProperty
//    var annotation: PointAnnotation?
//
//    init(property: Property, annotation: PointAnnotation?) {
//        self.property = property
//        self.annotation = annotation
//    }
    
    @State var isLiked = false
    @State var showUserRegisterAlert: Bool = false
    @State var showLoginView = false
    @State var showRegisterView = false
    
    private var docImagesName = ["bank_ic",
                                 "tag-user_ic",
                                 "key_ic",
                                 "people_ic",
                                 "speed_ic"]
    
    private var docTitles = ["Plaid Verified Financials",
                             "Photo ID",
                             "Rental History",
                             "Employment Verification",
                             "Credit Check"]
    
    private var stateImage = ["scale_red", "roud_4", "roud_3"]
    private var stateBall = [9, 9, 9]
    private var stateDesc = ["Crime Score", "Walkability Score", "Transportation Score"]
    
    private var amenitiesImage = ["agent_gym", "agent_laundry", "agent_roofdeck", "agent_laundry"]
    private var amenitiesTitle = ["Gym", "In-Unit Dishwasher", "Roof Deck", "Laundromat"]
    
    var body: some View {

        ZStack(alignment: .bottom) {
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    VStack(spacing: 13) {

                        showImage(
                            title: "BLVD",
                            price: property.economicInformation?.cost ?? 0
                        )
                        .frame(height: 234)
                        .frame(maxWidth: .infinity)


                        showAddress(
                            city: property.generalInformation?.address ?? "",
                            street: "Unit 16E"
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)


                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. /n Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit")
                            .fixedSize(horizontal: false , vertical: true)
                            .regular12
                            .foregroundColor(Color.textGray)
                            .padding([.horizontal, .top], 10)


                        showInfos()
                            .padding(.top,-4)
                            .padding(.horizontal, 9)


                        Text("Time Listed: 30 days")
                            .medium12
                            .foregroundColor(Color.secondaryPurple)
                            .frame(height: 31)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 9)
                                    .fill(Color.secondaryPurple.opacity(0.1))
                            )
                            .padding(1)
                            .padding(.top,9)

                    }
                    .frame(maxWidth: .infinity)
                    .roundedShadow()
                    .padding(.horizontal, 20)


                    showBenefits()
                        .frame(maxWidth: .infinity)
                        .roundedShadow()
                        .padding(.horizontal,20)
                        .padding(.top, 12)

                    
                    HStack(spacing: 12) {
                        
                        Image("profilewoman")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Melissa Smith")
                                .medium16
                            
                            Text("Castle Realtor Group")
                                .medium12
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: { MessageRenter() }) {
                            Image("messages_ic")
                                .resizable()
                                .scaledToFit()
                                .padding(11)
                                .frame(width: 40, height: 40)
                                .background(
                                    Circle()
                                        .fill(Color.secondaryPurple)
                                )
                        }
                        
                    }
                    .padding(EdgeInsets(top: 14, leading: 15, bottom: 13, trailing: 10))
                    .roundedShadow()
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    

                    Text("Documents Required")
                        .semibold18
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                    
                    showRequiredList(
                        imagesName: docImagesName,
                        title: docTitles
                    )
                    .frame(maxWidth: .infinity)
                    .roundedShadow()
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                        
                    
                    Text("Upfront and Ongoing Costs")
                        .semibold18
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 26)
                    
                    
                    VStack(spacing: 0) {
                        HomeChart(data: [66,91,44,22,55,76,66,120,111,67,97,88,126])
                        
                        VStack(alignment:.leading, spacing: 2) {
                            Text("Month 1: Total upfront cost: $7,200")
                                .medium12
                            
                            Text("Month 2-12: Ongoing estimated monthly costs: $2,640")
                                .medium12
                            
                            Text("**All listed costs are estimated only")
                                .regular11
                                .foregroundColor(.textGray)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.secondaryPurple.opacity(0.2))
                        .cornerRadius(radius: 8, corners: [.bottomLeft,.bottomRight])
                        
                    }
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .roundedShadow()
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
                    
                    
                    showCharts()
                    
                }
                .frame(width: SCREEN_WIDTH)
                .padding(.top, 20)
                
                VStack(spacing: 0) {
                    
                    Text("Neighborhood Stats")
                        .semibold18
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    
                    showNeighborhoodStates(
                        imageName: stateImage,
                        ball: stateBall,
                        desc: stateDesc
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                    
                    
                    createTitleWithButton("Amenities") { /* See All button action here */}
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                    
                    
                    showAmenities(titles: amenitiesTitle, images: amenitiesImage)
                        .padding(.horizontal, 20)
                        .padding(.top, 14)
                    
                    
                    createTitleWithButton("Nearby Locations") { /* See All button action here */}
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.top, 18)
                    
                    showNearbyLocations() // With Mock Data
                        .padding(.bottom, 130)
                        
                }
                .frame(width: SCREEN_WIDTH)
                
            }
            .background(Color.lightGrayBG.opacity(0.1))
            .blur(radius: showUserRegisterAlert ? 25 : 0)
            .onTapGesture {
                withAnimation {
                    self.showUserRegisterAlert = false
                }
            }
            
            
            HStack(spacing:17) {
                
                Button(action: {
                    
                    if false { //!DatabaseManager.isAuthorized() {
                        withAnimation {
                            self.showUserRegisterAlert.toggle()
                        }
                    } else {
                        //TODO: - Apply logic
                    }
                    
                    
                }) {
                    Text("Apply")
                        .semibold18
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(Color.blueGradient.toLinearGradient)
                        )
                }
                
                Button(action: {
                    
                }) {
                    Text("Message")
                        .semibold18
                        .foregroundColor(Color.primaryBlue)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .stroke(Color.primaryBlue, lineWidth: 1)
                        )
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            .background(
                Color.white
                    .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 0)
                    .mask(Rectangle().padding(.top, -20))
            )
            .opacity(showUserRegisterAlert ? 0 : 1)
            
            authViewLinks()
            
        }
        .navigationRenter(title: "Listing Details")
        .edgesIgnoringSafeArea(.bottom)
//        .loginAlert(
//            isActive: $showUserRegisterAlert,
//            loginAction: {
//                withAnimation {
//                    self.showLoginView = true
//                }
//            },
//            createAction: {
//                withAnimation {
//                    self.showRegisterView = true
//                }
//            }
//        )
    }
}


//MARK: - UI components

extension RenterPropertyDetailView {
    
    private func showImage(title: String, price: Int) -> some View {
        ZStack(alignment: .bottom) {
            
            TabView {
                ForEach(property.imageInformation?.images ?? [], id: \.id) { imageModel in
                    
                    propertyImageView(url: imageModel.image )
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            
            VStack {
                
                HStack {
                    
                    Text("Easy Apply")
                        .medium12
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 9)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white, lineWidth: 1)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.black.opacity(0.4))
                        )
                        .padding(.top,4)
                        .padding(.horizontal,6)
                    
                    Spacer()
                
                    Button(action: {
                        isLiked.toggle()
                    }) {
                        Image(isLiked ? "heart_filled" : "heart")
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .frame(width: 32, height: 32)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(5)
                    }
                        
                }
                .padding(.top,8)
                .padding(.horizontal,6)
                
                Spacer()
                
                HStack {
                    Text(title)
                        .padding(.leading,7)
                    
                    Spacer()
                    
                    Text("$" + String(describing: price) + "/mo")
                        .padding(.trailing,7)
                }
                .foregroundColor(.white)
                .semibold18
                .padding(.vertical,5)
                .background(Color.black.opacity(0.3))
                .cornerRadius(radius: 8, corners: [.bottomLeft, .bottomRight])
                
            }
            
        }
        .cornerRadius(8)
    }
    
    private func showAddress(city: String, street: String) -> some View {
        VStack(alignment: .leading, spacing: 9) {
            Text(city)
                .medium14
                
            Text(street)
                .regular14
        }
        .foregroundColor(Color.textGray)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private func showInfos() -> some View {
        let imagesName = ["eye", "heart", "task-square"]
        let titles = ["Views:", "Saves:", "Applications:"]
        let values = ["100", "20", "10"]
        
        return HStack {
            
            ForEach(0..<3, id:\.self) { index in
                
                HStack(spacing: 8) {
                    
                    if index == 2 {
                        Image(imagesName[index])
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.secondaryPurple)
                            .frame(width: 20, height: 20)
                    } else {
                        Image(systemName: imagesName[index])
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.secondaryPurple)
                            .frame(width: 20, height: 20)
                    }
                    
                    Text(titles[index] + values[index])
                        .medium12
                        .foregroundColor(Color.textGray)
                        .scaledToFill()
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func showBenefits() -> some View {
        let imagesName = ["big-beds", "big_baths", "big_footage"]
        let titles = ["Studio", "1 Bath:", "600 sqft"]
        
        return HStack {
            
            ForEach(0..<3, id:\.self) { index in
                
                VStack(spacing: 10) {
                    
                    Image(imagesName[index])
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.secondaryPurple)
                        .frame(width: 36, height: 36)
                    
                    Text(titles[index])
                        .medium14
                        .foregroundColor(Color.textGray)
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            
        }
        .padding(.vertical, 10)
    }
    
    private func showRequiredList(imagesName: [String], title: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            ForEach(0..<imagesName.count, id: \.self) { index in
                
                HStack(spacing:8) {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.primaryBlue.opacity(0.2))
                        .frame(width: 29, height: 29)
                        .overlay(
                            Image(imagesName[index])
                                .resizable()
                                .scaledToFit()
                                .padding(7)
                        )
                    
                    Text(title[index])
                        .medium12
                    
                    Spacer()
                    
                    HStack(spacing:9) {
                        
                        if index == 0 {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.secondaryPurple)
                                .frame(width: 20, height: 20)
                            
                            Text("Uploaded")
                                .medium12
                                .foregroundColor(.secondaryPurple)
                        } else {
                            Image(systemName: "circle")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.red)
                                .frame(width: 20, height: 20)
                            
                            Text("Missing")
                                .medium12
                                .foregroundColor(.red)
                        }
                            
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }.padding(14)
        
    }
    
    private func showCharts() -> some View {
        
        return VStack(alignment: .leading, spacing: 0) {
//            if let annotation {
//                RenterPreviewMap(
//                    annotation: annotation)
//                    .frame(height: 150)
//                    .frame(maxWidth: .infinity)
//                    .cornerRadius(radius: 8, corners: .allCorners)
//            }
            
            Rectangle()
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .cornerRadius(radius: 8, corners: .allCorners)
            
            
            Text("Your commute time at 9:00am is approximately 30 mins")
                .medium14
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 12)
                .padding(.top, 11)
            
            
            VStack(alignment: .leading, spacing: 11) {
                
                HStack(spacing: 0) {
                    
                    ForEach((0..<4), id: \.self) { index in
                     
                        Image("roud_\(index+1)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .frame(maxWidth: .infinity)
                        
                        if [1,3].contains(index) {
                            Text("10 min")
                                .regular12
                                .lineLimit(1)
                                .frame(width: 40)
                                
                            
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(height: 10)
                                .frame(maxWidth: .infinity)

                        } else {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(height: 10)
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                    
                    
                }
                
                HStack(spacing: 8) {
                    
                    ForEach((4..<7), id: \.self) { index in
                     
                        Image("roud_\(index+1)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            
                        
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(height: 10)
                    }
                    
                    
                }
                
            }
            .padding(12)
            .padding(.top, -4)
            
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(radius: 8, corners: .allCorners)
        .shadow(color: .gray.opacity(0.3), radius: 10)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private func showNeighborhoodStates(imageName: [String], ball: [Int], desc: [String]) -> some View {
        HStack(alignment: .top, spacing: 13) {
            
            ForEach(0..<3, id: \.self) { index in
                
                VStack(spacing: 0) {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.secondaryPurple.opacity(0.1))
                        .frame(width: 46, height: 46)
                        .overlay(
                            Image(imageName[index])
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                        )
                    
                    Text(String(describing: ball[index])+"/10")
                        .semibold14
                        .padding(.top,14)
                    
                    Text(desc[index])
                        .regular12
                        .multilineTextAlignment(.center)
                        .padding(.top,5)
                        .padding(.horizontal, 10)
                    
                }
                .padding(10)
                .frame(height: 170)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(radius: 8, corners: .allCorners)
                .shadow(color: .gray.opacity(0.3), radius: 10)
                
            }
            
        }
    }
    
    private func createTitleWithButton(_ title: String, action: @escaping ()->Void) -> some View {
        HStack {
            
            Text(title)
                .semibold18
            
            Spacer()
            
            Button(action: action) {
                Text("See All")
                    .medium14
                    .foregroundColor(Color.primaryBlue)
            }
        }
    }
    
    private func showAmenities(titles: [String], images: [String]) -> some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return LazyVGrid(columns: columns, spacing: 20) {
            
            ForEach(0..<titles.count, id: \.self) { index in
                
                HStack(spacing: 7) {
                    
                    Image(images[index])
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                        .frame(width: 46, height: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondaryPurple.opacity(0.1))
                        )
                    
                    Text(titles[index])
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .medium14
                    
                    Spacer()
                }
                
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(radius: 8, corners: .allCorners)
        .shadow(color: .gray.opacity(0.3), radius: 10)
    }
    
    private func showNearbyLocations() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 16) {
                
                ForEach(0..<3, id: \.self) { index in
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Image("mockImage")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .cornerRadius(radius: 8, corners: .allCorners)
                        
                        Text("Miller Pub and Bar")
                            .semibold16
                        
                        Text("107-02 Queens Blvd Queens, NY 11375")
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .regular14
                            .padding(.bottom,10)
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(radius: 8, corners: .allCorners)
                    .shadow(color: .gray.opacity(0.2), radius: 5)
                    .padding(.vertical, 10)
                }
            }
            .frame(height: 270)
            .padding(.horizontal, 20)
        }
    }
    
    private func propertyImageView(url: String?) -> some View {
        AsyncImage(
            url: url,
            placeHolderState: .rectangle,
            placeHolderFor: .RENTER
        )
    }
}


//MARK: - Navigation Links

extension RenterPropertyDetailView {
    
    private func authViewLinks() -> some View {
        ZStack {
            
            NavigationLink(destination: EmptyView(), isActive: $showLoginView) { EmptyView() }
            NavigationLink(destination: EmptyView(), isActive: $showRegisterView) { EmptyView() }
            
        }
    }
}

struct RenterPropertyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RenterPropertyDetailView()
    }
}
