public import Builder
public import Buffer_Linear
public import Memory_Allocator
public import Memory_Small
public import Storage

extension Fixture {

    public struct Ints: ~Copyable {

        public var storage:
            Buffer<Storage<Memory.Allocator<Memory.Small<0>>>.Contiguous<Int>>.Linear

        public init(
            @Builder<Int> _ content: () ->
                Buffer<Storage<Memory.Allocator<Memory.Small<0>>>.Contiguous<Int>>.Linear
        ) {
            self.storage = content()
        }
    }
}

extension Fixture.Ints {

    public consuming func values() -> [Int] {
        var out: [Int] = []
        var rest = storage
        while !rest.isEmpty {
            out.append(rest.remove.first())
        }
        return out
    }
}
