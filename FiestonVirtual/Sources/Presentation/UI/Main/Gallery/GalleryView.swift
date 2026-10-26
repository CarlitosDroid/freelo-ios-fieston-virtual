import SwiftUI

struct GalleryView: View {

    @EnvironmentObject var settings: UserSettings
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!

    @Binding var notifyGalleryFromMain: Bool

    @State var galleryItems: [GalleryItem] = []
    @State private var selectedFilter: GalleryFilter = .all

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.loginGradientStart,
                    Color.loginGradientMiddle,
                    Color.loginGradientEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(GalleryFilter.allCases) { filter in
                            Button(action: {
                                selectedFilter = filter
                            }) {
                                Label(filter.title, systemImage: filter.iconName)
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(selectedFilter == filter
                                        ? Color(hex: "101218")
                                        : Color.loginMutedText)
                                    .padding(.horizontal, 24)
                                    .frame(height: 42)
                                    .background(
                                        selectedFilter == filter
                                            ? Color(hex: "36FFC4")
                                            : Color(hex: "171521")
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(
                                                selectedFilter == filter
                                                    ? Color(hex: "36FFC4")
                                                    : Color.loginCardBorder,
                                                lineWidth: 1
                                            )
                                    )
                                    .clipShape(Capsule())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                }

                if filteredItems.isEmpty {
                    Text(
                        NSLocalizedString(
                            galleryItems.isEmpty ? "gallery.loading" : "gallery.empty",
                            comment: "Gallery empty state"
                        )
                    )
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color.loginMutedText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView(showsIndicators: false) {
                        GeometryReader { proxy in
                            HStack(alignment: .top, spacing: 16) {
                                galleryColumn(
                                    items: leftColumnItems,
                                    width: (proxy.size.width - 16) / 2
                                )
                                galleryColumn(
                                    items: rightColumnItems,
                                    width: (proxy.size.width - 16) / 2
                                )
                            }
                        }
                        .frame(height: galleryContentHeight)
                        .padding(.horizontal, 20)
                        .padding(.top, 2)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .onAppear {
            if settings.refreshGallery {
                viewModel.getGallery()
                settings.refreshGallery = false
            }
            if notifyGalleryFromMain {
                viewModel.getGallery()
                notifyGalleryFromMain = false
            }
        }
        .onReceive(viewModel.$galleryItems, perform: { nullGalleryItems in
            guard let nonNullGalleryItems = nullGalleryItems else { return }
            galleryItems = nonNullGalleryItems
        })
        .alert(isPresented: $viewModel.showErrorMessage, content: {
            Alert(
                title: Text(viewModel.errorMessage),
                dismissButton: .default(
                    Text(NSLocalizedString("common.accept", comment: "Accept button"))
                )
            )
        })
    }

    private var filteredItems: [GalleryItem] {
        switch selectedFilter {
        case .all:
            return galleryItems
        case .photos:
            return galleryItems.filter { $0.type == GalleryItemType.photo.rawValue }
        case .videos:
            return galleryItems.filter { $0.type == GalleryItemType.video.rawValue }
        }
    }

    private var leftColumnItems: [GalleryItem] {
        filteredItems.enumerated().compactMap { index, item in
            index.isMultiple(of: 2) ? item : nil
        }
    }

    private var rightColumnItems: [GalleryItem] {
        filteredItems.enumerated().compactMap { index, item in
            index.isMultiple(of: 2) ? nil : item
        }
    }

    @ViewBuilder
    private func galleryColumn(items: [GalleryItem], width: CGFloat) -> some View {
        LazyVStack(spacing: 24) {
            ForEach(items) { item in
                NavigationLink(destination: GalleryDetailView(galleryItem: item)) {
                    GalleryItemView(galleryItem: item)
                }
                .buttonStyle(.plain)
                .padding(4)
                .background(Color.black.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .frame(width: width)
    }

    private var galleryContentHeight: CGFloat {
        let rows = max(leftColumnItems.count, rightColumnItems.count)
        let cardHeight: CGFloat = 170
        let videoExtraHeight: CGFloat = 50
        let height = CGFloat(rows) * cardHeight + CGFloat(max(rows - 1, 0)) * 24
        let videoCount = filteredItems.filter { $0.type == GalleryItemType.video.rawValue }.count
        return height + CGFloat(videoCount) * videoExtraHeight
    }
}

private enum GalleryFilter: String, CaseIterable, Identifiable {
    case all
    case photos
    case videos

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all:
            return NSLocalizedString("gallery.filter.all", comment: "All gallery media filter")
        case .photos:
            return NSLocalizedString("gallery.filter.photos", comment: "Gallery photos filter")
        case .videos:
            return NSLocalizedString("gallery.filter.videos", comment: "Gallery videos filter")
        }
    }

    var iconName: String {
        switch self {
        case .all:
            return "photo.on.rectangle.angled"
        case .photos:
            return "photo"
        case .videos:
            return "video"
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(notifyGalleryFromMain: .constant(false))
    }
}
