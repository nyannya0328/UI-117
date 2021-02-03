//
//  Home.swift
//  UI-117
//
//  Created by にゃんにゃん丸 on 2021/02/02.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var model = ViewModel()
    @State var locationmanager = CLLocationManager()
    
    
   
    
    var body: some View {
        ZStack{
            
            MapView().ignoresSafeArea(.all, edges: .all)
                .environmentObject(model)
            
          
         
            
            
            
            VStack{
                
                VStack {
                    if model.show{
                        
                        HStack{
                            
                        
                           
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .modifier(TFModeifier())
                            
                            TextField("Enter", text: $model.text)
                                .colorScheme(.light)
                                .modifier(TFModeifier())
                            
                            
                            Button(action: {
                                
                                model.text = ""
                                model.show.toggle()
                                
                            }, label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.green)
                            })
                            
                            
                                
                            
                            
                        }
                       
                      
                       
                        .background(Color.white)
                      
                        
                        
                    }
                    else{
                        
                      
                        
                        Button(action: {
                            
                           
                            model.show.toggle()
                            
                        }, label: {
                            Spacer()
                            
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.green)
                        })
                        
                        
                        
                    }
                    
                   
                   
                    
                    if !model.places.isEmpty && model.text != "" {
                        ScrollView{
                            
                            VStack(spacing:15){
                                
                                ForEach(model.places){place in
                                    
                                    Text(place.placemark.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity,alignment: .trailing)
                                        .padding(.trailing)
                                        .onTapGesture {
                                            model.selectplace(place: place)
                                            
                                        }
                                    
                                    Divider()
                                    
                                      
                                        
                                       
                                    
                                
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                        }
                        .background(Color.white)
                        
                        
                    }
                    
                    
                }
                .padding()
                
                
                
                  
                
                Spacer()
                
                VStack{
                    
                    Button(action: {
                        
                        model.foucusLocation()
                        
                        
                        
                    }) {
                        
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                        
                    }
                        
                    Button(action: model.updatemaptype){
                        
                        Image(systemName: model.maptype == .standard ? "network" : "map.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                            
                        
                        
                        
                    }
                        
                        
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding()
                
            }
            
            
             
            
        }
        .onAppear(perform: {
            
            locationmanager.delegate = model
            locationmanager.requestWhenInUseAuthorization()
        
           
        
        })
        .onChange(of: model.text, perform: { (value) in
            
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == model.text{
                    
                    self.model.searchQuery()
                    
                 
                    
                }
            }
            
        })
        
        
        .alert(isPresented: $model.permissonDenid, content: {
            
            Alert(title: Text("Permisson Denied"), message: Text("Please Enable permisson In AppSetting"), dismissButton: .default(Text("Go to settings"),action: {
                
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                
                
            }))
            
            
            
        })
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TFModeifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content.padding(20)
            .background(Color("c1"))
            .cornerRadius(15)
            .overlay(
                
                RoundedRectangle(cornerRadius: 15).stroke(Color.black.opacity(0.05),lineWidth: 4)
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 5, y: 5)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: -5, y: -5)
                    .clipShape(Capsule())
            
            
            
            )
    }
    
}
