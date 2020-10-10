
import SwiftUI
import QGrid
import KingfisherSwiftUI

struct RankingView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(RankingViewModel.self)!
    
    @State var ranking : [Ranking]  = [Ranking]()
    @State var userTotalScore : String = "0"
    
    var body: some View {
        
        ZStack{
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
           
            LoadingView(isShowing: self.$viewModel.isLoading) {
                VStack(spacing: 0){
                    
                    HStack{
                        Image("main_ranking")
                        
                        Text("Ranking")
                            .foregroundColor(Color.amber_600)
                            .font(.system(size: 40))
                            .bold()
                        
                    }
                    .padding(.top,20)
                    
                    Text("Tienes "+userTotalScore+" pts.")
                        .foregroundColor(Color.aqua)
                        .padding(.top,20)
                    
                    
                    QGrid(ranking, columns: 1) { ranking in
                        HStack(spacing: 10){
                            
                            KFImage(URL(string: ranking.userLogo))
                                .placeholder{
                                    Image(systemName: "person.fill")
                                        .foregroundColor(Color.white)
                                }
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0, height: 40.0)
                                .clipShape(Circle())
                            
                            Spacer()
                            
                            VStack{
                                Text(ranking.userName)
                                    .foregroundColor(Color.aqua)
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                
                                
                                
                                Text(String(ranking.totalScore)+" pts")
                                    .foregroundColor(Color.aqua)
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                
                            }
                            
                            Spacer()
                            
                            if(ranking.position == 1){
                                VStack {
                                    
                                    Text(String(ranking.position))
                                        .font(.system(size: 20))
                                        .bold()
                                }
                                .frame(width: 40.0, height: 40.0)
                                .background(Color.amber_600)
                            }else{
                                VStack {
                                    
                                    Text(String(ranking.position))
                                        .font(.system(size: 20))
                                        .bold()
                                }
                                .frame(width: 40.0, height: 40.0)
                                .background(Color.purple)
                            }
                            
                            
                        }
                        
                    }
                    .padding(.leading,20)
                    .padding(.trailing,20)
                    .padding(.top,20)
                    
                    
                }
            }
            
        }
        .navigationBarTitle("Ranking")
        .onAppear{
            self.viewModel.getRanking()
        }
        .onReceive(self.viewModel.$getRankingResponse, perform: { getRankingResponse in
            if(getRankingResponse == nil ){ return}
            self.ranking = getRankingResponse!.ranking
            self.userTotalScore = getRankingResponse!.userTotalScore
            
        })
        
    }
    
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
