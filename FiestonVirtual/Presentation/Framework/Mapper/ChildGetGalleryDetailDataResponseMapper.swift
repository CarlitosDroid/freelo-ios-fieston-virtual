
import Foundation

extension ChildGetGalleryDetailDataResponse{
    
    func toDomain()-> GetGalleryDetail{
        
        GetGalleryDetail(
            idPost: self.post.idPost,
            postType: self.post.postType,
            postFile: self.post.postFile,
            postTitle: self.post.postTitle,
            postStatus: self.post.postStatus,
            postLikeCount: self.post.postLikeCount,
            postLike: self.post.postLike,
            userName: self.user.userName,
            userImage: self.user.userImage
        )
        
    }
}
