//
//  CharViewNew.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 07.05.2023.
//

import SwiftUI
import Charts

@available(iOS 16.0, *)
struct CharViewNew: View {
    
    var data: [Double] = [10,20,30,40,50,60,70]
    var months = ["Jan 18", "Jan 19", "Jan 20", "Jan 21", "Jan 22", "Jan 23", "Jan 24"]
    var array = ["0","50","100","150"]
    var increment: Int = 50
    var purpleMode: Bool = true
    
    private func format(number: Int) -> String {
        return "\(number/10)"
    }
    
    private func VerticalAxis() -> some View {
        HStack {
            VStack {
                ForEach(array.reversed(), id: \.self) { i in
                    if !(array.last == i) {
                        Spacer()
                    }
                    Text(i)
                        .regular9
                        .foregroundColor(.black)
                    
                }
            }
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .frame(width: 1)
                
        }
    }
    
    let viewDate: [ViewMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 500),
        .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 1000),
        .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 1500),
        .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 2000),
        .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 2500),
        .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 3000),
    ]
   
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // Y-Axis
                VStack {
                    VerticalAxis()
                }
                ChartGrid(lines: 4) {
                    Chart {
                        ForEach(viewDate) { viewMonth in
                            BarMark(x: .value("Month", viewMonth.date,unit: .month),
                                    y: .value("Views", viewMonth.viewCount))
                            .foregroundStyle(Color.purpleGradient.toLinearGradient)
                            .cornerRadius(3)
                            
                        }
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                }
               
            
            }

//            HStack(spacing: 0) {
//                ForEach(0..<data.count, id:\.self) { i in
//                    Text("\(months[i])")
//                        .regular9
//                        .foregroundColor(.black)
//                        .rotated(Angle(degrees: -90))
//                        
//                }
//            }
//            .padding(.leading,30)
        }
        .padding(10)
    }
}

struct CharViewNew_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            CharViewNew()
        } else {
        }
    }
}

struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
