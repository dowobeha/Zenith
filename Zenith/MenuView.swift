//
//  MenuView.swift
//  Zenith
//
//  Created by Lane Woodrose Schwartz on 7/19/26.
//
import SwiftUI

struct MenuView: View {
  
  @State private var selectedHour: Int = 2
      @State private var selectedMinute: Int = 0

      let hours = Array(-12...12)
      let minutes = [0, 30, 45] // Added 45 for zones like Nepal (+5:45) or Eucla (+8:45)
  
    var body: some View {
        Button("Quit") {
        //exit(0)
            NSApplication.shared.terminate(nil)
        }
        .keyboardShortcut("q")
    }
}
