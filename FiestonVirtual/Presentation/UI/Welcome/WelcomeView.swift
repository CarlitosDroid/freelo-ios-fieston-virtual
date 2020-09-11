
import SwiftUI
import KingfisherSwiftUI

struct WelcomeView: View {
    
    var welcome: Welcome
    @Binding var showView : Bool
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            HStack {
                Spacer()
                Button(action: {
                    self.showView.toggle()
                }){
                    Text("X").font(.title).bold().foregroundColor(Color(.white))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
            
            Image("Fieston")
            
            Text(welcome.title).font(.title).bold().foregroundColor(Color(.yellow)).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
            
            Text( welcome.description).font(.body).bold().foregroundColor(Color(.green)).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
            
            Text(welcome.subtitle).font(.body).bold().foregroundColor(Color(.yellow)).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
            
            KFImage(URL(string: welcome.imageUrl)!)
                .resizable()
                .renderingMode(.original)
                .shadow(radius: 0)
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
            
            Spacer()
            
            
        }.padding(20).background(Color(.purple))
        
    }
    
}
/*
 struct WelcomeView_Previews: PreviewProvider {
 static var previews: some View {
 WelcomeView(welcome: Welcome())
 }
 }
 */
