//
//  main.swift
//  PomodoroCulculator
//
//  Created by Mykyta Kyrychek on 4/19/21.
//

import Foundation
//import 

print("Please enter pomodoro duration in minutes:")


if let pomodoroDurationString = readLine(),
   let pomodoroDurationNum = Int(pomodoroDurationString) {
    let calculator = PomodoroChunkCalculator()
    if pomodoroDurationNum < calculator.minWholeChunkDuration  {
        print("Be a nice human. Enter a valid pomodoro duraiton. More then \(calculator.minWholeChunkDuration)")
        exit(0)
    }
    print("\(pomodoroDurationNum) minutes??? Wow, that's lot of work. Good luck!")
    let pomodoroChunk = calculator.chunk(for: pomodoroDurationNum,
                                         mode: .normal)
    print("Optimal time chunk for you is \(pomodoroChunk.pomodoroDuration) minutes with \(pomodoroChunk.breakDuration) break")
} else {
    print("Be a nice human. Enter a valid pomodoro duraiton.")
}

