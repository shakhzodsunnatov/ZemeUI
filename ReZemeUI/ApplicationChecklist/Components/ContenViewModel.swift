//
//  ContenViewModel.swift
//  ReZeme
//
//  Created by Shakhzod on 16/03/23.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var rows: [[Tag]] = []
    @Published var tags: [Tag] = [Tag(name: "jdoe@mail.com",size: 0,type: .send),Tag(name: "haileyreed@mail.com",size: 0,type: .completed)]
    @Published var emails: [String] = []
    @Published var tagText = ""
    
    init(){
        getTags()
    }
    
    func getTags(){
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        
        let screenWidth = UIScreen.screenWidth - 40
        let tagSpaceing: CGFloat = 22 + 4
        
        if !tags.isEmpty{
            
            for index in 0..<tags.count{
                self.tags[index].size = tags[index].name.getSize()
            }
            
            tags.forEach { tag in
                
                totalWidth += (tag.size + tagSpaceing)
                
                if totalWidth > screenWidth {
                    totalWidth = (tag.size + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                } else {
                    currentRow.append(tag)
                }
            }
            
            if !currentRow.isEmpty{
                rows.append(currentRow)
                currentRow.removeAll()
            }
            
            self.rows = rows
        }else{
            self.rows = []
        }
        
    }
    
    func addTag(){
        tags.append(Tag(name: tagText))
        emails.append(tagText)
        tagText = ""
        getTags()
    }

    func removeTag(by id: String){
        tags.removeAll(where: { $0.id != id })
        getTags()
    }
    
}

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var size: CGFloat = 0
    var type: CoApplicant = .inProgress
    
    var color: Color {
         switch type {
         case .inProgress: return Color.purpleLow
         case .send: return Color.blue
         case .completed: return Color.green
         }
     }
    
    var icon: String {
         switch type {
         case .inProgress: return "refresh"
         case .send: return "send"
         case .completed: return "checked"
         }
     }
    
    var title: String {
         switch type {
         case .inProgress: return "In Progress"
         case .send: return "Sent"
         case .completed: return "Completed"
         }
     }
}

enum CoApplicant {
    case send, inProgress, completed
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.width
}

extension String{
    func getSize() -> CGFloat{
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}
