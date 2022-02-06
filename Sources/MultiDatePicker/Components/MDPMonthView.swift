//
//  MonthView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI

/**
 * MDPMonthView is really the crux of the control. This displays everything and handles the interactions
 * and selections. MulitDatePicker is the public interface that sets up the model and this view.
 */
struct MDPMonthView: View {
    @EnvironmentObject var monthDataModel: MDPModel
        
    @State private var showMonthYearPicker = false
    @State private var testDate = Date()
	
	private var animate = true
	
	private var cornerRadius: CGFloat = 10
	
	private var borderColor = Color.accentColor
	private var borderWidth: CGFloat = 1
	private var showBorder = true
    
    private func showPrevMonth() {
		if animate {
			withAnimation {
				monthDataModel.decrMonth()
			}
		} else {
			monthDataModel.decrMonth()
			showMonthYearPicker = false
		}
    }
    
    private func showNextMonth() {
		if animate {
			withAnimation {
				monthDataModel.incrMonth()
				showMonthYearPicker = false
			}
		} else {
			monthDataModel.incrMonth()
			showMonthYearPicker = false
		}
    }
    
    var body: some View {
        VStack {
			HStack(spacing: 30) {
                MDPMonthYearPickerButton(isPresented: self.$showMonthYearPicker)
				
                Spacer()
				
                Button {
					showPrevMonth()
				} label: {
                    Image(systemName: "chevron.left")
						.font(.headline)
						.imageScale(.large)
                }
				
                Button {
					showNextMonth()
				} label: {
                    Image(systemName: "chevron.right")
						.font(.headline)
						.imageScale(.large)
                }
            }
			.padding()
            
			ZStack {
				if showMonthYearPicker {
					MDPMonthYearPicker(date: monthDataModel.controlDate) { (month, year) in
						self.monthDataModel.show(month: month, year: year)
					}
				}
				
				MDPContentView()
					.transition(.opacity)
					.opacity(showMonthYearPicker ? 0 : 1)
					.allowsHitTesting(!showMonthYearPicker)
			}
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
				.fill(Color(.secondarySystemGroupedBackground))
        )
        .overlay(overlay)
        .padding()
    }
	
	@ViewBuilder
	var overlay: some View {
		if showBorder {
			RoundedRectangle(cornerRadius: cornerRadius)
				.stroke(borderColor, lineWidth: borderWidth)
		}
	}
	
	// MARK: Modifier
	
	func animate(_ value: Bool) -> Self {
		var view = self
		view.animate = value
		return view
	}
	
	func cornerRadius(_ value: CGFloat) -> Self {
		var view = self
		view.cornerRadius = value
		return view
	}
	
	func border(_ showBorder: Bool, color: Color = .accentColor, lineWidth: CGFloat = 1) -> Self {
		var view = self
		view.borderColor = color
		view.borderWidth = lineWidth
		view.showBorder = showBorder
		return view
	}
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MDPMonthView()
			.environmentObject(MDPModel(singleDay: .constant(Date(timeIntervalSinceNow: 123456)), includeDays: .allDays, minDate: nil, maxDate: nil))
			.preferredColorScheme(.dark)
    }
}
