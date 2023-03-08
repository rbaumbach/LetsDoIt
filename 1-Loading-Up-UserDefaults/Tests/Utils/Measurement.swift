import Foundation

final class Measurement {
    func measure(numberOfMeasurements: Int = 1,
                 work: () -> Void,
                 onStart: (() -> Void)? = nil,
                 onFinish: (() -> Void)? = nil) -> CFAbsoluteTime {
        var elapsedTimes: [CFAbsoluteTime] = []
        
        for _ in 0..<numberOfMeasurements {
            onStart?()
            
            let workStart = CFAbsoluteTimeGetCurrent()
            
            work()

            let totalElapsedTime = CFAbsoluteTimeGetCurrent() - workStart
            
            elapsedTimes.append(totalElapsedTime)
            
            onFinish?()
        }
        
        let elapsedTimesSum = elapsedTimes.reduce(0, +)
        
        let averageElapsedTime = elapsedTimesSum / Double(elapsedTimes.count)
        
        return averageElapsedTime
    }
}
