import SwiftUI

struct ChapterListView: View {
    var body: some View {
        NavigationStack {
            List(ContentStore.chapters) { chapter in
                NavigationLink(chapter.title) {
                    ChapterDetailView(chapter: chapter)
                }
            }
            .navigationTitle("Feng Shui")
        }
    }
}

struct ChapterDetailView: View {
    let chapter: Chapter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(blocks.enumerated()), id: \.offset) { _, block in
                    render(block)
                }
            }
            .padding()
        }
        .navigationTitle(chapter.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var blocks: [String] {
        chapter.body
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    @ViewBuilder
    private func render(_ block: String) -> some View {
        if block.hasPrefix("## ") {
            Text(markdown(String(block.dropFirst(3))))
                .font(.title3.bold())
                .padding(.top, 8)
        } else if block.hasPrefix("### ") {
            Text(markdown(String(block.dropFirst(4))))
                .font(.headline)
        } else {
            Text(markdown(block))
                .font(.body)
        }
    }

    private func markdown(_ s: String) -> AttributedString {
        (try? AttributedString(markdown: s)) ?? AttributedString(s)
    }
}
