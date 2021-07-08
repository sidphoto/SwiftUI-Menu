//
//  ContentView.swift
//  Menu
//
//  Created by 鄭家騰 on 2021/7/7.
//

import SwiftUI
struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let imageName: String
    let handler: ()-> Void = {
        print("Tapped item")
    }
}

struct MenuContent: View {
    let items: [MenuItem] = [
    MenuItem(text: "Home", imageName: "house"),
    MenuItem(text: "Profile", imageName: "person.circle"),
    MenuItem(text: "Activity", imageName: "bell"),
    MenuItem(text: "Flights", imageName: "airplane"),
    MenuItem(text: "Settings", imageName: "gear"),
    MenuItem(text: "Share", imageName: "square.and.arrow.up" ),
    ]//Menu's pic & Name

    var body: some View {
        ZStack{
            Color(UIColor(red: 43/255.0,
                          green: 40/255.0,
                          blue: 70/255.0, alpha: 1 ))
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items) {item in
                  
                        HStack {
                            Image(systemName: item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32, alignment: .center)
                                
                            Text(item.text)
                                .foregroundColor(Color.white)
                                .bold()
                                .font(.system(size: 22))
                                .multilineTextAlignment(.leading)
                                    
                            
                                Spacer()
                            }
                        .onTapGesture {
                        }
                        .padding()
                        Divider()
                }
                Spacer()
            }
        .padding(.top,35)
        }
    }
}
struct SideMenu: View {
    let width: CGFloat
    let menuOpened: Bool
    let toggelMenu: ()-> Void
    
    var body: some View {
        ZStack{
            //Dimmed background view
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.15))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.toggelMenu()
            }
            //MenuContent
            HStack {
                MenuContent()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}
struct ContentView: View {
    @State var menuOpened = false
    var body: some View {
            ZStack{
                if !menuOpened {
                    Button(action: {
                    //Open Menu
                        self.menuOpened.toggle()
                    }, label: {
                        Text("Open Menu")
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50, alignment: .center)
                            .background(Color(.systemBlue))
                    })
                }
                
                SideMenu(width: UIScreen.main.bounds.width/1.6,
                         menuOpened: menuOpened,
                         toggelMenu: toggleMenu)
        }
        .edgesIgnoringSafeArea(.all)
    }
    func toggleMenu() {
        menuOpened.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
