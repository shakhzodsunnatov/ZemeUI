//
//  AddingInviteEmailCard.swift
//  ReZeme
//
//  Created by Shakhzod on 16/03/23.
//

import SwiftUI

protocol InviteEmailCardDelegate {
    func getEmails(_ emails: [String])
}

struct AddingInviteEmailCard: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State var isTextFieldActive = false
    
    var delegate: InviteEmailCardDelegate?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            
            Text("Add Co-Application")
                .semibold18
                .multilineTextAlignment(.leading)
            
            // Email & Plus Button
            HStack(spacing: 7) {
                
                Image("mail")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18, height: 18)
                
                Text("Enter email below to send invite")
                    .regular14
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                plusButton {
                    withAnimation {
                        self.isTextFieldActive = true
                    }
                }
                
            }
            
            
            // Email Tags
            if viewModel.tags != [] {
                inviteEmailTags(rows: viewModel.rows)
            }
            
            
            // Email TextFields
            if isTextFieldActive || viewModel.tags == []{
                TextField("Add another co-applicant email...",
                          text: $viewModel.tagText,
                          onCommit: {
                    viewModel.addTag()
                    delegate?.getEmails(viewModel.emails)
                    withAnimation {
                        self.isTextFieldActive = false
                    }
                })
                .autocorrectionDisabled()
                .regular14
                .padding()
                .frame(height: 58)
                .padding(.top, 3)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .glow()
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


//MARK: - UI Components

extension AddingInviteEmailCard {
    
    private func plusButton(action: @escaping ()->Void) -> some View {
        Button(action: action) {
            Image(systemName: "plus.circle")
                .resizable()
                .scaledToFill()
                .foregroundColor(Color.primaryBlue)
                .font(Font.title.weight(.light))
                .frame(width: 24, height: 24)
        }
    }
    
    private func inviteEmailTags(rows: [[Tag]]) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            
            ForEach(rows, id:\.self) { rows in
                
                HStack(spacing: 6) {
                    
                    ForEach(rows) { row in
                        
                        Text(row.name)
                            .regular16
                            .padding(.horizontal,11)
                            .padding(.vertical, 2)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.lightBlue.opacity(0.15))
                            )
                    }
                }
                .frame(height: 28)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

struct AddingInviteEmailCard_Previews: PreviewProvider {
    static var previews: some View {
        AddingInviteEmailCard()
            .padding(.horizontal, 20)
    }
}

