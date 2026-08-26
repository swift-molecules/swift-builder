public import Buffer_Linear
public import Initialization
public import Memory_Allocator_Primitive
public import Memory_Heap
public import Storage_Contiguous

public protocol Buildable: Initiable, ~Copyable {

    associatedtype Element: ~Copyable

    mutating func add(_ element: consuming Element)
}

extension Buildable where Self: ~Copyable {

    @inlinable
    public init(
        @Builder<Element> _ content: () ->
            Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Element>>.Linear
    ) throws(Failure) {
        try self.init()
        var buffer = content()
        while !buffer.isEmpty {
            self.add(buffer.remove.first())
        }
    }
}
