# ChessboardKit Theme System

ChessboardKit now supports a comprehensive multi-theme system that allows you to customize both board color schemes and piece styles.

## Features

### Board Color Schemes
- **Light**: Classic light theme with gray tones
- **Dark**: Dark theme with black/gray tones  
- **Orange**: Warm orange tones
- **Blue**: Cool blue tones
- **Green**: Natural green tones
- **Red**: Bold red tones
- **Yellow**: Bright yellow tones
- **Purple**: Royal purple tones

### Piece Styles
- **USCF**: United States Chess Federation standard pieces
- **Classic**: Traditional chess piece design
- **Modern**: Contemporary minimalist pieces
- **Wood**: Wooden texture pieces
- **Marble**: Elegant marble-style pieces

## Usage

### 1. Individual Parameters (Original Request)

```swift
let chessboardModel = ChessboardModel(
    fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
    perspective: .white,
    colorScheme: .dark,
    allowOpponentMove: false,
    pieceStyle: .wood  // New parameter as requested
)
```

### 2. Using Preset Themes

```swift
// Using a preset theme
let chessboardModel = ChessboardModel(
    theme: ChessboardThemes.modernBlue
)

// Available preset themes:
// - ChessboardThemes.defaultLight
// - ChessboardThemes.defaultDark
// - ChessboardThemes.classicWood
// - ChessboardThemes.modernBlue
// - ChessboardThemes.elegantMarble
```

### 3. Creating Custom Themes

```swift
let customTheme = ChessboardTheme(
    colorScheme: .purple,
    pieceStyle: .marble
)

let chessboardModel = ChessboardModel(
    theme: customTheme
)
```

### 4. Dynamic Theme Changes

```swift
// Change individual properties
chessboardModel.setColorScheme(.dark)
chessboardModel.setPieceStyle(.wood)

// Change complete theme
chessboardModel.setTheme(ChessboardThemes.modernBlue)
```

## Asset Structure

Piece assets should be organized in the following structure:

```
Sources/ChessboardKit/Assets/Pieces/
├── uscf/
│   ├── wK.png, wQ.png, wR.png, wB.png, wN.png, wP.png
│   └── bK.png, bQ.png, bR.png, bB.png, bN.png, bP.png
├── classic/
│   ├── wK.png, wQ.png, wR.png, wB.png, wN.png, wP.png
│   └── bK.png, bQ.png, bR.png, bB.png, bN.png, bP.png
├── modern/
│   └── ... (same pattern)
├── wood/
│   └── ... (same pattern)
└── marble/
    └── ... (same pattern)
```

## Implementation Details

### PieceStyle Enum

```swift
public enum PieceStyle: String, CaseIterable, Sendable {
    case uscf = "uscf"
    case classic = "classic"
    case modern = "modern"
    case wood = "wood"
    case marble = "marble"
    
    public var displayName: String { /* ... */ }
    public var folderName: String { /* ... */ }
}
```

### ChessboardTheme Struct

```swift
public struct ChessboardTheme: Sendable {
    public let colorScheme: ChessboardColorScheme
    public let pieceStyle: PieceStyle
    
    public init(colorScheme: ChessboardColorScheme, pieceStyle: PieceStyle)
}
```

### ChessboardModel API

```swift
// Initialization
public init(fen: String = EMPTY_FEN,
            perspective: PieceColor = .white,
            colorScheme: ChessboardColorScheme = .light,
            allowOpponentMove: Bool = false,
            pieceStyle: PieceStyle = .uscf)

public init(fen: String = EMPTY_FEN,
            perspective: PieceColor = .white,
            theme: ChessboardTheme,
            allowOpponentMove: Bool = false)

// Dynamic changes
public func setTheme(_ theme: ChessboardTheme)
public func setColorScheme(_ colorScheme: ChessboardColorScheme)
public func setPieceStyle(_ pieceStyle: PieceStyle)
```

## Migration Guide

If you're upgrading from a previous version:

1. **No breaking changes**: All existing code continues to work
2. **New parameter**: You can now optionally specify `pieceStyle` in the initializer
3. **Enhanced functionality**: Use the new theme system for more sophisticated theming

### Before
```swift
let model = ChessboardModel(colorScheme: .dark)
```

### After (both approaches work)
```swift
// Approach 1: Individual parameters
let model = ChessboardModel(
    colorScheme: .dark,
    pieceStyle: .wood
)

// Approach 2: Theme-based
let model = ChessboardModel(
    theme: ChessboardThemes.modernBlue
)
```

## Adding New Piece Styles

To add a new piece style:

1. Add a new case to the `PieceStyle` enum
2. Create the corresponding asset folder structure
3. Add the piece images (wK.png, wQ.png, etc.) to the new folder
4. Update Package.swift to include the new assets
5. Optionally create a preset theme in `ChessboardThemes`

**Note**: Currently, only the `uscf` style has actual assets. Other styles (`classic`, `modern`, `wood`, `marble`) are available in the enum but will fall back to text representation if their corresponding asset folders don't exist.

```swift
// Example of adding a new style
public enum PieceStyle: String, CaseIterable, Sendable {
    case uscf = "uscf"
    case classic = "classic"
    case modern = "modern"
    case wood = "wood"
    case marble = "marble"
    case medieval = "medieval"  // New style
}
```

### Asset Requirements

For each piece style, you need 12 PNG files in the format:
- White pieces: `wK.png`, `wQ.png`, `wR.png`, `wB.png`, `wN.png`, `wP.png`
- Black pieces: `bK.png`, `bQ.png`, `bR.png`, `bB.png`, `bN.png`, `bP.png`

Place these in: `Sources/ChessboardKit/Assets/Pieces/{style_name}/`

### Package.swift Update

When adding new piece styles with assets, update Package.swift:

```swift
resources: [
    .process("Assets/Pieces/uscf"),
    .process("Assets/Pieces/classic"),  // Add new styles here
    .process("Assets/Pieces/modern"),
    // ... etc
]
```