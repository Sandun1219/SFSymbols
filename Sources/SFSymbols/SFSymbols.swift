import Foundation
import OSLog

public struct SFSymbols {
    public let symbols: [SFSymbol]
    public let categories: [SFSymbolCategory]

    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SFSymbols")

    public init() async throws {
        do {
            let bundle = try await CoreGlyphsBundleLoader.load()
            let categoriesPlist = try CategoriesPlist.load(from: bundle)
            let symbolOrderPlist = try SymbolOrderPlist.load(from: bundle)
            let (symbols, symbolNameMap) = try Self.symbols(in: bundle, categoriesPlist: categoriesPlist)
            let sortedSymbols = Self.sortSymbols(symbols, accordingTo: symbolOrderPlist.names)
            self.symbols = sortedSymbols
            self.categories = try Self.categories(
                categoriesPlist: categoriesPlist,
                symbols: sortedSymbols,
                symbolNameMap: symbolNameMap
            )
        } catch {
            Self.logger.error("Could not load SF Symbols: \(error, privacy: .public)")
            throw error
        }
    }
}

private extension SFSymbols {
    private static func symbols(
        in bundle: Bundle,
        categoriesPlist: CategoriesPlist
    ) throws -> ([SFSymbol], [String: SFSymbol]) {
        let nameAvailabilityPlist = try NameAvailabilityPlist.load(from: bundle)
        let symbolSearchPlist = try SymbolSearchPlist.load(from: bundle)
        let symbolCategoriesPlist = try SymbolCategoriesPlist.load(from: bundle)
        var symbols: [SFSymbol] = []
        symbols.reserveCapacity(nameAvailabilityPlist.availableSymbols.count)
        var symbolNameMap: [String: SFSymbol] = [:]
        symbolNameMap.reserveCapacity(nameAvailabilityPlist.availableSymbols.count)
        for symbol in nameAvailabilityPlist.availableSymbols {
            let searchTerms = symbolSearchPlist.symbols[symbol.name] ?? []
            let categories = symbolCategoriesPlist.symbols[symbol.name] ?? []
            let symbol = SFSymbol(
                name: symbol.name,
                searchTerms: searchTerms,
                categories: categories
            )
            symbolNameMap[symbol.name] = symbol
            symbols.append(symbol)
        }
        return (symbols, symbolNameMap)
    }

    private static func categories(
        categoriesPlist: CategoriesPlist,
        symbols: [SFSymbol],
        symbolNameMap: [String: SFSymbol]
    ) throws -> [SFSymbolCategory] {
        var categoryKeyMap: [String: [SFSymbol]] = [:]
        categoryKeyMap.reserveCapacity(categoriesPlist.categories.count)
        for category in categoriesPlist.categories {
            categoryKeyMap[category.key] = []
        }
        for symbol in symbols {
            for category in symbol.categories {
                categoryKeyMap[category, default: []].append(symbol)
            }
        }
        return categoriesPlist.categories.compactMap { category in
            guard let icon = symbolNameMap[category.icon] else {
                return nil
            }
            guard let symbolsInCategory = categoryKeyMap[category.key] else {
                return nil
            }
            guard !symbolsInCategory.isEmpty else {
                return nil
            }
            return SFSymbolCategory(key: category.key, icon: icon, symbols: symbolsInCategory)
        }
    }

    private static func sortSymbols(_ symbols: [SFSymbol], accordingTo sortedNames: [String]) -> [SFSymbol] {
        var symbolMap: [String: SFSymbol] = [:]
        symbolMap.reserveCapacity(symbols.count)
        for symbol in symbols {
            symbolMap[symbol.name] = symbol
        }
        var orderedSymbols: [SFSymbol] = []
        orderedSymbols.reserveCapacity(symbols.count)
        for name in sortedNames {
            if let symbol = symbolMap[name] {
                orderedSymbols.append(symbol)
            }
        }
        let sortedNameSet = Set(sortedNames)
        for symbol in symbols where !sortedNameSet.contains(symbol.name) {
            orderedSymbols.append(symbol)
        }
        return orderedSymbols
    }
}
