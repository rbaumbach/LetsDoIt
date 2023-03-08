import Foundation

extension UserDefaults {
    var fileURL: URL {
        let fileName = Bundle.main.bundleIdentifier!
        let library = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        let preferences = library.appendingPathComponent("Preferences")
        let userDefaultsPlistURL = preferences.appendingPathComponent(fileName).appendingPathExtension("plist")
        
        print(userDefaultsPlistURL)
        
        return userDefaultsPlistURL
    }
    
    func delete() {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: fileURL.path) {
            print("UserDefaults plist file exists!")
            
            try! fileManager.removeItem(at: fileURL)
            
            print("UserDefaults plist deleted!")
        } else {
            print("UserDefaults plist file does NOT exist!")
        }
    }
    
    func reset() {
        let domain = Bundle.main.bundleIdentifier!
        
        removePersistentDomain(forName: domain)
    }

    func addRandomIntegers(totalNumberOfIntegers: Int,
                           lowerLimit: Int = 0,
                           upperLimit: Int = 10_000) {
        for _ in 0..<totalNumberOfIntegers {
            let randomIntValue = Int.random(in: lowerLimit..<upperLimit)
            let randomIntKey = String(randomIntValue)
            
            UserDefaults.standard.set(randomIntValue, forKey: randomIntKey)
        }
    }
    
    func addRandomStrings(totalNumberOfStrings: Int) {
        for _ in 0..<totalNumberOfStrings {
            let randomString = UUID().uuidString

            UserDefaults.standard.set(randomString, forKey: randomString)
        }
    }
    
    func addRandomArraysWithIntegers(totalNumberOfArrays: Int,
                                     arraySize: Int = 10) {
        // Note: It takes about ~6 seconds to create 1 million arrays of size 10
        // if created directly before attempting to populate UserDefaults
        
        for _ in 0..<totalNumberOfArrays {
            let array = Array(0..<arraySize)
            
            UserDefaults.standard.set(array, forKey: UUID().uuidString)
        }
    }
    
    func addRandomDictionaries(totalNumberOfDictionaries: Int) {
        for _ in 1..<totalNumberOfDictionaries {
            // Interestinly enough, you cannot save a dictionary with an Int key
            // to UserDefaults ¯\_(ツ)_/¯
            
            // Example Dictionary
            //
            // { "uno": {
            //            "dos": {
            //                     "tres": 99
            //                   }
            //          }
            // }
            
            let randomInt = Int.random(in: 0..<1_000)
            let dict = [ UUID().uuidString: [ UUID().uuidString: [UUID().uuidString: randomInt] ] ]
            
            UserDefaults.standard.set(dict, forKey: UUID().uuidString)
        }
    }
    
    func addRandomStructures(totalNumberOfStructures: Int) {
        for _ in 1..<totalNumberOfStructures {
            let dog = Dog(name: "Pancho",
                          birthdate: Date(),
                          breed: "Chihuahua")
            
            let data = try! JSONEncoder().encode(dog)
            
            UserDefaults.standard.set(data, forKey: UUID().uuidString)
        }
    }
}
