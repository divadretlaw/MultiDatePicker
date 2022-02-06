//
//  MonthYearPickerButton.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

/**
 * The MDPMonthYearPickerButton sits at the top of the MDPMonthView and displays the current month
 * and year showing in the view. Tapping this control switches the main view to the month/year
 * picker.
 *
 * This is a quick way for the user to jump the year or month without having to the < or >
 * buttons.
 */
struct MDPMonthYearPickerButton: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button {
			withAnimation {
				isPresented.toggle()
			}
		} label: {
            HStack {
                Text(monthDataModel.title)
                    .foregroundColor(self.isPresented ? .accentColor : .primary)
                Image(systemName: "chevron.right")
                    .rotationEffect(self.isPresented ? .degrees(90) : .degrees(0))
            }
			.font(.subheadline.weight(.semibold))
        }
    }
}

struct MonthYearPickerButton_Previews: PreviewProvider {
    static var previews: some View {
		VStack(spacing: 16) {
			MDPMonthYearPickerButton(isPresented: .constant(false))
			MDPMonthYearPickerButton(isPresented: .constant(true))
		}
		.environmentObject(MDPModel(singleDay: .constant(Date()), includeDays: .allDays, minDate: nil, maxDate: nil))
		.previewLayout(.fixed(width: 300, height: 300))
    }
}
