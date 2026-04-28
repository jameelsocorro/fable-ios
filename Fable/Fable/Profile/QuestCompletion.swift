import Foundation
import SwiftData

@Model
final class QuestCompletion {
    var id: UUID
    var questID: String
    var platformID: String
    var completedAt: Date
    var completionKindRawValue: String

    init(
        id: UUID = UUID(),
        questID: String,
        platform: SocialPlatform,
        completedAt: Date = .now,
        completionKind: QuestCompletionKind = .commitment
    ) {
        self.id = id
        self.questID = questID
        self.platformID = platform.id
        self.completedAt = completedAt
        self.completionKindRawValue = completionKind.rawValue
    }

    var platform: SocialPlatform? {
        SocialPlatform(id: platformID)
    }

    var completionKind: QuestCompletionKind {
        QuestCompletionKind(rawValue: completionKindRawValue) ?? .commitment
    }
}
