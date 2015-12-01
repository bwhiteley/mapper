import Mapper
import XCTest

final class RawRepresentibleValueTests: XCTestCase {
    func testRawRepresentable() {
        struct Test: Mappable {
            let suit: Suits
            init(map: Mapper) throws {
                try self.suit = map.from("suit")
            }
        }

        enum Suits: String {
            case Hearts = "hearts"
        }

        let test = try! Test(map: ["suit": "hearts"])
        XCTAssertTrue(test.suit == .Hearts)
    }

    func testRawRepresentableNumber() {
        struct Test: Mappable {
            let value: Value
            init(map: Mapper) throws {
                try self.value = map.from("value")
            }
        }

        enum Value: Int {
            case First = 1
        }

        let test = try! Test(map: ["value": 1])
        XCTAssertTrue(test.value == .First)
    }

    func testMissingRawRepresentableNumber() {
        struct Test: Mappable {
            let value: Value
            init(map: Mapper) throws {
                try self.value = map.from("value")
            }
        }

        enum Value: Int {
            case First = 1
        }

        let test = try? Test(map: [:])
        XCTAssertNil(test)
    }

    func testOptionalRawRepresentable() {
        struct Test: Mappable {
            let value: Value?
            init(map: Mapper) throws {
                self.value = map.optionalFrom("value")
            }
        }

        enum Value: Int {
            case First = 1
        }

        let test = try! Test(map: [:])
        XCTAssertNil(test.value)
    }

    func testExistingOptionalRawRepresentable() {
        struct Test: Mappable {
            let value: Value?
            init(map: Mapper) throws {
                self.value = map.optionalFrom("value")
            }
        }

        enum Value: Int {
            case First = 1
        }

        let test = try! Test(map: ["value": 1])
        XCTAssertTrue(test.value == .First)
    }

    func testRawRepresentableTypeMismatch() {
        struct Test: Mappable {
            let value: Value?
            init(map: Mapper) throws {
                self.value = map.optionalFrom("value")
            }
        }

        enum Value: Int {
            case First = 1
        }

        let test = try! Test(map: ["value": "not an int"])
        XCTAssertNil(test.value)
    }
}
