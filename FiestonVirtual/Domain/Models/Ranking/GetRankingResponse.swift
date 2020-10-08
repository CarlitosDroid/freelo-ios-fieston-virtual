
import Foundation

struct GetRankingResponse : Encodable{
    let ranking: [Ranking]
    let userTotalScore: String
}
