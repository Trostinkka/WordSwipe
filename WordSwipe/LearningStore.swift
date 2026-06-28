import Combine
import Foundation

@MainActor
final class LearningStore: ObservableObject {
    @Published private(set) var reviewIDs: Set<String> = []
    @Published private(set) var knownIDs: Set<String> = []
    @Published var selectedTopic: WordTopic?

    private let reviewKey = "reviewWordIDs"
    private let knownKey = "knownWordIDs"

    init() {
        reviewIDs = Self.loadSet(for: reviewKey)
        knownIDs = Self.loadSet(for: knownKey)
    }

    var reviewWords: [WordItem] {
        WordBank.allWords.filter { reviewIDs.contains($0.id) }
    }

    var knownCount: Int {
        knownIDs.count
    }

    var reviewCount: Int {
        reviewIDs.count
    }

    func markForReview(_ word: WordItem) {
        reviewIDs.insert(word.id)
        knownIDs.remove(word.id)
        save()
    }

    func markKnown(_ word: WordItem) {
        knownIDs.insert(word.id)
        reviewIDs.remove(word.id)
        save()
    }

    func removeFromReview(_ word: WordItem) {
        reviewIDs.remove(word.id)
        save()
    }

    func resetProgress() {
        reviewIDs.removeAll()
        knownIDs.removeAll()
        save()
    }

    func isInReview(_ word: WordItem) -> Bool {
        reviewIDs.contains(word.id)
    }

    func isKnown(_ word: WordItem) -> Bool {
        knownIDs.contains(word.id)
    }

    private func save() {
        Self.saveSet(reviewIDs, for: reviewKey)
        Self.saveSet(knownIDs, for: knownKey)
    }

    private static func loadSet(for key: String) -> Set<String> {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let values = try? JSONDecoder().decode([String].self, from: data)
        else {
            return []
        }

        return Set(values)
    }

    private static func saveSet(_ set: Set<String>, for key: String) {
        guard let data = try? JSONEncoder().encode(Array(set)) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
