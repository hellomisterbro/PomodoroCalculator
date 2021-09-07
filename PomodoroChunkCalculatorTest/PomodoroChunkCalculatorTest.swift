//
//  PomodoroChunkCalculatorTest.swift
//  PomodoroChunkCalculatorTest
//
//  Created by Mykyta Kyrychek on 4/20/21.
//

import XCTest
import PomodoroCulculator

class PomodoroChunkCalculatorTest: XCTestCase {
    
    let calculator = PomodoroChunkCalculator()

    // 2 hours | normal
    func testNormalEnergy120() {
        let expectedResult: PomodoroChunkCalculator.PomodoroChunk = (26, 5)
        let result = calculator.chunk(for: 120, mode: .normal)
        XCTAssertEqual(result.pomodoroDuration, expectedResult.pomodoroDuration)
        XCTAssertEqual(result.breakDuration, expectedResult.breakDuration)
    }
    
    // 2 hours | low
    func testLowEnergy120() {
        let expectedResult: PomodoroChunkCalculator.PomodoroChunk = (25, 6)
        let result = calculator.chunk(for: 120, mode: .low)
        XCTAssertEqual(result.pomodoroDuration, expectedResult.pomodoroDuration)
        XCTAssertEqual(result.breakDuration, expectedResult.breakDuration)
    }
    
    // 1 hour 45 minutes | normal
    func testNormalEnergy105() {
        let expectedResult: PomodoroChunkCalculator.PomodoroChunk = (23, 4)
        let result = calculator.chunk(for: 105, mode: .normal)
        XCTAssertEqual(result.pomodoroDuration, expectedResult.pomodoroDuration)
        XCTAssertEqual(result.breakDuration, expectedResult.breakDuration)
    }
    
    // 1 hour 45 minutes | low
    func testLowEnergy105() {
        let expectedResult: PomodoroChunkCalculator.PomodoroChunk = (22, 5)
        let result = calculator.chunk(for: 105, mode: .low)
        XCTAssertEqual(result.pomodoroDuration, expectedResult.pomodoroDuration)
        XCTAssertEqual(result.breakDuration, expectedResult.breakDuration)
    }
    
    // 47 minutes | normal
    func testNormalEnergy47() {
        let expectedResult: PomodoroChunkCalculator.PomodoroChunk = (21, 4)
        let result = calculator.chunk(for: 47, mode: .normal)
        XCTAssertEqual(result.pomodoroDuration, expectedResult.pomodoroDuration)
        XCTAssertEqual(result.breakDuration, expectedResult.breakDuration)
    }
    
 
}
