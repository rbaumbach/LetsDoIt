import XCTest
@testable import LoadingUpUserDefaults

final class LoadingUpUserDefaultsTests: XCTestCase {
    var userDefaults: UserDefaults!
    var measureOptions: XCTMeasureOptions!
    var measurement: Measurement!
    
    override func setUp() {
        super.setUp()
                
        userDefaults = UserDefaults.standard
        
        userDefaults.reset()
        print("UserDefaults has been reset!")
        
        measureOptions = XCTMeasureOptions()
        measureOptions.iterationCount = 2
        
        measurement = Measurement()
    }
    
    // MARK: - Easy data types

    func testAdd500_000IntegersToUserDefaults() throws {
        self.measure(options: measureOptions) {
            userDefaults.addRandomIntegers(totalNumberOfIntegers: 500_000)
        }
        
        // Simulator captured average time: ~1.350 sec
    }
    
    func testAdd10_000StringsToUserDefaults() throws {
        self.measure(options: measureOptions) {
            userDefaults.addRandomStrings(totalNumberOfStrings: 10_000)
        }
        
        // Simulator captured average time: ~3.04 sec
    }
    
    // MARK: - Arrays, Dictionaries and custom types oh my...
    
    func testAdd3_000ArraysOfIntegersSize10ToUserDefaults() throws {
        self.measure(options: measureOptions) {
            userDefaults.addRandomArraysWithIntegers(totalNumberOfArrays: 3_000)
        }
        
        // Simulator captured average time: ~1.079 sec
    }
    
    func testAdd5_000DictionariesToUserDefaults() throws {
        self.measure {
            userDefaults.addRandomDictionaries(totalNumberOfDictionaries: 5_000)
        }

        // Simulator captured average time: ~0.86 sec
    }
    
    func testAdd1_000CustomTypesToUserDefaults() throws {
        self.measure {
            userDefaults.addRandomStructures(totalNumberOfStructures: 1000)
        }
        
        // Simulator captured average time: ~0.35 sec
    }
}
