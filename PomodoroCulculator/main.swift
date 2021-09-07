//
//  main.swift
//  PomodoroCulculator
//
//  Created by Mykyta Kyrychek on 4/19/21.
//

import Foundation

print("Please enter pomodoro duration in minutes:")

guard let pomodoroDurationString = readLine(),
   let pomodoroDurationNum = Int(pomodoroDurationString)  else {
    print("Be a nice human. Enter a valid pomodoro duraiton.")
    exit(0)
}

let calculator = PomodoroChunkCalculator()

//too small message
if pomodoroDurationNum < calculator.minPomodoroDuration  {
    print("Be a nice human. Enter a valid pomodoro duraiton. More then \(calculator.minPomodoroDuration)")
    exit(0)
}

//another stupid message
print("\(pomodoroDurationNum) minutes??? Wow, that's lot of work. Good luck!")


//real work
let pomodoroChunk = calculator.chunk(for: pomodoroDurationNum,
                                     mode: .normal)
print("Optimal time chunk for you is \(pomodoroChunk.pomodoroDuration) minutes with \(pomodoroChunk.breakDuration) break")

