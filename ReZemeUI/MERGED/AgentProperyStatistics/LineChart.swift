//
//  LineChart.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 26.04.2023.
//


import SwiftUI
import Charts

struct StepCount: Identifiable {
    let id = UUID()
    let weekday: Date
    let steps: Int
    
    init(day: String, steps: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        self.weekday = formatter.date(from: day) ?? Date.distantPast
        self.steps = steps
    }
    
    var weekdayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: weekday)
    }
    
    var shortDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return  dateFormatter.string(from: weekday)
    }
}


struct YellowGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .background(Color.white)
            .overlay(
                configuration.label.padding(10),
                alignment: .topLeading
            )
    }
}


struct LineAreaChartView: View {
    var body: some View {
        
        let currentWeek: [StepCount] = [
            StepCount(day: "20220917", steps: 0),
            StepCount(day: "20220718", steps: 1000),
            StepCount(day: "20220719", steps: 500),
            StepCount(day: "20220720", steps: 600),
            StepCount(day: "20220721", steps: 1500),
            StepCount(day: "20220722", steps: 20)
        ]
        
        let curGradient = LinearGradient(
            gradient: Gradient (
                colors: [
                    .purpleLow.opacity(0.3),
                    .white.opacity(0.1)
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        
        VStack() {
            if #available(iOS 16.0, *) {
                GroupBox  {
                    Chart {
                        ForEach(currentWeek) {
                            LineMark(
                                x: .value("Week Day", $0.shortDay),
                                y: .value("Step Count", $0.steps)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(Color.purpleLow)
                            .lineStyle(StrokeStyle(lineWidth: 2))
                            .symbol() {
                                Circle()
                                    .fill(Color.purpleLow)
                                    .frame(width: 6)
                            }
                            .symbolSize(10)
                            
                            AreaMark(
                                x: .value("Week Day", $0.shortDay),
                                y: .value("Step Count", $0.steps)
                            )
                            .interpolationMethod(.cardinal)
                            .foregroundStyle(curGradient)
                            .foregroundStyle(by: .value("Week", "Current Week"))
                        }
                    }
                    // Set the Y axis scale
                    .chartYScale(domain: 0...2000,type: .linear)
                    .chartLegend(.hidden)
                    .chartPlotStyle { plotArea in
                        plotArea
                            .background(Color.white.opacity(0.8))
                    }
                    .chartYAxis() {
                        AxisMarks(preset: AxisMarkPreset.aligned, position: .leading)
                            
                    }
                    .frame(height:140)
                }
                .groupBoxStyle(YellowGroupBoxStyle())
            }
        }
        .padding(.horizontal,10)
    }
}

struct LineAreaChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineAreaChartView()
    }
}
