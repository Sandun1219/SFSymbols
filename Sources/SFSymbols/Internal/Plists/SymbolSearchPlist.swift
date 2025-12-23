import Foundation

struct SymbolSearchPlist: Decodable {
    let symbols: [String: [String]]

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        symbols = try container.decode([String: [String]].self)
    }

    static func load(from bundle: Bundle) throws(CoreGlyphsPlistFileReader.ReadError) -> Self {
        try CoreGlyphsPlistFileReader.readFile(named: "symbol_search", in: bundle, decoding: Self.self)
    }
}

extension SymbolSearchPlist: CustomDebugStringConvertible {
    var debugDescription: String {
        let symbolsPrefix = symbols.keys.prefix(10).joined(separator: ", ")
        return "[SymbolSearchPlist \(symbols.count) symbols: \(symbolsPrefix), ...]"
    }
}
