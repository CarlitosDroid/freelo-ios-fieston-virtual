
import SwiftUI
import Grid
import KingfisherSwiftUI
import QGrid

struct GalleryView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!
    
    @State private var scrollViewID = UUID()
    @State private var showGalleryDetail = false
    @State private var onlyFirstTime = true
    
    var body: some View {
        
        ZStack{
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            LoadingView(isShowing: self.$viewModel.isLoading) {
                QGrid(viewModel.galleryItems, columns: 3) { item in
                    NavigationLink(destination: GalleryDetailView(galleryItem: item)) {
                        GalleryItemView(galleryItem: item)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
        .onAppear {
            viewModel.getGallery()
            /*scrollViewID = UUID()
             if(onlyFirstTime) {
             viewModel.getGallery()
             onlyFirstTime = false
             }*/
            
        }
    }
    
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
