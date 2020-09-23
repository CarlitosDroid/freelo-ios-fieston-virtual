
import SwiftUI
import KingfisherSwiftUI

struct GalleryItemView: View {
    
    var galleryItem : GalleryItem
    var onGalleryItemSelected: (_ galleryItem: GalleryItem) -> Void
    
    var body: some View {
        
        KFImage(
            URL(
                string: getImageOfGalleryItem(
                    galleryItem: galleryItem
                )
            )
        )
        .resizable()
        .cornerRadius(6)
        .onTapGesture{
            self.onGalleryItemSelected(galleryItem)
        }
        
    }
    
    private func getImageOfGalleryItem(galleryItem:GalleryItem) -> String{
        switch galleryItem.type {
        case GalleryItemType.photo.rawValue:
            return galleryItem.file
        case GalleryItemType.video.rawValue:
            return galleryItem.preview
        default:
            return ""
        }
    }
    
}

struct GalleryItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        GalleryItemView(
            galleryItem: GalleryItem(
                id: 1,
                type: 1,
                file: "",
                status: 1,
                preview: "1"
            )
        ){(categorIndex: GalleryItem) in
            
        }
    }
}
