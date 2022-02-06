//
//  DayOfMonthView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI

/**
 * MDPDayView displays the day of month on a MDPContentView. This a button whose color and
 * selectability is determined from the MDPDayOfMonth in the MDPModel.
 */
struct MDPDayView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    var dayOfMonth: MDPDayOfMonth
	var cellSize: CGFloat = 30

	// filled if selected
	private var fillColor: Color {
		if monthDataModel.isSelected(dayOfMonth) {
			return .accentColor
				.opacity(dayOfMonth.isToday ? 1 : 0.2)
		} else {
			return .clear
		}
	}
	
    // reverse color for selections or gray if not selectable
    private var textColor: Color {
        if dayOfMonth.isSelectable {
			if dayOfMonth.isToday {
				return monthDataModel.isSelected(dayOfMonth) ? Color.white : Color.accentColor
			} else {
				return monthDataModel.isSelected(dayOfMonth) ? Color.accentColor : Color.primary
			}
        } else {
            return Color.secondary
        }
    }
	
	private var font: Font {
		if monthDataModel.isSelected(dayOfMonth) {
			return .title3.weight(.semibold)
		} else {
			return .title3
		}
	}
    
    private func handleSelection() {
        if dayOfMonth.isSelectable {
            monthDataModel.selectDay(dayOfMonth)
        }
    }
	
	var body: some View {
		Button {
			handleSelection()
		} label: {
			Text("\(dayOfMonth.day)")
				.font(font)
				.foregroundColor(textColor)
				.frame(minHeight: cellSize, maxHeight: cellSize)
				.background(
					Circle()
						.fill(fillColor)
						.frame(width: cellSize, height: cellSize)
				)
		}
		.foregroundColor(.primary)
		.disabled(!dayOfMonth.isSelectable)
    }
}

struct DayOfMonthView_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			MDPDayView(dayOfMonth: MDPDayOfMonth(index: 0, day: 1, date: Date(), isSelectable: true, isToday: false))
			MDPDayView(dayOfMonth: MDPDayOfMonth(index: 0, day: 1, date: Date(), isSelectable: true, isToday: true))
			MDPDayView(dayOfMonth: MDPDayOfMonth(index: 0, day: 6, date: Date(), isSelectable: true, isToday: false))
		}
		.environmentObject(MDPModel())
    }
}
