// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "ChessboardKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "ChessboardKit",
            targets: ["ChessboardKit"]),
    ],
    dependencies: [.package(url: "https://github.com/aperechnev/ChessKit", from: "1.3.7")],
    targets: [
        .target(name: "ChessboardKit",
                dependencies: ["ChessKit"],
                resources: [
                    .copy("Assets/Pieces/uscf"),
                    .copy("Assets/Pieces/chess_kaneo"),
                    .copy("Assets/Pieces/chess_kaneo_midnight"),
                    .copy("Assets/Pieces/chess_maestro_bw"),
                    .copy("Assets/Pieces/chess_1Kbyte_gambit"),
                    .copy("Assets/Pieces/sittuyin_green_red"),
                    .copy("Assets/Pieces/sittuyin_black_red")
                ])
    ],
    swiftLanguageModes: [.v5, .v6]
)
