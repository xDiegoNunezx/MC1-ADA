//
//  Meditation.swiftsquare.and.arrow.up
//  MC1-ADA
//
//  Created by Antea La Cava on 19/10/23.
//

import SwiftUI

struct Meditation: View {
    
    var viewModel = MeditationFrasiManagerClass()
    var body: some View {
        
        
        
        NavigationView {
            ZStack {
                AnimatedBackground().edgesIgnoringSafeArea(.all)
                    .blur(radius: 50)
                
                VStack {
                    Spacer()
                    
                    Text(viewModel.frasi.randomElement()?.quote ?? "" )
                        .fontWeight(.semibold)
                        .padding(40)
                        .font(.system(size: 30))
                    
                    
                    Spacer()
                    
                    
                    
                        .navigationBarTitle("Meditation")
                        
                    
                    
                        .navigationBarItems(leading: HStack {
                            Image(systemName: "chevron.backward")
                            NavigationLink("Back", destination: Text("MainPage")
                                .navigationBarBackButtonHidden(true))
                            .foregroundColor(.black)
                        }
                                            
                                            ,trailing: Image(systemName: "figure.mind.and.body"
                                                            )
                        )
                }
            }
        }
    }
    
    
    
    
    
    
    
    struct AnimatedBackground: View {
        @State var start = UnitPoint(x: 0, y: -2)
        @State var end = UnitPoint(x: 4, y: 0)
        
        let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
        let colors = [Color.blue, Color.mint, Color.purple, Color.teal, Color.green, Color.orange, Color.indigo]
        
        var body: some View {
            
            LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
                .animation(.easeInOut(duration: 6).repeatForever(), value: colors)
                .onReceive(timer, perform: { _ in
                    
                    self.start = UnitPoint(x: 4, y: 0)
                    self.end = UnitPoint(x: 0, y: 2)
                    self.start = UnitPoint(x: -4, y: 20)
                    self.start = UnitPoint(x: 4, y: 0)
                })
        }
    }
    
    
}







#Preview {
    Meditation()
}
