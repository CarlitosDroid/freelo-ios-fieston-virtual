
import SwiftUI
import Grid
import KingfisherSwiftUI
import QGrid

struct GalleryView: View {
    
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!
    
    @Binding var notifyGalleryFromMain: Bool
    
    @State private var scrollViewID = UUID()
    @State private var showGalleryDetail = false
    
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
                Text("Loading...")
                    .foregroundColor(.white)
            }
            
        }
        .onAppear {
            if(self.settings.refreshGallery) {
                viewModel.getGallery()
                settings.refreshGallery = false
            }
            if(self.notifyGalleryFromMain) {
                viewModel.getGallery()
                notifyGalleryFromMain = false
            }
        }.onReceive(viewModel.$galleryItems, perform: { nullGalleryItems in
            
            guard let nonNullGalleryItems = nullGalleryItems else { return }
            self.galleryItems.removeAll()
            self.galleryItems.append(contentsOf: nonNullGalleryItems)
            
        })
    }
    
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(notifyGalleryFromMain: .constant(false))
    }
}
