//
//  HomeChart.swift
//  ZemeDesign
//
//  Created by Benjamin Kushmakov on 12/19/21.
//

import SwiftUI
//import ZemeDesign

public struct HomeChart: View {
    var data: [Double] = [91,77,107,85,95,83,89,116,73,93,78,104,120]
    var months = ["Jan '21", "Feb '21", "Mar '21", "Apr '21", "May '21", "Jun '21", "Jul '21", "Aug '21", "Sep '21", "Oct '21", "Nov '21", "Dec '21", "Jan '22"]
    var min: Int = 1000
    var max: Int = 3500
    var increment: Int = 500
    
    private func format(number: Double) -> String {
        return "$\(number / 1000.00)k"
    }
    
    private func VerticalAxis() -> some View {
        ForEach(0...(max-min)/increment, id: \.self) { i in
            Text(format(number: Double(max - i * increment)))
                .regular(size: 12)
                .foregroundColor(.black)
                .offset(y: (i == 0 || i == 1) ? 0 : 0)
            
            if (i != (max-min)/increment) {
                Spacer()
            }
        }
    }

    public var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { geo in
                CardView(showShadow: false) {
                    ZStack {
                        // X-Axis
                        Group {
                            VStack {
                                Spacer()
                                HStack(spacing: 2) {
                                    ForEach(0..<data.count, id:\.self) { i in
                                        Text("\(months[i])")
                                            .regular(size: 11)
                                            .foregroundColor(.black)
                                            .rotated(Angle(degrees: -45))
                                            .frame(width: 20, height: 16)
                                    }
                                }.padding(.leading, 22.5).padding(.bottom, 8)
                            }
                        }
                        Group {
                            HStack {
                                // Y-Axis
                                VStack {
                                    
                                    VerticalAxis()
                                     
                                }
                                // BarChart and Grid
                                ChartGrid(lines: 6) { BarChart() }
                                Spacer()
                            }
                            .padding(.leading, 5)
                            .padding(.bottom, 35)
                            .padding(.top, 15)
                        }
                }.padding().overlay(
                    // Additional chart information
                    VStack {
//                        HStack {
//                            Spacer()
//                            
//                            Group {
//                                Ellipse()
//                                    .foregroundColor(.primaryBlue)
//                                    .frame(width: 4, height: 4)
//                                Text("YoY Change")
//                                    .medium(size: 12)
//                                    .foregroundColor(.darkBackground)
//                                    .padding(.leading, -3)
//                                Image(systemName: "arrow.up")
//                                    .resizable()
//                                    .frame(width: 7, height: 10)
//                                    .padding(.trailing, -5)
//                                    .foregroundColor(.success)
//                                Text("3.4%")
//                                    .medium(size: 12)
//                                    .foregroundColor(.success)
//                            }
//
//                            Group {
//                                Ellipse()
//                                    .foregroundColor(.primaryBlue)
//                                    .frame(width: 4, height: 4)
//                                Text("YTD Change")
//                                    .medium(size: 12)
//                                    .foregroundColor(.darkBackground)
//                                    .padding(.leading, -3)
//                                Image(systemName: "arrow.down").resizable()
//                                    .frame(width: 7, height: 10)
//                                    .padding(.trailing, -5)
//                                    .foregroundColor(.failure)
//                                Text("-1.0%")
//                                    .medium(size: 12)
//                                    .foregroundColor(.failure)
//                            }
//                        }.padding()
                        Spacer()
                    }.padding(.top, -5))
                }
                .data(data)
                .chartStyle(Color.chart)
                //.frame(width: geo.size.width - 30, height: geo.size.height / 3)
                
            }
        }
    }
}

struct HomeChart_Previews: PreviewProvider {
    static var previews: some View {
        HomeChart()
    }
}

/// View containing data and some kind of chart content
public struct CardView<Content: View>: View, ChartBase {
    public var chartData = ChartData()
    let content: () -> Content

    private var showShadow: Bool

    @EnvironmentObject var style: ChartStyle

    /// Initialize with view options and a nested `ViewBuilder`
    /// - Parameters:
    ///   - showShadow: should card have a rounded-rectangle shadow around it
    ///   - content: <#content description#>
    public init(showShadow: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.showShadow = showShadow
        self.content = content
    }

    /// The content and behavior of the `CardView`.
    ///
    ///
    public var body: some View {
        ZStack{
            if showShadow {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.white)
                    .shadow(color: Color(white: 0.9, opacity: 1), radius: 8)
            }
            VStack (alignment: .leading) {
                self.content()
            }
            .clipShape(RoundedRectangle(cornerRadius: showShadow ? 20 : 0))
        }
    }
}

extension View where Self: ChartBase {
    
    /// Set data for a chart
    /// - Parameter data: array of `Double`
    /// - Returns: modified `View` with data attached
    public func data(_ data: [Double]) -> some View {
        chartData.data = data.map { ("", $0) }
        return self
            .environmentObject(chartData)
            .environmentObject(ChartValue())
    }

    public func data(_ data: [(String, Double)]) -> some View {
        chartData.data = data
        return self
            .environmentObject(chartData)
            .environmentObject(ChartValue())
    }
}

extension View {
    public func rotated(_ angle: Angle = .degrees(-90)) -> some View {
        Rotated(self, angle: angle)
    }
}

struct Rotated<Rotated: View>: View {
    var view: Rotated
    var angle: Angle

    init(_ view: Rotated, angle: Angle = .degrees(-90)) {
        self.view = view
        self.angle = angle
    }

    @State private var size: CGSize = .zero

    var body: some View {
        // Rotate the frame, and compute the smallest integral frame that contains it
        let newFrame = CGRect(origin: .zero, size: size)
            .offsetBy(dx: -size.width/2, dy: -size.height/2)
            .applying(.init(rotationAngle: CGFloat(angle.radians)))
            .integral

        return view
            .fixedSize()                    // Don't change the view's ideal frame
            .captureSize(in: $size)         // Capture the size of the view's ideal frame
            .rotationEffect(angle)          // Rotate the view
            .frame(width: newFrame.width,   // And apply the new frame
                   height: newFrame.height)
    }
}

extension View {
    func captureSize(in binding: Binding<CGSize>) -> some View {
        overlay(GeometryReader { proxy in
            Color.clear.preference(key: SizeKey.self, value: proxy.size)
        })
            .onPreferenceChange(SizeKey.self) { size in binding.wrappedValue = size }
    }
}

private struct SizeKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


public struct ChartGrid<Content: View>: View, ChartBase {
    public var chartData = ChartData()
    let content: () -> Content
    let lines: Int

    @EnvironmentObject var data: ChartData
    @EnvironmentObject var style: ChartStyle

    public init(lines: Int = 4, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.lines = lines
    }

    public var body: some View {
        HStack {
            ZStack {
                VStack {
                    ForEach(0..<lines) { iteration in
                        GridElement(dashed: iteration != (lines - 1))
                        
                        if (iteration != (lines - 1)) {
                            Spacer()
                        }
                    }
                }
                self.content()
            }
        }
    }
}

struct GridElement: View {
    let dashed: Bool
    var body: some View {
        if (dashed) {
            DashedLine()
                .frame(maxHeight: 2, alignment: .center)
        } else {
            RegularLine()
                .frame(maxHeight: 2, alignment: .center)

        }
            
            
    }
}

struct RegularLine: View {
    func line(frame: CGRect) -> SwiftUI.Path {
        let baseLine: CGFloat = CGFloat(frame.height / 2)
        var hLine = SwiftUI.Path()
        hLine.move(to: CGPoint(x:0, y: baseLine))
        hLine.addLine(to: CGPoint(x: frame.width, y: baseLine))
        return hLine
    }

    var body: some View {
        GeometryReader { geometry in
            line(frame: geometry.frame(in: .local))
                .stroke(Color(white: 0.85), style: StrokeStyle(lineWidth: 1, lineCap: .round))
        }
    }
}



struct DashedLine: View {
    func line(frame: CGRect) -> SwiftUI.Path {
        let baseLine: CGFloat = CGFloat(frame.height / 2)
        var hLine = SwiftUI.Path()
        hLine.move(to: CGPoint(x:0, y: baseLine))
        hLine.addLine(to: CGPoint(x: frame.width, y: baseLine))
        return hLine
    }

    var body: some View {
        GeometryReader { geometry in
            line(frame: geometry.frame(in: .local))
                .stroke(Color(white: 0.85), style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [1, 2]))
        }
    }
}


public class ChartData: ObservableObject {
    @Published public var data: [(String, Double)] = []

    var points: [Double] {
        data.map { $0.1 }
    }

    var values: [String] {
        data.map { $0.0 }
    }

    var normalisedPoints: [Double] {
        let absolutePoints = points.map { abs($0) }
        return points.map { $0 / (absolutePoints.max() ?? 1.0) }
    }

    var normalisedRange: Double {
        (normalisedPoints.max() ?? 0.0) - (normalisedPoints.min() ?? 0.0)
    }

    var isInNegativeDomain: Bool {
        (points.min() ?? 0.0) < 0
    }

    /// Initialize with data array
    /// - Parameter data: Array of `Double`
    public init(_ data: [Double]) {
        self.data = data.map { ("", $0) }
    }

    public init(_ data: [(String, Double)]) {
        self.data = data
    }

    public init() {
        self.data = []
    }
}

public class ChartStyle: ObservableObject {

    /// colors for background are of chart
    public let backgroundColor: ColorGradient
    /// colors for foreground fill of chart
    public let foregroundColor: [ColorGradient]
    public let cornerRadius: CGFloat

    /// Initialize with a single background color and an array of `ColorGradient` for the foreground
    /// - Parameters:
    ///   - backgroundColor: a `Color`
    ///   - foregroundColor: array of `ColorGradient`
    public init(backgroundColor: Color, foregroundColor: [ColorGradient], cornerRadius: CGFloat) {
        self.backgroundColor = ColorGradient.init(backgroundColor)
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }

    /// Initialize with a single background color and a single `ColorGradient` for the foreground
    /// - Parameters:
    ///   - backgroundColor: a `Color`
    ///   - foregroundColor: a `ColorGradient`
    public init(backgroundColor: Color, foregroundColor: ColorGradient, cornerRadius: CGFloat) {
        self.backgroundColor = ColorGradient.init(backgroundColor)
        self.foregroundColor = [foregroundColor]
        self.cornerRadius = cornerRadius
    }

    /// Initialize with a single background `ColorGradient` and a single `ColorGradient` for the foreground
    /// - Parameters:
    ///   - backgroundColor: a `ColorGradient`
    ///   - foregroundColor: a `ColorGradient`
    public init(backgroundColor: ColorGradient, foregroundColor: ColorGradient, cornerRadius: CGFloat) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = [foregroundColor]
        self.cornerRadius = cornerRadius
    }

    /// Initialize with a  single background `ColorGradient` and an array of `ColorGradient` for the foreground
    /// - Parameters:
    ///   - backgroundColor: a `ColorGradient`
    ///   - foregroundColor: array of `ColorGradient`
    public init(backgroundColor: ColorGradient, foregroundColor: [ColorGradient], cornerRadius: CGFloat) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }
    
}

public protocol ChartBase {
    var chartData: ChartData { get }
}

public struct BarChart: View, ChartBase {
    public var chartData = ChartData()

    @EnvironmentObject var data: ChartData
    @EnvironmentObject var style: ChartStyle

    /// The content and behavior of the `BarChart`.
    ///
    ///
    public var body: some View {
        BarChartRow(chartData: data)
            .chartStyle(style)
    }

    public init() {}
}

extension View {

    /// Attach chart style to a View
    /// - Parameter style: chart style
    /// - Returns: `View` with chart style attached
    public func chartStyle(_ style: ChartStyle) -> some View {
        self.environmentObject(style)
    }
}

public struct BarChartRow: View {
    @EnvironmentObject var chartValue: ChartValue
    
    @ObservedObject var chartData: ChartData
    @State private var touchLocation: CGFloat = -1.0

    @EnvironmentObject var style: ChartStyle

    var maxValue: Double {
        guard let max = chartData.points.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }

    /// The content and behavior of the `BarChartRow`.
    ///
    /// Shows each `BarChartCell` in an `HStack`; may be scaled up if it's the one currently being touched.
    /// Not using a drawing group for optimizing animation.
    /// As touched (dragged) the `touchLocation` is updated and the current value is highlighted.
    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom,
                   spacing: geometry.frame(in: .local).width / CGFloat(chartData.data.count * 3)) {
                    ForEach(0..<chartData.data.count, id: \.self) { index in
                        BarChartCell(value: chartData.normalisedPoints[index],
                                     index: index,
                                     gradientColor: self.style.foregroundColor.rotate(for: index),
                                     touchLocation: self.touchLocation, cornerRadius: style.cornerRadius)
                            .scaleEffect(self.getScaleSize(touchLocation: self.touchLocation, index: index), anchor: .bottom)
                            .animation(Animation.easeIn(duration: 0.2))
                    }
//                    .drawingGroup()
            }
            .frame(maxHeight: chartData.isInNegativeDomain ? geometry.size.height / 2 : geometry.size.height)
            .gesture(DragGesture()
                .onChanged({ value in
                    let width = geometry.frame(in: .local).width
                    self.touchLocation = value.location.x/width
                    if let currentValue = self.getCurrentValue(width: width) {
                        self.chartValue.currentValue = currentValue
                        self.chartValue.interactionInProgress = true
                    }
                })
                .onEnded({ value in
                    self.chartValue.interactionInProgress = false
                    self.touchLocation = -1
                })
            )
        }
    }

    /// Size to scale the touch indicator
    /// - Parameters:
    ///   - touchLocation: fraction of width where touch is happening
    ///   - index: index into data array
    /// - Returns: a scale larger than 1.0 if in bounds; 1.0 (unscaled) if not in bounds
    func getScaleSize(touchLocation: CGFloat, index: Int) -> CGSize {
        if touchLocation > CGFloat(index)/CGFloat(chartData.data.count) &&
           touchLocation < CGFloat(index+1)/CGFloat(chartData.data.count) {
            return CGSize(width: 1.4, height: 1.1)
        }
        return CGSize(width: 1, height: 1)
    }

    /// Get data value where touch happened
    /// - Parameter width: width of chart
    /// - Returns: value as `Double` if chart has data
    func getCurrentValue(width: CGFloat) -> Double? {
        guard self.chartData.data.count > 0 else { return nil}
            let index = max(0,min(self.chartData.data.count-1,Int(floor((self.touchLocation*width)/(width/CGFloat(self.chartData.data.count))))))
            return self.chartData.points[index]
        }
}



public struct BarChartCell: View {
    var value: Double
    var index: Int = 0
    var gradientColor: ColorGradient
    var touchLocation: CGFloat
    var cornerRadius: CGFloat
    @State private var didCellAppear: Bool = false

    public init( value: Double,
                 index: Int = 0,
                 gradientColor: ColorGradient,
                 touchLocation: CGFloat, cornerRadius: CGFloat) {
        self.value = value
        self.index = index
        self.gradientColor = gradientColor
        self.touchLocation = touchLocation
        self.cornerRadius = cornerRadius
    }

    /// The content and behavior of the `BarChartCell`.
    ///
    /// Animated when first displayed, using the `firstDisplay` variable, with an increasing delay through the data set.
    public var body: some View {
        BarChartCellShape(value: didCellAppear ? value : 0.0, cornerRadius: cornerRadius)
        .fill(gradientColor.linearGradient(from: .bottom, to: .top))        .onAppear {
            self.didCellAppear = true
        }
        .onDisappear {
            self.didCellAppear = false
        }
        .transition(.slide)
        .animation(Animation.spring().delay(self.touchLocation < 0 || !didCellAppear ? Double(self.index) * 0.04 : 0))
    }
}


struct BarChartCellShape: Shape, Animatable {
    var value: Double
    var cornerRadius: CGFloat = 6.0
    var animatableData: CGFloat {
        get { CGFloat(value) }
        set { value = Double(newValue) }
    }

    func path(in rect: CGRect) -> SwiftUI.Path {
        let adjustedOriginY = rect.height - (rect.height * CGFloat(value))
        var path = SwiftUI.Path()
        path.move(to: CGPoint(x: 0.0 , y: rect.height))
        path.addLine(to: CGPoint(x: 0.0, y: adjustedOriginY + cornerRadius))
        path.addArc(center: CGPoint(x: cornerRadius, y: adjustedOriginY +  cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(radians: Double.pi),
                    endAngle: Angle(radians: -Double.pi/2),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: adjustedOriginY))
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: adjustedOriginY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(radians: -Double.pi/2),
                    endAngle: Angle(radians: 0),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()

        return path
    }
}

extension Array where Element == ColorGradient {
    
    /// <#Description#>
    /// - Parameter index: offset in data table
    /// - Returns: <#description#>
    func rotate(for index: Int) -> ColorGradient {
        if self.isEmpty {
            return ColorGradient.orangeBright
        }
        
        if self.count <= index {
            return self[index % self.count]
        }
        
        return self[index]
    }
}

public class ChartValue: ObservableObject {
    @Published var currentValue: Double = 0
    @Published var interactionInProgress: Bool = false
}
