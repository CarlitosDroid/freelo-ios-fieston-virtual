
import SwiftUI
import Grid

struct GalleryView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!
    
    var onGalleryItemSelected: (_ galleryItem: GalleryItem) -> Void
    
    @State private var scrollViewID = UUID()
    @State private var showGalleryDetail = false
    
    var body: some View {
        
        ZStack{
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            LoadingView(isShowing: self.$viewModel.isLoading) {
                ScrollView {
                    Grid(viewModel.galleryItems) { galleryItem in
                        NavigationLink(destination: GalleryDetailView(galleryItem: galleryItem)) {
                            GalleryItemView(galleryItem: galleryItem)
                        }
                    }
                    .gridStyle(
                        ModularGridStyle(columns: 3, rows: .fixed(130))
                    )
                    
                }
                .id(self.scrollViewID)
                .padding(8)
            }
        }
        .onAppear {
            scrollViewID = UUID()
            viewModel.getGallery()
        }
    }
    
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(){
            (galleryItem: GalleryItem) in
            
        }
    }
}
