
import Foundation

extension ChildGetGalleryPostsResponse{
    
    func toDomain()-> GalleryItem{
        
        GalleryItem(
            id: self.idPost,
            type: self.postType,
            file: self.postFile,
            status: self.postStatus,
            preview: self.preview
        )
        
    }
}
