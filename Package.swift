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
            name: "Builder Standard Library Integration",
            targets: ["Builder Standard Library Integration"]
        ),
        .library(
            name: "Builder Apple Foundation Integration",
            targets: ["Builder Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-linear.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-initialization.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-allocation.git",
            branch: "main", traits: ["MemorySmall"]),
        .package(url: "https://github.com/swift-atoms/swift-storage.git", branch: "main", traits: ["Generational", "Memory"]),
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
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Storage", package: "swift-storage"),
                .product(name: "Memory Small", package: "swift-memory-allocation"),
            ]
        ),
        .target(
            name: "Builder Standard Library Integration",
            dependencies: ["Builder"]
        ),
        .target(
            name: "Builder Apple Foundation Integration",
            dependencies: [
                "Builder",
                "Builder Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Builder Tests",
            dependencies: ["Builder",
                .product(name: "Buffer Linear", package: "swift-buffer-linear"),
                .product(name: "Memory Small", package: "swift-memory-allocation"),
                .product(name: "Storage", package: "swift-storage"),
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
