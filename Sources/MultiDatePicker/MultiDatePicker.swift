//
//  MultiDatePicker.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

/**
 * This component shows a date picker very similar to Apple's SwiftUI 2.0 DatePicker, but with a difference.
 * Instead of just allowing a single date to be picked, the MultiDatePicker also allows the user to select
 * a set of non-contiguous dates or a date range. It just depends on how this View is initialized.
 *
 * init(singleDay: Binding<Date> [,options])
 *      A single-date picker. Selecting a date de-selects the previous selection. Because the binding
 *      is a Date, there is always a selected date.
 *
 * init(anyDates: Binding<[Date]>, [,options])
 *      Allows multiple, non-continguous, dates to be selected. De-select a date by tapping it again.
 *      The binding array may be empty or it will be an array of dates selected in ascending order.
 *
 * init(dateRange: Binding<ClosedRange<Date>?>, [,options])
 *      Selects a date range. Tapping on a date marks it as the first date, tapping a second date
 *      completes the range. Tapping a date again resets the range. The binding will be nil unless
 *      two dates are selected, completeing the range.
 *
 * optional parameters to init() functions are:
 *  - includeDays: .allDays, .weekdaysOnly, .weekendsOnly
 *      Days not selectable are shown in gray and not selected.
 *  - minDate: Date? = nil
 *      Days before minDate are not selectable.
 *  - maxDate: Date? = nil
 *      Days after maxDate are not selectable.
 */
public struct MultiDatePicker: View {
    // the type of picker, based on which init() function is used.
	public enum PickerType {
        case singleDay
        case anyDays
        case dateRange
    }
    
    // lets all or some dates be elligible for selection.
	public enum DateSelectionChoices {
        case allDays
        case weekendsOnly
        case weekdaysOnly
    }
    
    @StateObject var monthModel: MDPModel
	
	private var animate = true
	
	private var cornerRadius: CGFloat = 10
	
	private var borderColor = Color.accentColor
	private var borderWidth: CGFloat = 1
	private var showBorder = true
        
    // selects only a single date
    
	public init(singleDay: Binding<Date>,
         includeDays: DateSelectionChoices = .allDays,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = StateObject(wrappedValue: MDPModel(singleDay: singleDay, includeDays: includeDays, minDate: minDate, maxDate: maxDate))
    }
    
    // selects any number of dates, non-contiguous
    
	public init(anyDays: Binding<[Date]>,
         includeDays: DateSelectionChoices = .allDays,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = StateObject(wrappedValue: MDPModel(anyDays: anyDays, includeDays: includeDays, minDate: minDate, maxDate: maxDate))
    }
    
    // selects a closed date range
    
	public init(dateRange: Binding<ClosedRange<Date>?>,
         includeDays: DateSelectionChoices = .allDays,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = StateObject(wrappedValue: MDPModel(dateRange: dateRange, includeDays: includeDays, minDate: minDate, maxDate: maxDate))
    }
    
    public var body: some View {
        MDPMonthView()
			.animate(animate)
			.cornerRadius(cornerRadius)
			.border(showBorder, color: borderColor, lineWidth: borderWidth)
            .environmentObject(monthModel)
    }
	
	// MARK: Modifier
	
	public func animate(_ value: Bool) -> Self {
		var view = self
		view.animate = value
		return view
	}
	
	public func cornerRadius(_ value: CGFloat) -> Self {
		var view = self
		view.cornerRadius = value
		return view
	}
	
	public func border(_ showBorder: Bool, color: Color = .accentColor, lineWidth: CGFloat = 1) -> Self {
		var view = self
		view.borderColor = color
		view.borderWidth = lineWidth
		view.showBorder = showBorder
		return view
	}
}

struct MultiDatePicker_Previews: PreviewProvider {
    @State static var oneDay = Date()
    @State static var manyDates = [Date]()
    @State static var dateRange: ClosedRange<Date>? = nil
    
    static var previews: some View {
		MultiDatePicker(dateRange: $dateRange)
		MultiDatePicker(singleDay: $oneDay, includeDays: .weekdaysOnly)
		MultiDatePicker(anyDays: $manyDates, includeDays: .weekendsOnly)
    }
}
