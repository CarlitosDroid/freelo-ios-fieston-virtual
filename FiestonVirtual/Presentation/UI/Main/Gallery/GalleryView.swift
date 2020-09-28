
import SwiftUI
import Grid
import GridStack
import KingfisherSwiftUI

struct GalleryView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!
    
    @State private var scrollViewID = UUID()
    @State private var showGalleryDetail = false
    @State private var onlyFirstTime = true
    
    var body: some View {
        
        ZStack{
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            LoadingView(isShowing: self.$viewModel.isLoading) {
                GridStack(minCellWidth: 110, spacing: 5, numItems: viewModel.galleryItems.count) { index, cellWidth in
                    NavigationLink(destination: GalleryDetailView(galleryItem: viewModel.galleryItems[index])) {
                        GalleryItemView(galleryItem: viewModel.galleryItems[index], cellWidth: cellWidth)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .onAppear {
                scrollViewID = UUID()
                if(onlyFirstTime) {
                    viewModel.getGallery()
                    onlyFirstTime = false
                }
                
            }
        }
        
    }
    
    struct GalleryView_Previews: PreviewProvider {
        static var previews: some View {
            GalleryView()
        }
    }
    
    
    struct GridCell: View {
        var person: GalleryItem
        
        var body: some View {
            VStack() {
                Image(person.file)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(color: .primary, radius: 5)
                    .padding([.horizontal, .top], 7)
                Text(person.preview).lineLimit(1)
                Text(person.preview).lineLimit(1)
            }
        }
    }
}
