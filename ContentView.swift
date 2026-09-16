import SwiftUI

struct ProjectLink: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let url: URL
}

struct ContentView: View {

    private let links: [ProjectLink] = [
        ProjectLink(
            title: "GitHub Repository",
            subtitle: "techplanshetyapps/image-processing-matlab",
            url: URL(string: "https://github.com/techplanshetyapps/image-processing-matlab")!
        ),
        ProjectLink(
            title: "Project Abstract",
            subtitle: "Project_Abstract.pdf",
            url: URL(string: "https://github.com/techplanshetyapps/admin-matrix-dashboard/blob/main/Project_Abstract.pdf")!
        ),
        ProjectLink(
            title: "MATLAB Project",
            subtitle: "BostonImageContrastEnhancement.mlprj",
            url: URL(string: "https://github.com/techplanshetyapps/admin-matrix-dashboard/blob/main/BostonImageContrastEnhancement.mlprj")!
        ),
        ProjectLink(
            title: "Project Documentation",
            subtitle: "Project_Documentation.pdf",
            url: URL(string: "https://github.com/techplanshetyapps/admin-matrix-dashboard/blob/main/Project_Documentation.pdf")!
        )
    ]

    var body: some View {
        ZStack {
            MatrixRainView()

            VStack {
                Spacer()
                linksCard
            }
        }
    }

    private var linksCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("PROJECT LINKS")
                .font(.system(.headline, design: .monospaced))
                .foregroundColor(.green)
                .padding(.bottom, 2)

            ForEach(links) { link in
                Link(destination: link.url) {
                    HStack(spacing: 10) {
                        Image(systemName: "chevron.right.circle.fill")
                            .foregroundColor(.green)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(link.title)
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.white)
                            Text(link.subtitle)
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.green.opacity(0.8))
                                .lineLimit(1)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(18)
        .background(Color.black.opacity(0.65))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.green.opacity(0.6), lineWidth: 1)
        )
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
