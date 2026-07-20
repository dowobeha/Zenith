//
//  ContentView.swift
//  Zenith
//
//  Created by Lane Woodrose Schwartz on 7/19/26.
//
import SwiftUI

struct ContentView: View {
  
  @State private var timeString: String = "Z+HH:mm"
  @State private var timer: Timer?
  
  @State private var offset: Int = -1133
  
  var body: some View {
    Text(timeString)
      .onAppear {
        startClock()
      }
  }
  
  private func startClock() {
    updateTime()
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
      updateTime()
    }
  }
  
  private func updateTime() {
    let today = Date()
    let unixSeconds = Int(today.timeIntervalSince1970)
    
    // Example: Offset of +2 hours (7,200 seconds).
    // Pass 0 for UTC, or TimeZone.current.secondsFromGMT for local system time.
    let possibleHours = offset / 100
    let possibleMinutes = offset % 100
    
    let offsetHours: Int = if possibleHours < -12 {
      -12
    } else if possibleHours > 14 {
      14
    } else {
      possibleHours
    }
    let offsetMinutes: Int = if possibleMinutes < -59 {
      -59
    } else if possibleMinutes > 59 {
      59
    } else {
      possibleMinutes
    }
    
    let offsetSeconds = offsetHours*60*60 + offsetMinutes*60
    
    var components = Calendar.current.dateComponents([.year, .month, .day], from: today)
    components.hour = 12
    components.minute = 0
    components.second = 0
    
    var calendar = Calendar.current
    
    
    guard let timeZone = TimeZone(secondsFromGMT: offsetSeconds) else {
      timeString = formatUnixTime(unixSeconds, timeZoneOffsetSeconds: offsetSeconds)
      return
    }
    
    calendar.timeZone = timeZone
    
    guard let noon = calendar.date(from: components) else {
      timeString = formatUnixTime(unixSeconds, timeZoneOffsetSeconds: offsetSeconds)
      return
    }
    
    let noonUnixSeconds = Int(noon.timeIntervalSince1970)
    
    let timeDifference = noonUnixSeconds - unixSeconds
    
    let hours = timeDifference / 3600
    let minutes = (timeDifference % 3600) / 60
    
    let sign = timeDifference < 0 ? "+" : "-"
    
    timeString = /*"☀*/ "Z\(sign)\(String(format: "%02d", abs(hours))):\(String(format: "%02d", abs(minutes)))"
    
    //}
    //timeString = formatUnixTime(unixSeconds, timeZoneOffsetSeconds: offsetSeconds)
    
    
    //formatter.timeZone = timeZone
    
    
    
  }
  
  private func formatUnixTime(_ unixSeconds: Int, timeZoneOffsetSeconds: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(unixSeconds))
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm" // 'UTC'Z"
    //formatter.timeStyle = .medium
    
    if let timeZone = TimeZone(secondsFromGMT: timeZoneOffsetSeconds) {
      formatter.timeZone = timeZone
    }
    
    return formatter.string(from: date)
  }
}
