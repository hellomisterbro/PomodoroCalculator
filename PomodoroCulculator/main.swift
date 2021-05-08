//
//  main.swift
//  PomodoroCulculator
//
//  Created by Mykyta Kyrychek on 4/19/21.
//

import Foundation
//import 

print("Please enter pomodoro duration in minutes:")


//расписать самые популярные кейсы
//написать решение к ним
// написать алгоритм для всех этих кейсов

if let pomodoroDurationString = readLine(),
   let pomodoroDurationNum = Int(pomodoroDurationString) {
    print("\(pomodoroDurationNum) minutes??? Wow, that's lot of work. Good luck!")
    let pomodoroChunk = PomodoroChunkCalculator.chunk(for: pomodoroDurationNum,
                                                       mode: .normal)
    print("Optimal time chunk for you is \(pomodoroChunk.duration) minutes with ")
} else {
    print("Be a nice human. Enter a valid pomodoro duraiton.")
}

