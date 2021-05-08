//
//  PomodoroChunkCalculator.swift
//  PomodoroCulculator
//
//  Created by Mykyta Kyrychek on 4/19/21.
//

import Foundation

struct PomodoroChunkCalculator {
    
    enum EnergyMode {
        case normal
        case low
    }
    
    typealias PomodoroChunk = (duration: Int, break: Int)
    
    private static let defaultChunk: PomodoroChunk = (25, 5)
    private static var pomodoroMaxShift = 3
    private static var breakMaxShift = 2
    
    private static var minChunkDuration: Int = {
        let defaultChunkDuration = defaultChunk.duration + defaultChunk.break
        return defaultChunkDuration - pomodoroMaxShift - breakMaxShift
    }()
    
    private static var maxChunkDuration: Int = {
        let defaultChunkDuration = defaultChunk.duration + defaultChunk.break
        return defaultChunkDuration + pomodoroMaxShift + breakMaxShift
    }()
    
    private static func chunkBreak(for pomodoroDuration: Int, mode: EnergyMode) -> Double {
        let lowEnergyBreak = { Double(2 * pomodoroDuration) / 5.0 - 4.0 }
        let normalEnergyBreak = { Double(pomodoroDuration - 5) / 4.0 }
        return mode == .low ? lowEnergyBreak() : normalEnergyBreak()
    }
    
    private static func bestChunk(for chunkDuration: Int, mode: EnergyMode) -> PomodoroChunk {
        let minPomdoroDuration = defaultChunk.duration - pomodoroMaxShift
        let maxPomodoroDuration = defaultChunk.duration + pomodoroMaxShift
    
        var lowestBreakDifference = Double(maxPomodoroDuration)
        var bestChunk = defaultChunk
        for pomodoroDuration in minPomdoroDuration...maxPomodoroDuration {
            let chunkBreak = chunkDuration - pomodoroDuration
            guard chunkBreak >= defaultChunk.break - breakMaxShift else {
                continue
            }
            let expectedBreak = self.chunkBreak(for: pomodoroDuration, mode: mode)
            let breakDifference = fabs(expectedBreak - Double(chunkBreak))
            if breakDifference < lowestBreakDifference {
                lowestBreakDifference = breakDifference
                bestChunk = (pomodoroDuration, chunkBreak)
            }
        }
        return bestChunk
    }

    static func chunk(for workDuration: Int, mode: EnergyMode) -> PomodoroChunk {
        var bestPomodoroChunk: PomodoroChunk?
        var previousBestReminder = Int.max
        for chunkDuration in minChunkDuration...maxChunkDuration {
            let pomodoroChunk = bestChunk(for: chunkDuration, mode: mode)
            let reminder = (workDuration + pomodoroChunk.break) % chunkDuration
            if reminder < previousBestReminder {
                previousBestReminder = reminder
                bestPomodoroChunk = pomodoroChunk
            }
        }
        return bestPomodoroChunk ?? defaultChunk
    }
}
