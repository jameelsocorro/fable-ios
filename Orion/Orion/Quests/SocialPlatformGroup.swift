nonisolated enum SocialPlatformGroup: String, CaseIterable, Identifiable {
    case recommended
    case more

    var id: String { rawValue }

    var title: String {
        switch self {
        case .recommended:
            "Recommended for founders"
        case .more:
            "More platforms"
        }
    }
}
