
import SwiftUI
import KingfisherSwiftUI

struct WelcomeView: View {
    
    @State var welcome: Welcome
    @State var showSheet: Bool
    
    var body: some View {
        VStack {
            EmptyView()
        } .sheet(isPresented: $showSheet) {
            VStack(alignment: .center, spacing: 20) {
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.showSheet.toggle()
                    }){
                        Text("X").font(.title).bold().foregroundColor(Color(.white))
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }
                
                //Image("Fieston").resizable().frame(width: 150, height:50)
           
                Image("Fieston")
                
                Text(self.welcome.title).font(.title).bold().foregroundColor(Color.amber_600).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                
                Text( self.welcome.description).font(.body).bold().foregroundColor(Color.aqua).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                
                Text(self.welcome.subtitle).font(.body).bold().foregroundColor(Color.amber_600).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                
                KFImage(URL(string: self.welcome.imageUrl))
                    .resizable()
                    .renderingMode(.original)
                    .shadow(radius: 0)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                
                Spacer()
                
                
            }.padding(20).background(Color.deep_purple_intense)
            
        }
    }
}
/*
 struct WelcomeView_Previews: PreviewProvider {
 static var previews: some View {
 WelcomeView(welcome: Welcome())
 }
 }
 */
