
import SwiftUI
import KingfisherSwiftUI

struct GalleryItemView: View {
    
    var galleryItem : GalleryItem

    var body: some View {
        
        KFImage(URL(string: getImageOfGalleryItem(galleryItem: galleryItem)))
            .resizable()
            .placeholder {
                Color.loginCardBackground
            }
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: galleryItem.type == GalleryItemType.video.rawValue ? 220 : 170)
            .clipped()
            .overlay(alignment: .center) {
                if galleryItem.type == GalleryItemType.video.rawValue {
                    Image(systemName: "play.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                        .background(Color.black.opacity(0.55))
                        .clipShape(Circle())
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.loginCardBorder.opacity(0.8), lineWidth: 1)
            )
            .padding(.horizontal, 1)
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
        )
    }
}
