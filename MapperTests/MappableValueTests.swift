import Mapper
import XCTest

final class MappableValueTests: XCTestCase {
    func testNestedMappable() {
        struct Test: Mappable {
            let nest: Nested
            init(map: Mapper) throws {
                try self.nest = map.from("nest")
            }
        }

        struct Nested: Mappable {
            let string: String
            init(map: Mapper) throws {
                try self.string = map.from("string")
            }
        }

        let test = try! Test(map: ["nest": ["string": "hello"]])
        XCTAssertTrue(test.nest.string == "hello")
    }

    func testArrayOfMappables() {
        struct Test: Mappable {
            let nests: [Nested]
            init(map: Mapper) throws {
                try self.nests = map.from("nests")
            }
        }

        struct Nested: Mappable {
            let string: String
            init(map: Mapper) throws {
                try self.string = map.from("string")
            }
        }

        let test = try! Test(map: ["nests": [["string": "first"], ["string": "second"]]])
        XCTAssertTrue(test.nests.count == 2)
    }

    func testOptionalMappable() {
        struct Test: Mappable {
            let nest: Nested?
            init(map: Mapper) throws {
                self.nest = map.optionalFrom("foo")
            }
        }

        struct Nested: Mappable {
            init(map: Mapper) throws {}
        }

        let test = try! Test(map: [:])
        XCTAssertNil(test.nest)
    }

    func testInvalidArrayOfMappables() {
        struct Test: Mappable {
            let nests: [Nested]
            init(map: Mapper) throws {
                try self.nests = map.from("nests")
            }
        }

        struct Nested: Mappable {
            let string: String
            init(map: Mapper) throws {
                try self.string = map.from("string")
            }
        }

        let test = try? Test(map: ["nests": "not an array"])
        XCTAssertNil(test)
    }

    func testValidArrayOfOptionalMappables() {
        struct Test: Mappable {
            let nests: [Nested]?
            init(map: Mapper) throws {
                self.nests = map.optionalFrom("nests")
            }
        }

        struct Nested: Mappable {
            let string: String
            init(map: Mapper) throws {
                try self.string = map.from("string")
            }
        }

        let test = try! Test(map: ["nests": [["string": "first"], ["string": "second"]]])
        XCTAssertTrue(test.nests?.count == 2)
    }

    func testMalformedArrayOfMappables() {
        struct Test: Mappable {
            let nests: [Nested]
            init(map: Mapper) throws {
                try self.nests = map.from("nests")
            }
        }

        struct Nested: Mappable {
            let string: String
            init(map: Mapper) throws {
                try self.string = map.from("string")
            }
        }

        let test = try? Test(map: ["nests": [["foo": "first"], ["string": "second"]]])
        XCTAssertNil(test)
    }

    func testInvalidArrayOfOptionalMappables() {
        struct Test: Mappable {
            let nests: [Nested]?
            init(map: Mapper) throws {
                self.nests = map.optionalFrom("nests")
            }
        }

        struct Nested: Mappable {
            let string: String
            init(map: Mapper) throws {
                try self.string = map.from("string")
            }
        }

        let test = try! Test(map: ["nests": "not an array"])
        XCTAssertNil(test.nests)
    }
}
