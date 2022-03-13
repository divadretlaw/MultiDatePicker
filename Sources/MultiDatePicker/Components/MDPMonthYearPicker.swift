//
//  MonthYearPicker.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI

/**
 * This is a two-wheel picker for selecting a month and a year. It appears when the user
 * taps on the month/year at the top of the MDMonthView.
 *
 * When a month or year is selected, the action parameter is invoked with the new values.
 */
struct MDPMonthYearPicker: View {
    var date: Date
    var action: (Int, Int) -> Void
    
    @State private var selected = [1, Calendar.current.component(.year, from: Date())]
	
    var proxy: GeometryProxy?
    
    init(date: Date, proxy: GeometryProxy? = nil, action: @escaping (Int, Int) -> Void) {
        self.date = date
        self.action = action
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        self._selected = State(initialValue: [month, year])
        self.proxy = proxy
    }
    
    var body: some View {
        HStack {
            MonthYearPicker(selections: self.$selected)
                .onChange(of: selected) { value in
                    self.action(value[0], value[1])
                }
        }
    }
}

struct MonthYearPicker_Previews: PreviewProvider {
    static var previews: some View {
        MDPMonthYearPicker(date: Date()) { month, year in
            print("You picked \(month), \(year)")
        }
        .frame(width: 300, height: 300)
    }
}
