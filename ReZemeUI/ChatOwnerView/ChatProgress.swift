//
//  ChatProgress.swift
//  ReZeme
//
//  Created by Shakhzod on 14/03/23.
//

import SwiftUI

struct ChatProgress: View {
    
    //MARK: - Properties
    
    @Binding var completedIndex: Int
    
    private let titles = [
        "Application Submitted",
        "Verified",
        "Visit Scheduled",
        "Visit Completed",
        "Contract Sent",
        "Signed"
    ]
    
    
    //MARK: - Body
    
    var body: some View {
        GeometryReader { geo in
            
            VStack(spacing: 9) {
                
                HStack(spacing: 0) {
                        
                    ForEach((0...5), id: \.self ) { index in
                            
                        progressItem(
                            completedIndex: completedIndex-1,
                            number: index,
                            geo: geo
                        )
                        .frame(
                            maxWidth: .infinity,
                            alignment: getAlignmentBy(index: index)
                        )
                        
                    }
                        
                }
                .background(
                    progressLine(
                        completedIndex: completedIndex,
                        geo: geo
                    )
                )
                .frame(width: geo.size.width-20)
                
                
                HStack(alignment: .top, spacing: 0) {
                        
                    ForEach((0...5), id: \.self ) { index in
                            
                        progressItemTitle(
                            completedIndex: completedIndex-1,
                            title: titles[index],
                            number: index,
                            geo: geo)
                        .frame(
                            maxWidth: .infinity,
                            alignment: getAlignmentBy(index: index)
                        )
                        
                    }
                        
                }
                .padding(.trailing, 5)
                
            }
            
        }
        .frame(height: 55)
    }
}



//MARK: - Helpers

extension ChatProgress {
    
    private func getAlignmentBy(index: Int) -> Alignment {
        switch index {
        case 0: return .leading
        case 5: return .trailing
        default: return .center
        }
    }
 
    private func getWidthOfProgressPercent(completeUntil: Int, geo: GeometryProxy) -> CGFloat {
        switch completeUntil {
        case 1: return CGFloat(0)
        case 2: return geo.size.width * CGFloat(0.25)
        case 3: return geo.size.width * CGFloat(0.4)
        case 4: return geo.size.width * CGFloat(0.55)
        case 5: return geo.size.width * CGFloat(0.7)
        case 6: return geo.size.width * CGFloat(0.9)
        default: return geo.size.width * CGFloat(1)
        }
    }
}


//MARK: - UI Components

extension ChatProgress {
    
    private func progressItem(completedIndex: Int, number: Int ,geo: GeometryProxy) -> some View {
        Image(systemName: number <= completedIndex ? "checkmark.circle": "\(number+1).circle")
                .resizable()
                .scaledToFill()
                .foregroundColor(Color.secondaryPurple)
                .background(Color.white)
                .frame(width: 25, height: 25)
    }
    
    private func progressItemTitle(completedIndex: Int, title: String, number: Int ,geo: GeometryProxy) -> some View {
        Text(title)
            .medium9
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .foregroundColor(
                number <= completedIndex ? Color.secondaryPurple : .black
            )
    }
    
    private func progressLine(completedIndex: Int, geo: GeometryProxy) -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.secondaryPurple.opacity(0.3))
                .frame(height: 4)
            
            Rectangle()
                .fill(Color.secondaryPurple)
                .frame(
                    width:
                        getWidthOfProgressPercent(
                            completeUntil: completedIndex,
                            geo: geo
                    ),
                    height: 4
                )
        }
    }
}

struct ChatProgress_Previews: PreviewProvider {
    static var previews: some View {
        ChatProgress(completedIndex: .constant(6))
            .padding(.horizontal, 20)
    }
}
