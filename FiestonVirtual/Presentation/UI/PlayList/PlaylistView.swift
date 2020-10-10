//
//  PlayListView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/15/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import QGrid

struct PlaylistView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(PlaylistViewModel.self)!
    
    @State var songs : [Song]  = [Song]()
    
    var body: some View {
        
        ZStack{
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            LoadingView(isShowing: self.$viewModel.isLoading) {
                
                QGrid(songs, columns: 1) { song in
                    
                    HStack(spacing: 10){
                        
                        VStack{
                            Text(song.title)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity,alignment: .leading)
                            
                            Text(song.band)
                                .foregroundColor(Color.aqua)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity,alignment: .leading)
                            
                        }
                        
                        Spacer()
                        
                        if(song.requested){
                            Button(action: {
                                self.viewModel.requestSongUseCase(idPlaylist: song.id)
                            }){
                                Text("PEDIR")
                                    .foregroundColor(Color.deep_purple_700)
                                    .padding(5)
                            }
                            .background(Color.gray.cornerRadius(4))
                        }else{
                            Button(action: {
                                self.viewModel.requestSongUseCase(idPlaylist: song.id)
                            }){
                                Text("PEDIR")
                                    .foregroundColor(Color.deep_purple_700)
                                    .padding(5)
                            }
                            .background(Color.amber_600.cornerRadius(4))
                        }
                        
                    }
                    .padding(.top,10)
                    
                }
                .padding(.leading,20)
                .padding(.trailing,20)
                .padding(.top,10)
                .alert(isPresented: self.$viewModel.requestSongShowErrorMessage, content: {
                    Alert(
                        title: Text(self.viewModel.errorMessage),
                        dismissButton: .default(Text("Aceptar"))
                    )
                })
                
            }
            
        }
        .navigationBarTitle("Playlist")
        .onAppear{
            self.viewModel.getSongs()
        }
        .onReceive(self.viewModel.$songs){ songs in
            if(songs == nil){ return }
            self.songs =  songs!
            
        }
        .onReceive(self.viewModel.$song){ requestedSong in
            if(requestedSong == nil){ return }
            
            for i in 0..<(songs.count-1) {
                
                if(songs[i].id == requestedSong!.id){
                    songs[i].requested = requestedSong!.requested
                }
                
            }
        }
        .alert(isPresented: self.$viewModel.showErrorMessage, content: {
            Alert(
                title: Text(self.viewModel.errorMessage),
                dismissButton: .default(Text("Aceptar"))
            )
        })
        
    }
    
}

struct PlayListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
