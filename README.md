# Calling sizeThatFits: on UILabel with NSAttributedString + BackgroundColor causes memory problems ([rdar://23495376](http://openradar.appspot.com/23495376))

### Summary:

Give a UILabel that has an NSAttributedString. The NSAttributedString has the following attributes set:

```swift
[
  NSForegroundColorAttributeName: UIColor.blackColor(),
  NSFontAttributeName: UIFont(name: "Menlo", size: 14)!,
  NSBackgroundColorAttributeName: UIColor.whiteColor()
]
```

Calculating the size using `sizeThatFits:` causes a memory footprint of ~1.3 GB but only ~350 MB when used without the `NSBackgroundColorAttributeName`.

### Steps to Reproduce:
1. Download the attached sample project
2. Run app on a test device and scroll up and down
3. Watch memory gauge and wait until app is terminated
4. Go to `MasterViewController.swift` and comment out Line 19
5. Run app on a test device and scroll up and down
6. App should no longer crash

### Expected Results:

Calculating the labels height with should not result in memory leaks

### Actual Results:

Calculating the labels height with should results in enormous memory footprint

### Regression:

Problem is extremely notable when used in a TableView with more than 10 cells
