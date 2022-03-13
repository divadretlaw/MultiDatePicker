//
//  MonthContentView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

/**
 * Displays the calendar of MDPDayOfMonth items using MDPDayView views.
 */
struct MDPContentView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    let cellSize: CGFloat = 42
    
    let columns = [
        GridItem(.flexible(minimum: 30, maximum: 60), spacing: 4),
        GridItem(.flexible(minimum: 30, maximum: 60), spacing: 4),
        GridItem(.flexible(minimum: 30, maximum: 60), spacing: 4),
        GridItem(.flexible(minimum: 30, maximum: 60), spacing: 4),
        GridItem(.flexible(minimum: 30, maximum: 60), spacing: 4),
        GridItem(.flexible(minimum: 30, maximum: 60), spacing: 4),
        GridItem(.flexible(minimum: 30, maximum: 60), spacing: 4)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            // Sun, Mon, etc.
            ForEach(0 ..< monthDataModel.dayNames.count, id: \.self) { index in
                Text(monthDataModel.dayNames[index].uppercased())
                    .font(.caption.weight(.semibold))
                    .foregroundColor(Color(.tertiaryLabel))
            }
			
            // The actual days of the month.
            ForEach(0 ..< monthDataModel.days.count, id: \.self) { index in
                if monthDataModel.days[index].day == 0 {
                    Spacer()
                        .frame(minHeight: cellSize, maxHeight: cellSize)
                } else {
                    MDPDayView(dayOfMonth: monthDataModel.days[index], cellSize: cellSize)
                }
            }
        }
        .padding(.top, 16)
    }
}

struct MonthContentView_Previews: PreviewProvider {
    static var previews: some View {
        MDPContentView()
            .environmentObject(MDPModel(singleDay: .constant(Date(timeIntervalSinceNow: 123_456)), includeDays: .allDays, minDate: nil, maxDate: nil))
    }
}
