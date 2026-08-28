import Builder
import Memory_Allocator_Primitive
import Memory_Small
import Storage_Memory

extension Fixture {

    public struct Tokens: ~Copyable {

        public var storage:
            Buffer<Storage<Memory.Allocator<Memory.Small<0>>>.Contiguous<Fixture.Token>>.Linear

        public init(
            @Builder<Fixture.Token> _ content: () ->
                Buffer<Storage<Memory.Allocator<Memory.Small<0>>>.Contiguous<Fixture.Token>>.Linear
        ) {
            self.storage = content()
        }
    }
}

extension Fixture.Tokens {

    public consuming func ids() -> [Int] {
        var out: [Int] = []
        var rest = storage
        while !rest.isEmpty {
            out.append(rest.remove.first().id)
        }
        return out
    }
}
