import SwiftUI

struct MatrixRainView: View {

    private let columnWidth: CGFloat = 18
    private let fontSize: CGFloat = 16

    @State private var columns: [RainColumn] = []
    @State private var lastSize: CGSize = .zero

    var body: some View {
        GeometryReader { geomet/Users/crop-off-drone/Projects/matrixUI/matrixUI/ContentView.swift
            /Users/crop-off-drone/Projects/matrixUI/matrixUI/MatrixRainLinksApp.swift
            /Users/crop-off-drone/Projects/matrixUI/matrixUI/MatrixRainView.swiftry in
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    draw(context: context, size: size, date: timeline.date)
                }
            }
            .background(Color.black)
            .onAppear {
                setupColumns(for: geometry.size)
            }
            .onChange(of: geometry.size) { newSize in
                guard newSize != lastSize else { return }
                lastSize = newSize
                setupColumns(for: newSize)
            }
        }
        .ignoresSafeArea()
    }

    private func setupColumns(for size: CGSize) {
        guard size.width > 0, size.height > 0 else { return }
        let columnCount = max(1, Int(size.width / columnWidth))
        columns = (0..<columnCount).map { i in
            RainColumn(x: CGFloat(i) * columnWidth + CGFloat.random(in: -3...3),
                       size: size,
                       fontSize: fontSize)
        }
    }

    private func draw(context: GraphicsContext, size: CGSize, date: Date) {
        context.fill(Path(CGRect(origin: .zero, size: size)),
                      with: .color(.black.opacity(0.15)))

        for column in columns {
            column.advance(size: size, fontSize: fontSize)
            column.draw(in: context, fontSize: fontSize)
        }
    }
}

private final class RainColumn {
    let x: CGFloat
    private var glyphs: [Character]
    private var headY: CGFloat
    private var speed: CGFloat

    init(x: CGFloat, size: CGSize, fontSize: CGFloat) {
        self.x = x
        let glyphCount = Int(size.height / fontSize) + 6
        glyphs = (0..<glyphCount).map { _ in Bool.random() ? "1" : "0" }
        headY = CGFloat.random(in: -size.height...0)
        speed = CGFloat.random(in: 4...12)
    }

    func advance(size: CGSize, fontSize: CGFloat) {
        headY += speed
        let streamHeight = CGFloat(glyphs.count) * fontSize
        if headY > size.height + streamHeight {
            headY = -CGFloat.random(in: 0...size.height)
            speed = CGFloat.random(in: 4...12)
        }
        if Int.random(in: 0..<20) == 0, let idx = glyphs.indices.randomElement() {
            glyphs[idx] = Bool.random() ? "1" : "0"
        }
    }

    func draw(in context: GraphicsContext, fontSize: CGFloat) {
        for (index, glyph) in glyphs.enumerated() {
            let y = headY - CGFloat(index) * fontSize
            guard y > -fontSize, y < headY + fontSize else { continue }

            let isHead = index == 0
            let fade = max(0, 1 - Double(index) / Double(glyphs.count))
            let color: Color = isHead ? .white : Color.green.opacity(fade)

            let text = Text(String(glyph))
                .font(.system(size: fontSize, weight: .medium, design: .monospaced))
                .foregroundColor(color)

            context.draw(context.resolve(text), at: CGPoint(x: x, y: y), anchor: .top)
        }
    }
}

struct MatrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixRainView()
    }
}
