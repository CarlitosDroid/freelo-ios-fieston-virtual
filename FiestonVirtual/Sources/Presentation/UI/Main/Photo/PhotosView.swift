//
//  PhotosView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct PhotosView: View {
    
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(PhotosViewModel.self)!
    
    @Binding var selectedTab: Int
    
    @State var isShowingImagePicker = false
    @State var imageInBlackBox: UIImage?
    @State var fileURL: URL?
    @State private var postTitle: String = ""
    @State private var isImageSelected = false
    @State var fileType = ""
    
    var body: some View {
        LoadingView(isShowing: self.$viewModel.isLoading) {
            
            ZStack {

                LinearGradient(
                    colors: [
                        Color.loginGradientStart,
                        Color.loginGradientMiddle,
                        Color.loginGradientEnd
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    
                    if(isImageSelected) {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 0) {
                                previewCard()

                                HStack(spacing: 10) {
                                    Image(systemName: "pencil")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color(hex: "6F7278"))

                                    TextField("photos.title_placeholder", text: self.$postTitle)
                                        .font(.system(size: 15))
                                        .foregroundColor(Color(hex: "D8D8DC"))
                                        .accentColor(Color(hex: "36FFC4"))
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 51)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color(hex: "202426").opacity(0.9))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                                        )
                                )
                                .padding(.top, 20)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        tagView("photos.tag_party")
                                        tagView("photos.tag_health")
                                        tagView("photos.tag_dance")
                                    }
                                    .padding(.horizontal, 1)
                                }
                                .padding(.top, 12)

                                Button(action: {
                                    guard let fileURL = fileURL else { return }
                                    self.viewModel.uploadFile(data: fileURL, postTitle: postTitle)
                                }) {
                                    HStack(spacing: 10) {
                                        Image(systemName: "paperplane.fill")
                                            .font(.system(size: 18, weight: .bold))
                                        Text("photos.publish")
                                            .font(.system(size: 18, weight: .bold))
                                    }
                                    .foregroundColor(Color(hex: "071413"))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 62)
                                    .background(
                                        Capsule()
                                            .fill(Color(hex: "36FFC4"))
                                    )
                                    .shadow(color: Color(hex: "36FFC4").opacity(0.45), radius: 18)
                                }
                                .padding(.top, 26)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 80)
                            .padding(.bottom, 30)
                        }
                        
                    } else {
                        Spacer(minLength: 145)

                        VStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 23)
                                    .fill(Color(hex: "202A29"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 23)
                                            .stroke(Color.white.opacity(0.18), lineWidth: 1)
                                    )

                                Image(systemName: "photo.badge.plus")
                                    .font(.system(size: 34, weight: .semibold))
                                    .foregroundColor(Color(hex: "36FFC4"))
                            }
                            .frame(width: 96, height: 96)
                            .shadow(color: Color(hex: "36FFC4").opacity(0.16), radius: 26)

                            HStack(spacing: 6) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 11, weight: .bold))
                                Text("photos.live_badge")
                                    .font(.system(size: 12, weight: .semibold))
                                    .tracking(0.3)
                            }
                            .foregroundColor(Color(hex: "36FFC4"))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .fill(Color(hex: "1A302A"))
                                    .overlay(
                                        Capsule()
                                            .stroke(Color(hex: "36FFC4").opacity(0.55), lineWidth: 1)
                                    )
                            )
                        }

                        Spacer().frame(height: 24)

                        Text("photos.share_title")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 80)
                            .background(
                                RoundedRectangle(cornerRadius: 22)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(hex: "171C1C"),
                                                Color(hex: "282833")
                                            ]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 22)
                                            .stroke(Color.white.opacity(0.14), lineWidth: 1)
                                    )
                            )

                        Spacer().frame(height: 34)

                        Button(action: {
                            self.isShowingImagePicker.toggle()
                        }) {
                            HStack(spacing: 14) {
                                Image(systemName: "photo.badge.plus")
                                    .font(.system(size: 21, weight: .semibold))
                                Text("photos.choose_button")
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .foregroundColor(Color(hex: "071413"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 62)
                            .background(
                                Capsule()
                                    .fill(Color(hex: "36FFC4"))
                            )
                            .shadow(color: Color(hex: "36FFC4").opacity(0.48), radius: 18)
                        }
                        .sheet(isPresented: $isShowingImagePicker) {
                            ImageAndVideoPickerView(
                                isPresented: self.$isShowingImagePicker,
                                selectedImage: self.$imageInBlackBox,
                                fileURL: self.$fileURL,
                                fileType: self.$fileType
                            ) { isImageSelected, fileURL in
                                self.isImageSelected = isImageSelected
                            }
                        }

                        HStack(spacing: 5) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(hex: "36FFC4"))
                            Text("photos.supported_formats")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color(hex: "A7A7AD"))
                        }
                        .padding(.top, 13)

                        Spacer()
                    }

                                }
                                .padding(.horizontal, 16)
                
            }
        }.onAppear(perform: {
            isImageSelected = false
            postTitle = ""
        })
        .alert(isPresented: self.$viewModel.uploadPhotoHasFinished, content: {
            Alert(
                title: Text(self.viewModel.uploadPhotoMessage),
                dismissButton: .default(Text("common.accept"), action: {
                    selectedTab = TAB_GALLERY_ID
                    settings.refreshGallery = true
                })
            )
        })
        
    }

    @ViewBuilder
    private func previewCard() -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "2A3032"), Color(hex: "111516")],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                if let image = imageInBlackBox {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 12, weight: .semibold))
                        Text("photos.ready")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(Color(hex: "36FFC4"))
                    .padding(.horizontal, 13)
                    .frame(height: 31)
                    .background(Capsule().fill(Color(hex: "202426")))

                    Spacer()

                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 35, height: 35)
                        .background(Circle().fill(Color(hex: "383B3C")))
                }
                .padding(.horizontal, 12)
                .padding(.top, 13)
            }
            .aspectRatio(3 / 4, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack(spacing: 6) {
                Image(systemName: "photo")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(hex: "36FFC4"))
                Text("photos.resolution")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 10)
            .frame(height: 27)
            .background(Capsule().fill(Color(hex: "202426")))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, -39)
            .padding(.trailing, 13)
            .padding(.bottom, 12)
        }
        .padding(21)
        .background(
            RoundedRectangle(cornerRadius: 23)
                .fill(Color(hex: "172020").opacity(0.82))
                .overlay(
                    RoundedRectangle(cornerRadius: 23)
                        .stroke(Color.white.opacity(0.14), lineWidth: 1)
                )
        )
    }

    private func tagView(_ title: LocalizedStringKey) -> some View {
        Text(title)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color(hex: "D8D8DC"))
            .padding(.horizontal, 12)
            .frame(height: 31)
            .background(
                Capsule()
                    .fill(Color(hex: "292D2E").opacity(0.9))
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.12), lineWidth: 1)
                    )
            )
    }
    
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView(selectedTab: .constant(1))
    }
}
