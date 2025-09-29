import SwiftUI
import ChessboardKit

struct ThemeUsageExample: View {
    @State private var chessboardModel = ChessboardModel(
        fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
        perspective: .white,
        theme: ChessboardThemes.defaultLight
    )
    
    var body: some View {
        VStack {
            // Display the chessboard
            Chessboard(chessboardModel: chessboardModel)
                .frame(maxWidth: 400, maxHeight: 400)
            
            // Theme selection controls
            VStack(spacing: 20) {
                Text("Board Color Schemes")
                    .font(.headline)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                    ThemeButton(title: "Light", colorScheme: .light, chessboardModel: chessboardModel)
                    ThemeButton(title: "Dark", colorScheme: .dark, chessboardModel: chessboardModel)
                    ThemeButton(title: "Orange", colorScheme: .orange, chessboardModel: chessboardModel)
                    ThemeButton(title: "Blue", colorScheme: .blue, chessboardModel: chessboardModel)
                    ThemeButton(title: "Green", colorScheme: .green, chessboardModel: chessboardModel)
                    ThemeButton(title: "Red", colorScheme: .red, chessboardModel: chessboardModel)
                    ThemeButton(title: "Yellow", colorScheme: .yellow, chessboardModel: chessboardModel)
                    ThemeButton(title: "Purple", colorScheme: .purple, chessboardModel: chessboardModel)
                }
                
                Text("Piece Styles")
                    .font(.headline)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                    ForEach(PieceStyle.allCases, id: \.self) { style in
                        PieceStyleButton(style: style, chessboardModel: chessboardModel)
                    }
                }
                
                Text("Preset Themes")
                    .font(.headline)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                    PresetThemeButton(title: "Default Light", theme: ChessboardThemes.defaultLight, chessboardModel: chessboardModel)
                    PresetThemeButton(title: "Default Dark", theme: ChessboardThemes.defaultDark, chessboardModel: chessboardModel)
                    PresetThemeButton(title: "Classic Wood", theme: ChessboardThemes.classicWood, chessboardModel: chessboardModel)
                    PresetThemeButton(title: "Modern Blue", theme: ChessboardThemes.modernBlue, chessboardModel: chessboardModel)
                    PresetThemeButton(title: "Elegant Marble", theme: ChessboardThemes.elegantMarble, chessboardModel: chessboardModel)
                }
            }
            .padding()
        }
    }
}

struct ThemeButton: View {
    let title: String
    let colorScheme: ChessboardColorScheme
    let chessboardModel: ChessboardModel
    
    var body: some View {
        Button(title) {
            chessboardModel.setColorScheme(colorScheme)
        }
        .buttonStyle(.bordered)
    }
}

struct PieceStyleButton: View {
    let style: PieceStyle
    let chessboardModel: ChessboardModel
    
    var body: some View {
        Button(style.displayName) {
            chessboardModel.setPieceStyle(style)
        }
        .buttonStyle(.bordered)
    }
}

struct PresetThemeButton: View {
    let title: String
    let theme: ChessboardTheme
    let chessboardModel: ChessboardModel
    
    var body: some View {
        Button(title) {
            chessboardModel.setTheme(theme)
        }
        .buttonStyle(.borderedProminent)
    }
}

// Example of programmatic usage
class ChessboardThemeManager {
    private var chessboardModel: ChessboardModel
    
    init(chessboardModel: ChessboardModel) {
        self.chessboardModel = chessboardModel
    }
    
    // Individual property changes
    func changeToDarkMode() {
        chessboardModel.setColorScheme(.dark)
    }
    
    func changeToUSCFPieces() {
        chessboardModel.setPieceStyle(.uscf)
    }
    
    func changeToWoodPieces() {
        chessboardModel.setPieceStyle(.wood)
    }
    
    // Complete theme changes
    func applyModernTheme() {
        chessboardModel.setTheme(ChessboardThemes.modernBlue)
    }
    
    func applyClassicTheme() {
        chessboardModel.setTheme(ChessboardThemes.classicWood)
    }
    
    // Custom theme creation
    func applyCustomTheme() {
        let customTheme = ChessboardTheme(
            colorScheme: .green,
            pieceStyle: .marble
        )
        chessboardModel.setTheme(customTheme)
    }
}

// Example of different initialization approaches
struct InitializationExamples {
    
    // Method 1: Individual parameters (as requested by user)
    func createWithIndividualParameters() -> ChessboardModel {
        return ChessboardModel(
            fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
            perspective: .white,
            colorScheme: .dark,
            allowOpponentMove: false,
            pieceStyle: .wood  // This is what the user requested
        )
    }
    
    // Method 2: Using preset themes
    func createWithPresetTheme() -> ChessboardModel {
        return ChessboardModel(
            fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
            perspective: .white,
            theme: ChessboardThemes.modernBlue
        )
    }
    
    // Method 3: Using custom theme
    func createWithCustomTheme() -> ChessboardModel {
        let customTheme = ChessboardTheme(
            colorScheme: .purple,
            pieceStyle: .marble
        )
        
        return ChessboardModel(
            fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
            perspective: .white,
            theme: customTheme
        )
    }
}

#Preview {
    ThemeUsageExample()
}