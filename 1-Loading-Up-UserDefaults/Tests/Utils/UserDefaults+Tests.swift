import Foundation

extension UserDefaults {
    func reset() {
        let allUserDefaultsKeys = UserDefaults.standard.dictionaryRepresentation().keys
        
        allUserDefaultsKeys.forEach { key in
            removeObject(forKey: key)
        }
    }
    
    func addRandomIntegers(totalNumberOfIntegers: Int,
                           lowerLimit: Int = 0,
                           upperLimit: Int = 10_000) {
        let randomIntValue = Int.random(in: lowerLimit..<upperLimit)
        
        let randomIntKey = String(randomIntValue)
        
        for _ in 0..<totalNumberOfIntegers {
            UserDefaults.standard.set(randomIntValue, forKey: randomIntKey)
        }
    }
    
    func addRandomStrings(totalNumberOfStrings: Int) {
        let randomString = UUID().uuidString
        
        for _ in 0..<totalNumberOfStrings {
            UserDefaults.standard.set(randomString, forKey: randomString)
        }
    }
    
    func addRandomArraysWithIntegers(totalNumberOfArrays: Int,
                                     arraySize: Int = 10) {
        // Note: It takes about ~6 seconds to create 1 million arrays of size 10

        var arrayOfArrays: [[Int]] = []
        
        for _ in 0..<totalNumberOfArrays {
            arrayOfArrays.append(Array(0..<arraySize))
        }
        
        // Note: Adding arrays to UserDefaults is sloooowww...
                
        arrayOfArrays.forEach { array in
            UserDefaults.standard.set(array, forKey: UUID().uuidString)
        }
    }
}
