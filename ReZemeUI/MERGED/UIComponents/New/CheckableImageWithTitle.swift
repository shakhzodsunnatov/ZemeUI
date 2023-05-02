//
//  CheckableImageWithTitle.swift
//  ReZemeUI
//
//  Created by Shakhzod on 26/04/23.
//

import Foundation
import SwiftUI

struct CheckableModel {
    let title: String
    let image: String
}

struct CheckableImageWithTitle: View {
    
    //MARK: - PEROPERTIES
    
    @State var model: CheckableModel
    @State var isSelected: Bool
    let type: AccountType
    let selectedAction: (Bool)->Void

    //MARK: - init
    
    init(model: CheckableModel, type: AccountType = .RENTER, isSelected: Bool = false, selectedAction :@escaping (Bool)->Void) {
        self._model = State(wrappedValue: model)
        self._isSelected = State(wrappedValue: isSelected)
        self.type = type
        self.selectedAction = selectedAction
    }
    
    
    //MARK: - body
    
    var body: some View {
        HStack(alignment: .top) {
            HStack(alignment: .center, spacing: 7) {
                
                Image(model.image)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(antiColor)
                    .padding(5)
                    .frame(width: 30, height: 30)
                    .roundedShadow(backgroundColor: antiColor.opacity(0.2))
                
                Text(model.title)
                    .medium12
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "\(isSelected ? "checkmark." : "")circle")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(type.color)
                        .frame(width: 16, height: 16)
                
                
            }
        }
        .padding(EdgeInsets(top: 6, leading: 6, bottom: 7, trailing: 13))
        .roundedShadow()
        .makeButton {
            withAnimation {
                isSelected.toggle()
            }
            
            selectedAction(isSelected)
        }
    }
}


//MARK: - Helpers

extension CheckableImageWithTitle {
    
    private var antiColor: Color {
        switch type {
        case .AGENT: return Color.darkBlue
        case .RENTER: return Color.secondaryPurple
        }
    }
    
}

struct CheckableImageWithTitle_Previews: PreviewProvider {
    static var previews: some View {
        CheckableImageWithTitle(
            model: CheckableModel(title: "Parking", image: "Park"),
//            isSelected: false,
            selectedAction: { isSelected in
                debugPrint(isSelected)
            }
        )
            .padding(50)
    }
}
