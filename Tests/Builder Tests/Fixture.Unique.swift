public import Builder

extension Fixture {

    public struct Unique {

        public var elements: [Int]

        public init() {
            self.elements = []
        }
    }
}

extension Fixture.Unique: Buildable {

    public mutating func add(_ element: consuming Int) {
        if !elements.contains(element) {
            elements.append(element)
        }
    }
}
