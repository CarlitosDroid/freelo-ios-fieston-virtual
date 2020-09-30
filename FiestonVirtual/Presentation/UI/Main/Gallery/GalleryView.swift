
import SwiftUI
import Grid
import KingfisherSwiftUI
import QGrid

struct GalleryView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryViewModel.self)!
    
    @State private var scrollViewID = UUID()
    @State private var showGalleryDetail = false
    @State private var onlyFirstTime = true
    
    var body: some View {
        
        ZStack{
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            LoadingView(isShowing: self.$viewModel.isLoading) {
                QGrid(viewModel.galleryItems, columns: 3) { item in
                    NavigationLink(destination: GalleryDetailView(galleryItem: item)) {
                        GalleryItemView(galleryItem: item)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
        .onAppear {
            viewModel.getGallery()
            /*scrollViewID = UUID()
             if(onlyFirstTime) {
             viewModel.getGallery()
             onlyFirstTime = false
             }*/
            
        }
    }
    
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}


struct GridCell: View {
  var person: Person

  var body: some View {
    VStack() {
        KFImage(URL(string: "http://fiestonvirtual.com/app/images/users/17/tn_5f6d1c231c042.jpeg"))
        .resizable()
        .scaledToFit()
        .clipShape(Circle())
        .shadow(color: .primary, radius: 5)
        .padding([.horizontal, .top], 7)
      Text(person.firstName).lineLimit(1)
      Text(person.lastName).lineLimit(1)
    }
  }
}


func PERSONASSSSSSSSS(galleryItems: [GalleryItem]) -> [Person] {
    
    var listota = [Person]()
    
    for index in 1...100 {
        
        listota.append(Person(imageName: galleryItems[index].file))
    }
    
    return listota
    
}


struct Person : Identifiable {
    let id = UUID().uuidString
    let imageName: String
    let firstName = "r21"
    let lastName = "r21"
}

