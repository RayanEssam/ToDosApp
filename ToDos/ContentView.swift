//
//  ContentView.swift
//  ToDos
//
//  Created by Rayan Taj on 06/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @Environment (\.managedObjectContext ) private var viewContext
    
    @FetchRequest( entity: ToDo.entity() ,
                   sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)  ],
                   animation: .default)
    
    private var items: FetchedResults<ToDo>
    
    var body: some View {
        
        NavigationView {
            
            
            
            ZStack{
                
                
                
                VStack(alignment : .leading ){
                    
                    Text("ToDos")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.top ,50 )
                        .padding()
                    
                    
                    ZStack{
                        
                        List {
                            
                            
                            
                            ForEach(items) { item in
                                
                                NavigationLink(destination: {
                                    
                                    UpdateToDo(toDo: item)
                                    
                                }, label: {
                                    ZStack {
                                        
                                        
                                        
                                        HStack(alignment: .center ){
                                            
                                            
                                            item.isDone ? Text(item.title! ).strikethrough() :
                                            Text(item.title! )
                                                      
                                            Spacer()
                                            
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width:15 , height: 15)
                                                .foregroundColor(.clear)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 50)
                                                        .stroke(Color.blue, lineWidth: 5)
                                                )
                                            
                                            
                                        }
                                        .frame( height: 80)
                                        
                                    }
                                }
                                               
                                               
                                )
                                
                                
                                
                                
                                    .listRowSeparator(.hidden)
                      
                            } .onDelete(perform: deleteItems)
         
                        }
                        
                        
                        
                    }
                    .frame(width :  UIScreen.main.bounds.width)
                    .background(.white)
                    .ignoresSafeArea()
                    .cornerRadius(35)
                    .padding(.top , 20)
                    .padding(.bottom , 50)
                    
                }
                
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(.white)
                }
                ToolbarItem {
                    
                    NavigationLink(destination: AddToDoView()) {
                        Image(systemName: "plus")
                    } .foregroundColor(.white)
                    
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            .background(.blue)
            
            
            
        }
        
        
    }
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
      
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer  = CoreDataManager.shared.persistentContainer
        
        ContentView()
            .environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
