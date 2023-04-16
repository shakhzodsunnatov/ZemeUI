//
//  RequestedDocCard.swift
//  ReZeme
//
//  Created by Shakhzod on 16/03/23.
//

import SwiftUI

struct RequestedDocCard: View {
    
    private let titles = [
        "Plaid Verified Bank Statement",
        "Employment Verification",
        "W2 Form",
        "Credit Check"
    ]
    
    private let images = [
        "bank_ic",
        "people_ic",
        "document_ic",
        "speed_ic"
    ]
    
    @Binding var step: Int
    
    var tappedStep: (Int) -> Void = {_ in}
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12) {
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Agent Requested Documents")
                    .semibold18
                
                Text("Complete steps below")
                    .medium14
            }
            
            
            VStack(alignment: .leading, spacing: 30) {
                
                ForEach((0..<titles.count), id: \.self) { index in
                    
                    createStepButton(
                        number: index+1,
                        image: images[index],
                        title: titles[index],
                        isActive: index <= step
                    )
                    {
                        tappedStep(index)
                    }
                    
                }
            }
            .background(
                HStack {
                    ZStack {
                        
                        Rectangle()
                            .fill(Color.secondaryPurple.opacity(0.4))
                            .padding(.vertical, 20)
                            .frame(width: 1, alignment: .leading)
                            .padding(.leading, 10)
                        
                        Rectangle()
                            .fill(Color.secondaryPurple)
                            .padding(.vertical, 20)
                            .padding(.bottom, getActiveLineHeight(step))
                            .frame(width: 1, alignment: .leading)
                            .padding(.leading, 10)
                        
                    }
                    
                    Spacer()
                }
            )
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .glow()
            )
        }
    }
}


//MARK: - UI Components

extension RequestedDocCard {
    
    private func createStepButton(number: Int, image: String, title: String, isActive: Bool, btnAction action: @escaping ()->Void) -> some View {
        HStack(spacing: 13) {
            
            Image(systemName: isActive ? "checkmark.circle.fill" : "\(number).circle")
                .resizable()
                .font(Font.title.weight(.light))
                .foregroundColor(.secondaryPurple.opacity(isActive ? 1 : 0.4))
                .frame(width: 20, height: 20)
                .background(Color.white)
            
            Button(action: action) {
                HStack(spacing: 13) {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .padding(12)
                        .frame(width: 44, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.darkBlue.opacity(0.15))
                        )
                    
                    Text(title)
                        .foregroundColor(.black)
                        .medium16
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .scaledToFill()
                        .font(.title.weight(.light))
                        .foregroundColor(Color.darkBlue)
                        .frame(width: 26, height: 26)
                }
            }
        }
    }
    
}


//MARK: - Helpers

extension RequestedDocCard {
    
    private func getActiveLineHeight(_ step: Int) -> CGFloat {
        switch step {
        case 0: return 150
        case 1: return 70
        case 2: return 0
        default: return 0
        }
    }
}

struct RequestedDocCard_Previews: PreviewProvider {
    static var previews: some View {
        RequestedDocCard(step: .constant(2)) { index in
            // index is tapped step index
        }
        .padding(.horizontal, 20)
    }
}
