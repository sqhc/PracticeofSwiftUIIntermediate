//
//  TimerPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/14/23.
//

import SwiftUI

struct TimerPractice: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    //Current time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }*/
    
    //Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
     */
    
    //Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaing() {
        let remaing = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let minute = remaing.minute ?? 0
        let second = remaing.second ?? 0
        timeRemaining = "\(minute) minutes, \(second) seconds"
    }*/
    
    // Animation counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack{
            RadialGradient(
                colors: [Color.cyan, Color.indigo],
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer) { _ in
            withAnimation(.default){
                count = count == 5 ? 1 : count + 1
            }
        }
    }
}

struct TimerPractice_Previews: PreviewProvider {
    static var previews: some View {
        TimerPractice()
    }
}
