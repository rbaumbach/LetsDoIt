import XCTest
@testable import LoadingUpUserDefaults

final class LoadingUpUserDefaultsTests: XCTestCase {
    var userDefaults: UserDefaults!
    var measureOptions: XCTMeasureOptions!
    
    override func setUp() {
        super.setUp()
        
        userDefaults = UserDefaults.standard
        
        measureOptions = XCTMeasureOptions()
        measureOptions.iterationCount = 3
    }
    
    override func tearDown() {
        super.tearDown()
        
        userDefaults.reset()
    }
    
    // MARK: - Easy data types

    func testAdd500_000IntegersToUserDefaults() throws {
        self.measure(options: measureOptions) {
            userDefaults.addRandomIntegers(totalNumberOfIntegers: 500_000)
        }
    }
    
    func testAdd1_000_000IntegersToUserDefaults() throws {
        self.measure(options: measureOptions) {
            userDefaults.addRandomIntegers(totalNumberOfIntegers: 1_000_000)
        }
    }
    
    func testAdd500_000StringsToUserDefaults() throws {
        self.measure(options: measureOptions) {
            userDefaults.addRandomStrings(totalNumberOfStrings: 500_000)
        }
    }
    
    func testAdd1_000_000StringsToUserDefaults() throws {
        self.measure(options: measureOptions) {
            userDefaults.addRandomStrings(totalNumberOfStrings: 1_000_000)
        }
    }
    
    // MARK: - Arrays
    
    func testAdd3_000ArraysOfSize10ToUserDefaults() throws {
        self.measure(options: measureOptions) {
            userDefaults.addRandomArraysWithIntegers(totalNumberOfArrays: 3_000)
        }
    }
}
