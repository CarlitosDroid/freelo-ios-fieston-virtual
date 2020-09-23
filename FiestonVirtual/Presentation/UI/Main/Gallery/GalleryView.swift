
import SwiftUI
import Grid
import KingfisherSwiftUI

struct GalleryView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!
    
    var body: some View {
        
        ScrollView {
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            Grid(viewModel.galleryItems) { galleryItem in
                KFImage(URL(string: galleryItem.file))
                    .resizable()
                    .renderingMode(.original)
                    .shadow(radius: 0)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
            }.gridStyle(
                ModularGridStyle(columns: 3, rows: .fixed(150))
            )
        }
        .padding(.all, 10)
        .onAppear {
            viewModel.getGallery()
        }
        
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
