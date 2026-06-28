import Foundation
import SwiftUI

struct WordItem: Identifiable, Hashable {
    let id: String
    let english: String
    let translation: String
    let pronunciation: String
    let example: String
    let topic: WordTopic
}

enum WordTopic: String, CaseIterable, Identifiable {
    case basics = "База"
    case travel = "Путешествия"
    case food = "Еда"
    case work = "Работа"
    case home = "Дом"
    case city = "Город"
    case health = "Здоровье"
    case emotions = "Эмоции"
    case nature = "Природа"
    case technology = "Технологии"
    case study = "Учеба"
    case business = "Бизнес"
    case shopping = "Покупки"
    case sport = "Спорт"
    case art = "Искусство"
    case phrasal = "Фразовые"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .basics: "star.fill"
        case .travel: "airplane"
        case .food: "fork.knife"
        case .work: "briefcase.fill"
        case .home: "house.fill"
        case .city: "building.2.fill"
        case .health: "cross.case.fill"
        case .emotions: "heart.fill"
        case .nature: "leaf.fill"
        case .technology: "cpu.fill"
        case .study: "book.fill"
        case .business: "chart.line.uptrend.xyaxis"
        case .shopping: "bag.fill"
        case .sport: "figure.run"
        case .art: "paintpalette.fill"
        case .phrasal: "quote.bubble.fill"
        }
    }

    var tint: Color {
        switch self {
        case .basics: .indigo
        case .travel: .cyan
        case .food: .orange
        case .work: .blue
        case .home: .mint
        case .city: .teal
        case .health: .red
        case .emotions: .pink
        case .nature: .green
        case .technology: .purple
        case .study: .brown
        case .business: .yellow
        case .shopping: .pink
        case .sport: .green
        case .art: .secondary
        case .phrasal: .primary
        }
    }
}
