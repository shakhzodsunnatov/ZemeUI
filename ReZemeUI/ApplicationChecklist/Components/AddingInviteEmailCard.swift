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
                .padding(.trailing,10)
        }
    }
    
    private func inviteEmailTags(rows: [[Tag]]) -> some View {
        
        VStack(spacing: 10) {
            
            ForEach(rows, id:\.self) { rows in
                
                ForEach(rows) { row in
                   
                    HStack(spacing: 10) {
                        Image(row.icon)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(row.color)
                            .frame(width: 15, height: 15)
                        
                        Text(row.name)
                            .regular12
                        Spacer()
                        
                        Text(row.title)
                            .medium14
                            .foregroundColor(row.color)
                        
                        if row.type != .completed {
                            if row.type == .send {
                                Button {
                                    
                                } label: {
                                    Circle()
                                        .strokeBorder(row.color, lineWidth: 1)
                                        .background(Circle().fill(.white))
                                        .frame(width: 20, height: 20)
                                        .overlay (
                                            Image("email")
                                                .resizable()
                                                .renderingMode(.template)
                                                .foregroundColor(row.color)
                                                .frame(width: 13,height: 10)
                                        )
                                }
                            }
                            
                            
                            Button {
                                
                            } label: {
                                Circle()
                                    .strokeBorder(row.color, lineWidth: 1)
                                    .background(Circle().fill(.white))
                                    .frame(width: 20, height: 20)
                                    .overlay (
                                        Image("xmark")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(row.color)
                                            .frame(width: 8,height: 8)
                                    )
                            }
                        }
                        
                        
                    }
                    .padding(10)
                    .background(row.color.opacity(0.1))
                    .cornerRadius(8)
                }
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

