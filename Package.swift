// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-builder",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Builder",
            targets: ["Builder"]
        ),

        .library(
            name: "Builder Test Support",
            targets: ["Builder Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-linear.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-molecules/swift-initialization.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-molecules/swift-storage.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-heap.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-allocation.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Builder",
            dependencies: [
                .product(
                    name: "Buffer Linear",
                    package: "swift-buffer-linear"
                ),
                .product(
                    name: "Initialization",
                    package: "swift-initialization"
                ),
                .product(
                    name: "Storage Contiguous",
                    package: "swift-storage"
                ),
                .product(name: "Memory Heap", package: "swift-memory-heap"),
                .product(
                    name: "Memory Allocator Primitive",
                    package: "swift-memory-allocation"
                ),
            ]
        ),

        .target(
            name: "Builder Test Support",
            dependencies: [
                "Builder",
                .product(
                    name: "Buffer Linear Test Support",
                    package: "swift-buffer-linear"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Builder Tests",
            dependencies: [
                "Builder",
                "Builder Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
