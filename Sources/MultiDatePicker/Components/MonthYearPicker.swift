//
//  MonthYearPicker.swift
//  MultiDatePickerApp
//
//  Created by David Walter on 06.02.22.
//

import SwiftUI
import UIKit

struct MonthYearPicker: UIViewRepresentable {
    var selections: Binding<[Int]>
    // Apple provides the years 1 to 10_000 in Calendar.app
    private let data = [(1 ... 12).map { $0 }, (1 ... 10000).map { $0 }]

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIPickerView {
        let picker = UIPickerView()
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
		
        return picker
    }
	
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<Self>) {
        for component in selections.indices {
            if let row = data[component].firstIndex(of: selections.wrappedValue[component]) {
                view.selectRow(row, inComponent: component, animated: false)
            }
        }
    }
	
    func makeCoordinator() -> Self.Coordinator {
        Coordinator(self)
    }
	
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: MonthYearPicker
	  
        init(_ pickerView: MonthYearPicker) {
            self.parent = pickerView
        }
		
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            parent.data.count
        }
		
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            parent.data[component].count
        }
		
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0 {
                return Calendar.current.monthSymbols[row]
            } else {
                return String(format: "%d", parent.data[component][row])
            }
        }
		
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            parent.selections.wrappedValue[component] = parent.data[component][row]
        }
    }
}
