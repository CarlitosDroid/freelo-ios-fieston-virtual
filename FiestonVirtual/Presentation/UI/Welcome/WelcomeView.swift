
import SwiftUI

struct WelcomeView: View {
    
    var welcome: Welcome
    
    var body: some View {
        VStack{
            Text(welcome.title).bold().fixedSize(horizontal: true, vertical:true)
            Text(welcome.description).fixedSize(horizontal: true, vertical:true)
            Text(welcome.subtitle).fixedSize(horizontal: true, vertical:true)
            Text(welcome.imageUrl).bold()
            
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
