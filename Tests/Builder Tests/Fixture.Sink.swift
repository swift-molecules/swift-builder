public import Builder
public import Buffer_Linear
public import Memory_Allocator
public import Memory_Small
public import Storage

extension Fixture {

    public struct Sink: ~Copyable {

        public var storage:
            Buffer<Storage<Memory.Allocator<Memory.Small<0>>>.Contiguous<Fixture.Token>>.Linear

        public init() {
            self.storage = Buffer<
                Storage<Memory.Allocator<Memory.Small<0>>>.Contiguous<Fixture.Token>
            >.Linear(minimumCapacity: .zero)
        }
    }
}

extension Fixture.Sink: Buildable {

    public mutating func add(_ element: consuming Fixture.Token) {
        storage.append(consume element)
    }
}

extension Fixture.Sink {

    public consuming func ids() -> [Int] {
        var out: [Int] = []
        var rest = storage
        while !rest.isEmpty {
            out.append(rest.remove.first().id)
        }
        return out
    }
}
