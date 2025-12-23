import Foundation

struct SymbolCategoriesPlist: Decodable {
    let symbols: [String: [String]]

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        symbols = try container.decode([String: [String]].self)
    }

    static func load(from bundle: Bundle) throws(CoreGlyphsPlistFileReader.ReadError) -> Self {
        try CoreGlyphsPlistFileReader.readFile(named: "symbol_categories", in: bundle, decoding: Self.self)
    }
}

extension SymbolCategoriesPlist: CustomDebugStringConvertible {
    var debugDescription: String {
        let symbolsPrefix = symbols.keys.prefix(10).joined(separator: ", ")
        return "[SymbolCategoriesPlist \(symbols.count) symbols: \(symbolsPrefix), ...]"
    }
}
