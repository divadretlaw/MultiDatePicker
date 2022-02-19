# MultiDatePicker

Many applications have the need to pick a date. But what if you have an app that requires more than one date to be selected by the user? Perhaps you are writing a hotel reservation system or an employee scheduler and need the user to select starting and ending dates or just all the days they will be working this month. 

This is where `MultiDataPicker` comes in. The standard Apple `DatePicker` lets you pick a single day. `MultiDatePicker` lets you pick a single day, a collection of days, or a date range. Its all in how you set up the component.

The `ContentView` gives you examples of each type of selection mode `MultiDatePicker` is capable of. You need a variable to use for binding and then just use it.

### Single Day

```swift
@State var selectedDate = Date()
MultiDatePicker(singleDay: self.$selectedDate)
```
Whenever the user taps a date on the control's calendar the wrapped value will change. The calendar shows the month and year for the date given.

### Collection of Days

```swift
@State var manyDays = [Date]()
MultiDatePicker(anyDays: self.$manyDays)
```

Whenever the user taps on a date on the control's calendar the date will be selected and added to the wrapped collection. If the date is already selected, the tap will remove it from the collection and change the wrapped value of the binding. 

The calendar in the control will reflect the first date in the array; otherwise it will show the month/year for the current date.

### Date Range

```swift
@State var range: ClosedRange<Date>? = nil
MultiDatePicker(dateRange: self.$range)
```
The wrapped value of the binding only changes if two dates are selected. If a third date is picked, the wrapped value is reset to `nil` and the range is removed from the calendar leaving only the one date selected. The user has to tap another date to complete the range and change the wrapped value.

The calendar in the control will show the month/year for the first day of the range. If the range is nil it will show the current month/year.

## More Options

The `MultiDatePicker` has few other options you can pass into it to limit which days can be selected. 

The `includeDays` parameter can be one of `.allDays` (the default), `weekendOnly`, or `weekdaysOnly`. For example if you pass `includeDays = .weekdaysOnly` then all weekend days appear gray and cannot be selected.

You can also set a `minDate` and/or a `maxDate` (both of which default to `nil`). Dates before `minDate` or after `maxDate` cannot be selected and appear gray.

## Installation

`MultiDatePicker` is a swift package - add it to Package.swift:

```swift
dependencies: [
    .package(url: "https://github.com/divadretlaw/MultiDatePicker.git", from: "1.0.0"),
],
targets: [
    .target(
        name: "MyApp", // Where "MyApp" is the name of your app
        dependencies: ["MultiDatePicker"]),
]
```

Or, in Xcode, you can select File » Swift Packages » Add Package Dependency... and specify the repository URL `https://github.com/divadretlaw/MultiDatePicker.git` and "up to next major version" `1.0.0`.
