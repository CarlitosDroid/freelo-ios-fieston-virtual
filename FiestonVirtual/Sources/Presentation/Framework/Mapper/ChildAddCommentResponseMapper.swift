
import Foundation

extension ChildAddCommentResponse{
    
    func toComment() -> Comment {
        return Comment(
            id: self.idComment,
            text: self.comment,
            avatar: self.avatar,
            userName: self.userComment
        )
    }
    
}
