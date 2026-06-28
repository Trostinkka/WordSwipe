import SwiftUI

struct ContentView: View {
    @StateObject private var store = LearningStore()
    @StateObject private var speech = SpeechService()
    @State private var showingReviewOnly = false
    @State private var currentIndex = 0
    @State private var dragOffset: CGSize = .zero
    @State private var showResetConfirmation = false

    private var deck: [WordItem] {
        let words = showingReviewOnly ? store.reviewWords : WordBank.words(for: store.selectedTopic)
        return words.sorted { first, second in
            if store.isInReview(first) != store.isInReview(second) {
                return store.isInReview(first)
            }
            return first.english < second.english
        }
    }

    private var currentWord: WordItem? {
        guard !deck.isEmpty else { return nil }
        return deck[min(currentIndex, deck.count - 1)]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    summaryBar
                    modePicker
                    topicScroller
                    cardStage
                    actionBar
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 14)
            }
            .navigationTitle("WordSwipe")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showResetConfirmation = true
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .accessibilityLabel("Сбросить прогресс")
                }
            }
            .confirmationDialog("Сбросить прогресс?", isPresented: $showResetConfirmation) {
                Button("Сбросить", role: .destructive) {
                    store.resetProgress()
                    currentIndex = 0
                }
                Button("Отмена", role: .cancel) {}
            }
            .onChange(of: store.selectedTopic) { _, _ in
                currentIndex = 0
            }
            .onChange(of: showingReviewOnly) { _, _ in
                currentIndex = 0
            }
        }
    }

    private var summaryBar: some View {
        HStack(spacing: 10) {
            StatPill(symbol: "checkmark.circle.fill", title: "Знаю", value: "\(store.knownCount)", tint: .green)
            StatPill(symbol: "clock.arrow.circlepath", title: "Повтор", value: "\(store.reviewCount)", tint: .orange)
            StatPill(symbol: "square.stack.3d.up.fill", title: "Всего", value: "\(WordBank.allWords.count)", tint: .blue)
        }
    }

    private var modePicker: some View {
        Picker("Режим", selection: $showingReviewOnly) {
            Label("Учить", systemImage: "sparkles").tag(false)
            Label("Повтор", systemImage: "clock.arrow.circlepath").tag(true)
        }
        .pickerStyle(.segmented)
    }

    private var topicScroller: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                TopicButton(
                    title: "Все",
                    symbol: "rectangle.grid.2x2.fill",
                    isSelected: store.selectedTopic == nil,
                    tint: .blue
                ) {
                    store.selectedTopic = nil
                }

                ForEach(WordTopic.allCases) { topic in
                    TopicButton(
                        title: topic.rawValue,
                        symbol: topic.symbol,
                        isSelected: store.selectedTopic == topic,
                        tint: topic.tint
                    ) {
                        store.selectedTopic = topic
                    }
                }
            }
            .padding(.vertical, 2)
        }
        .disabled(showingReviewOnly)
        .opacity(showingReviewOnly ? 0.45 : 1)
    }

    @ViewBuilder
    private var cardStage: some View {
        if let word = currentWord {
            VStack(spacing: 12) {
                ZStack {
                    WordCardView(
                        word: word,
                        isKnown: store.isKnown(word),
                        isInReview: store.isInReview(word),
                        isSpeaking: speech.speakingWordID == word.id,
                        offset: dragOffset,
                        onSpeak: { speech.speak(word) }
                    )
                    .offset(x: dragOffset.width, y: dragOffset.height * 0.2)
                    .rotationEffect(.degrees(dragOffset.width / 18))
                    .gesture(cardDrag(for: word))
                    .animation(.spring(response: 0.34, dampingFraction: 0.82), value: dragOffset)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 430)

                Text("\(min(currentIndex + 1, deck.count)) из \(deck.count)")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        } else {
            EmptyDeckView(showingReviewOnly: showingReviewOnly)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var actionBar: some View {
        HStack(spacing: 18) {
            RoundActionButton(symbol: "xmark", tint: .orange) {
                guard let currentWord else { return }
                move(word: currentWord, direction: .left)
            }
            .accessibilityLabel("Не знаю")

            RoundActionButton(symbol: "speaker.wave.2.fill", tint: .blue) {
                guard let currentWord else { return }
                speech.speak(currentWord)
            }
            .accessibilityLabel("Произнести")

            RoundActionButton(symbol: "checkmark", tint: .green) {
                guard let currentWord else { return }
                move(word: currentWord, direction: .right)
            }
            .accessibilityLabel("Знаю")
        }
        .disabled(currentWord == nil)
        .opacity(currentWord == nil ? 0.35 : 1)
    }

    private func cardDrag(for word: WordItem) -> some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation
            }
            .onEnded { value in
                if value.translation.width < -110 {
                    move(word: word, direction: .left)
                } else if value.translation.width > 110 {
                    move(word: word, direction: .right)
                } else {
                    dragOffset = .zero
                }
            }
    }

    private func move(word: WordItem, direction: SwipeDirection) {
        switch direction {
        case .left:
            store.markForReview(word)
            dragOffset = CGSize(width: -600, height: 20)
        case .right:
            store.markKnown(word)
            dragOffset = CGSize(width: 600, height: 20)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            dragOffset = .zero
            if currentIndex < max(deck.count - 1, 0) {
                currentIndex += 1
            } else {
                currentIndex = 0
            }
        }
    }
}

private enum SwipeDirection {
    case left
    case right
}

private struct WordCardView: View {
    let word: WordItem
    let isKnown: Bool
    let isInReview: Bool
    let isSpeaking: Bool
    let offset: CGSize
    let onSpeak: () -> Void

    private var swipeBadge: (String, Color)? {
        if offset.width > 45 {
            return ("ЗНАЮ", .green)
        }
        if offset.width < -45 {
            return ("ПОВТОР", .orange)
        }
        return nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack {
                Label(word.topic.rawValue, systemImage: word.topic.symbol)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(word.topic.tint)

                Spacer()

                if isKnown {
                    StatusBadge(title: "Выучено", tint: .green)
                } else if isInReview {
                    StatusBadge(title: "Повтор", tint: .orange)
                }
            }

            Spacer(minLength: 0)

            VStack(alignment: .leading, spacing: 10) {
                Text(word.english)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .minimumScaleFactor(0.55)
                    .lineLimit(2)

                HStack(spacing: 10) {
                    Text(word.pronunciation)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Button(action: onSpeak) {
                        Image(systemName: isSpeaking ? "speaker.wave.3.fill" : "speaker.wave.2.fill")
                            .font(.title3.weight(.bold))
                            .frame(width: 42, height: 42)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .clipShape(Circle())
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(word.translation)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .minimumScaleFactor(0.7)

                Text(word.example)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)

            HStack {
                Label("Влево: повторить", systemImage: "arrow.left")
                    .foregroundStyle(.orange)
                Spacer()
                Label("Вправо: знаю", systemImage: "arrow.right")
                    .foregroundStyle(.green)
            }
            .font(.caption.weight(.bold))
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 24, y: 12)
        .overlay(alignment: offset.width < 0 ? .topTrailing : .topLeading) {
            if let swipeBadge {
                Text(swipeBadge.0)
                    .font(.title2.weight(.black))
                    .foregroundStyle(swipeBadge.1)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(swipeBadge.1, lineWidth: 4)
                    }
                    .rotationEffect(.degrees(offset.width < 0 ? 13 : -13))
                    .padding(28)
            }
        }
    }
}

private struct StatPill: View {
    let symbol: String
    let title: String
    let value: String
    let tint: Color

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: symbol)
                .foregroundStyle(tint)

            VStack(alignment: .leading, spacing: 1) {
                Text(value)
                    .font(.headline.weight(.bold))
                Text(title)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal, 8)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

private struct TopicButton: View {
    let title: String
    let symbol: String
    let isSelected: Bool
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: symbol)
                .font(.subheadline.weight(.bold))
                .padding(.horizontal, 12)
                .padding(.vertical, 9)
                .foregroundStyle(isSelected ? .white : .primary)
                .background(isSelected ? tint : Color(.tertiarySystemBackground))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

private struct RoundActionButton: View {
    let symbol: String
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.title2.weight(.black))
                .foregroundStyle(.white)
                .frame(width: 66, height: 66)
                .background(tint)
                .clipShape(Circle())
                .shadow(color: tint.opacity(0.35), radius: 12, y: 6)
        }
    }
}

private struct StatusBadge: View {
    let title: String
    let tint: Color

    var body: some View {
        Text(title)
            .font(.caption.weight(.black))
            .foregroundStyle(tint)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(tint.opacity(0.12))
            .clipShape(Capsule())
    }
}

private struct EmptyDeckView: View {
    let showingReviewOnly: Bool

    var body: some View {
        ContentUnavailableView {
            Label(
                showingReviewOnly ? "Повтор пуст" : "Нет слов",
                systemImage: showingReviewOnly ? "checkmark.seal.fill" : "tray.fill"
            )
        } description: {
            Text(showingReviewOnly ? "Свайпайте незнакомые слова влево, и они появятся здесь." : "Выберите другую тему.")
        }
    }
}
