
import SwiftUI
import Grid

struct GalleryView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!
    
    var onGalleryItemSelected: (_ galleryItem: GalleryItem) -> Void
    
    var body: some View {
        
        ZStack{
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            LoadingView(isShowing: self.$viewModel.isLoading){
                ScrollView(.vertical, showsIndicators: true) {
                    
                    Grid(viewModel.galleryItems) { galleryItem in
                        GalleryItemView(galleryItem: galleryItem){
                            (galleryItem:GalleryItem) in
                            onGalleryItemSelected(galleryItem)
                        }
                    }.gridStyle(
                        ModularGridStyle(columns: 3, rows: .fixed(130))
                    )
                    
                }
                .padding(8)
            }
            
        }
        .onAppear {
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
