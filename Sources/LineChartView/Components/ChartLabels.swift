//
//  ChartLabels.swift
//  ChartLineView Package
//
//  Created by Jonathan Gander
//

import SwiftUI



public struct ChartLabels: View {
    
    public enum Alignment {
        case left, center, right
    }
    
    public var lineChartParameters: LineChartParameters
    
    @Binding var indexPosition: Int  // Data point position
    
    private var labels: [String?] = []
    
    public init(lineChartParameters: LineChartParameters, indexPosition: Binding<Int>) {
        self.lineChartParameters = lineChartParameters
        self._indexPosition = indexPosition
        
        labels = lineChartParameters.dataLabels
    }
    
    public var body: some View {
        
        HStack {
            
            if lineChartParameters.labelsAlignment == .right {
                Spacer()
            }
            
            VStack(alignment: lineChartParameters.labelsAlignment == .left ? .leading : lineChartParameters.labelsAlignment == .right ? .trailing : .center) {
                if  lineChartParameters.dataValues.count > indexPosition {
                    if #available(iOS 15.0, *) {
                        Text("\(lineChartParameters.dataPrefix ?? "")\(lineChartParameters.dataValues[indexPosition].formatted(.number.precision(.fractionLength(lineChartParameters.dataPrecisionLength))))\(lineChartParameters.dataSuffix ?? "")")
                            .foregroundColor(lineChartParameters.labelColor)
                            .font(.title)
                            .fontWeight(.bold)
                    } else {
                        Text(String(format: "%.2f", lineChartParameters.dataValues[indexPosition]))
                            .foregroundColor(lineChartParameters.labelColor)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            
                if labels.count > indexPosition {
                    if let label = labels[indexPosition] {
                        Text(label)
                            .foregroundColor(lineChartParameters.secondaryLabelColor)
                            .font(.caption)
                    }
                }
            }
            if lineChartParameters.labelsAlignment == .left {
                Spacer()
            }
        }
    }
}
