public struct SFSymbol: Identifiable, Hashable {
    public let id: String
    public let name: String
    public let searchTerms: [String]
    public let categories: [String]

    init(name: String, searchTerms: [String], categories: [String]) {
        self.id = name
        self.name = name
        self.searchTerms = searchTerms
        self.categories = categories
    }
}
