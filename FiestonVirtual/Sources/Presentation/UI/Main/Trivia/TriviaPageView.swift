import SwiftUI

struct TriviaPageView: View {

    private let questionDuration = 45

    @State var trivia: Trivia
    let questionNumber: Int
    let totalQuestions: Int
    var onAlternativeSelected: (_ alternative: Alternative) -> Void

    @State private var selectedAlternativeID: Int?
    @State private var remainingSeconds = 45
    @State private var showTimeExpiredAlert = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer(minLength: max(42, geometry.size.height * 0.18))

                HStack {
                    TriviaQuestionBadge(
                        text: String(
                            format: NSLocalizedString("trivia.question_progress", comment: ""),
                            questionNumber,
                            totalQuestions
                        ),
                        color: Color.triviaTurquoise
                    )

                    Spacer()

                    TriviaQuestionBadge(
                        text: String(
                            format: NSLocalizedString("trivia.time_remaining", comment: ""),
                            remainingSeconds
                        ),
                        color: Color.triviaYellow,
                        icon: "timer"
                    )
                }
                .padding(.horizontal, 24)

                GeometryReader { progressGeometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.14))

                        Capsule()
                            .fill(Color.triviaTurquoise)
                            .frame(
                                width: progressGeometry.size.width
                                    * CGFloat(remainingSeconds) / CGFloat(questionDuration)
                            )
                    }
                }
                .frame(height: 5)
                .padding(.horizontal, 16)
                .padding(.top, 16)

                Text(trivia.question)
                    .font(.system(size: 27, weight: .black, design: .rounded))
                    .foregroundColor(Color.triviaQuestionText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 24)
                    .padding(.top, 32)

                VStack(spacing: 11) {
                    ForEach(Array(trivia.questionAlternative.enumerated()), id: \.element.id) { index, alternative in
                        TriviaAlternativeButton(
                            letter: String(UnicodeScalar(65 + index)!),
                            alternative: alternative,
                            isSelected: selectedAlternativeID == alternative.alternativeId,
                            isDisabled: remainingSeconds == 0
                        ) {
                            guard remainingSeconds > 0 else { return }
                            selectedAlternativeID = alternative.alternativeId
                            onAlternativeSelected(alternative)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 48)

                Spacer()
            }
        }
        .onChange(of: trivia.questionId) { _ in
            selectedAlternativeID = nil
            remainingSeconds = questionDuration
            showTimeExpiredAlert = false
        }
        .onReceive(timer) { _ in
            guard remainingSeconds > 0 else { return }
            remainingSeconds -= 1
            if remainingSeconds == 0 {
                showTimeExpiredAlert = true
            }
        }
        .alert(
            "trivia.time_expired_title",
            isPresented: $showTimeExpiredAlert
        ) {
            Button("common.accept", role: .cancel) { }
        } message: {
            Text("trivia.time_expired_message")
        }
    }
}

private struct TriviaQuestionBadge: View {

    let text: String
    let color: Color
    var icon: String?

    var body: some View {
        HStack(spacing: 7) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .bold))
            } else {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
            }

            Text(text)
                .font(.system(size: 12, weight: .bold, design: .rounded))
        }
        .foregroundColor(color)
        .padding(.horizontal, 12)
        .frame(height: 27)
        .background(
            Capsule()
                .fill(color.opacity(0.08))
                .overlay(
                    Capsule()
                        .stroke(color.opacity(0.5), lineWidth: 1)
                )
        )
    }
}

private struct TriviaAlternativeButton: View {

    let letter: String
    let alternative: Alternative
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text(letter)
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .foregroundColor(isSelected ? Color.triviaSelectedText : Color.triviaMutedText)
                    .frame(width: 43, height: 43)
                    .background(
                        RoundedRectangle(cornerRadius: 11)
                            .fill(isSelected ? Color.triviaTurquoise : Color.triviaOptionBackground)
                    )

                Text(alternative.alternativeDescription)
                    .font(.system(size: 21, weight: .bold, design: .rounded))
                    .foregroundColor(Color.triviaAnswerText)

                Spacer()

                ZStack {
                    Circle()
                        .stroke(isSelected ? Color.triviaTurquoise : Color.white.opacity(0.25), lineWidth: 1)
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Circle()
                            .fill(Color.triviaTurquoise)
                            .frame(width: 24, height: 24)

                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .black))
                            .foregroundColor(Color.triviaSelectedText)
                    }
                }
            }
            .padding(.horizontal, 17)
            .frame(maxWidth: .infinity)
            .frame(height: 78)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.triviaCardBackground.opacity(0.92))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(
                                isSelected ? Color.triviaTurquoise : Color.white.opacity(0.15),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
                    .shadow(
                        color: isSelected ? Color.triviaTurquoise.opacity(0.35) : .clear,
                        radius: 12
                    )
            )
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled && !isSelected ? 0.72 : 1)
    }
}

struct TriviaPageView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaPageView(
            trivia: Trivia(
                questionId: 155,
                questionType: "Adivinanza",
                questionName: "204",
                question: "¿En qué año se fundó nuestra empresa?",
                questionScore: 5,
                questionImageUrl: "",
                questionStatus: 1,
                questionAlternative: [
                    Alternative(alternativeId: 1, alternativeDescription: "1998", isAlternativeAnswer: false),
                    Alternative(alternativeId: 2, alternativeDescription: "2001", isAlternativeAnswer: true),
                    Alternative(alternativeId: 3, alternativeDescription: "2010", isAlternativeAnswer: false)
                ]
            ),
            questionNumber: 2,
            totalQuestions: 5
        ) { _ in }
        .preferredColorScheme(.dark)
    }
}
