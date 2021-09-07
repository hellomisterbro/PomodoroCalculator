//
//  PomodoroChunkCalculator.swift
//  PomodoroCulculator
//
//  Created by Mykyta Kyrychek on 4/19/21.
//

import Foundation

class PomodoroChunkCalculator {
    
    enum EnergyMode {
        case normal
        case low
    }
    
    typealias PomodoroChunk = (pomodoroDuration: Int, breakDuration: Int)
    
    // MARK: Public
    
    lazy var minWholeChunkDuration: Int  = {
        let defaultChunkDuration = defaultWholeChunk.pomodoroDuration + defaultWholeChunk.breakDuration
        return defaultChunkDuration - pomodoroMaxShift - breakMaxShift
    }()
    
    // MARK: Private
    
    private let defaultWholeChunk: PomodoroChunk = (25, 5)
    private var pomodoroMaxShift = 4
    private lazy var breakMaxShift: Int = {
        let minChunkBreak = chunkBreak(for: defaultWholeChunk.pomodoroDuration - pomodoroMaxShift,
                                       mode: .normal)
        let maxChunkBreak = chunkBreak(for: defaultWholeChunk.pomodoroDuration + pomodoroMaxShift,
                                       mode: .low)
        let defaultChunkBreak = Double(defaultWholeChunk.breakDuration)
        assert(defaultChunkBreak > minChunkBreak && defaultChunkBreak < maxChunkBreak,
               "Bad programmer. Change default chunk break to be normal!")
        let breakMaxShift =  max(defaultChunkBreak - minChunkBreak,
                                 maxChunkBreak - defaultChunkBreak)
        return Int(fabs(breakMaxShift))
    }()
        
    private lazy var maxWholeChunkDuration: Int = {
        let defaultWholeChunkDuration = defaultWholeChunk.pomodoroDuration + defaultWholeChunk.breakDuration
        return defaultWholeChunkDuration + pomodoroMaxShift + breakMaxShift
    }()
    
    private func chunkBreak(for pomodoroDuration: Int, mode: EnergyMode) -> Double {
        let lowEnergyBreak = { Double(2 * pomodoroDuration) / 5.0 - 4.0 }
        let normalEnergyBreak = { Double(pomodoroDuration - 5) / 4.0 }
        return mode == .low ? lowEnergyBreak() : normalEnergyBreak()
    }
    
    private func bestChunk(for wholeChunkDuration: Int, mode: EnergyMode) -> PomodoroChunk {
        let minPomdoroDuration = defaultWholeChunk.pomodoroDuration - pomodoroMaxShift
        let maxPomodoroDuration = defaultWholeChunk.pomodoroDuration + pomodoroMaxShift
    
        var lowestBreakDifference = Double(maxPomodoroDuration)
        var bestChunk = defaultWholeChunk
        for pomodoroDuration in minPomdoroDuration...maxPomodoroDuration {
            let chunkBreak = wholeChunkDuration - pomodoroDuration
            guard chunkBreak >= defaultWholeChunk.breakDuration - breakMaxShift else {
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

    func chunk(for workDuration: Int, mode: EnergyMode) -> PomodoroChunk {
        assert(workDuration >= minWholeChunkDuration)
        var bestPomodoroChunk: PomodoroChunk?
        var previousBestReminder = Int.max
        for wholeChunkDuration in minWholeChunkDuration...maxWholeChunkDuration {
            let pomodoroChunk = bestChunk(for: wholeChunkDuration, mode: mode)
            let reminder = (workDuration + pomodoroChunk.breakDuration) % wholeChunkDuration
            if reminder < previousBestReminder {
                previousBestReminder = reminder
                bestPomodoroChunk = pomodoroChunk
            }
        }
        return bestPomodoroChunk ?? defaultWholeChunk
    }
}
