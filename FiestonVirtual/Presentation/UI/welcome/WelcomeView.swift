
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        VStack{
            Text("x")
            Text("IMagen")
            Text("Bienvenido a la fiesta")
            Text("Bienvenido juancho")
            Text("No olvides que puede subir fotos juancho").bold()
            Text("Acumula puntos y te ganas un box sorpresa")
            Text("Imagen")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
