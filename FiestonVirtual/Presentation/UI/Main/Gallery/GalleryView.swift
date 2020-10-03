
import SwiftUI
import Grid
import KingfisherSwiftUI
import QGrid

struct GalleryView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!
    
    @State private var scrollViewID = UUID()
    @State private var showGalleryDetail = false
    @State private var onlyFirstTime = true
    
    @State var galleryItems: [GalleryItem] = []
    
    var body: some View {
        
        ZStack{
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            if(!galleryItems.isEmpty) {
                QGrid(galleryItems, columns: 3) { item in
                    NavigationLink(destination: GalleryDetailView(galleryItem: item)) {
                        GalleryItemView(galleryItem: item)
                    }.buttonStyle(PlainButtonStyle())
                }
            } else {
                LoadingView(isShowing: self.$viewModel.isLoading) {
                    EmptyView()
                }
            }
            
        }
        .onAppear {
            if(onlyFirstTime){
                viewModel.getGallery()
                onlyFirstTime = false
            }
            
        }.onReceive(viewModel.$galleryItems, perform: { nullGalleryItems in
            
            guard let nonNullGalleryItems = nullGalleryItems else { return }
            
            self.galleryItems.append(contentsOf: nonNullGalleryItems)
            
        })
    }
    
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
