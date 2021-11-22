//
//  AddToDoView.swift
//  ToDos
//
//  Created by Rayan Taj on 06/11/2021.
//

import SwiftUI

struct AddToDoView: View {
    
    @State var titleTextField : String = " "
    @State var descriptionTextField : String = " "
    @State var categoryPicker: String = "other"
    @State var deadlineDate : Date = Date()
    
    var categories = ["Travel", "Grocery", "Family", "Entertainment" , "Work", "other"]

    
    @Environment (\.managedObjectContext ) private var viewContext

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
       
        
        VStack(spacing: 40){
       

            ZStack{
         
                VStack(alignment: .leading){
                    
                    Text ("Title ")
                        .foregroundColor(.white)
                        
                    TextField(" ex. Buy Milk", text: $titleTextField)
                        .background(.white)
                        .cornerRadius(20)
                        .font(.system(size: 17))
                }
                .padding(.horizontal , 15)


     

            }
            .frame( height: 100)
            .background(.blue)
            .cornerRadius(25)
            
            ZStack{
         
                VStack(alignment: .leading){
                    
                    Text ("Description ")
                        .foregroundColor(.white)
                        
                    TextEditor(text: $descriptionTextField)
                        .navigationTitle("Add a new ToDo")
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(20)
                        .font(.system(size: 17))
                        .frame( height: 120)
                }
                .padding(.horizontal , 15)

            }
            .frame( height: 200)
            .background(.blue)
            .cornerRadius(25)
            
            
            ZStack{
         
                HStack{
                    
                    Text ("Category ")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    
                    ZStack{
                        
                        Picker("",selection: $categoryPicker) {
                                      ForEach(categories, id: \.self) {
                                          Text($0)
                                      }
                                  }
                        
                     
                    }
                    .frame(width: 100, height: 25)
                    .background(.white)
                    .cornerRadius(25)
            
                }
                .padding(.horizontal , 15)

            }
            .frame( height: 50)
            .background(.blue)
        .cornerRadius(25)
            
        
            
            
            
            ZStack{
         
                HStack{
                    
                    Text (" DeadLine ")
                        .foregroundColor(.white)
                    
                    Spacer()
                    ZStack{
                        
                        DatePicker("", selection: $deadlineDate, displayedComponents: .date)
                            .foregroundColor(.white)
//                            .background(.white)
                            .cornerRadius(10)
                         
                   
                        
                          
                                         

                        }
                    } .padding(.horizontal , 15)
         
            
                }
            .frame( height: 50)
            .background(.blue)
        .cornerRadius(25)
  
            
            Button(action: {
                
             
                
                do {
                    let myToDo = ToDo(context: viewContext)
                                 myToDo.title = titleTextField
                                 myToDo.desc = descriptionTextField
                                 myToDo.category = categoryPicker
                                 myToDo.deadline = deadlineDate
                                 myToDo.timestamp = Date()
                    myToDo.isDone = false
                    
                    
                    try    viewContext.save()
                    
                    presentationMode.wrappedValue.dismiss()

                } catch  {
                    
                }
                
            }, label: {
                
                Text("Add")
                
   
                
                  
                 
            })
                .font(.system(size: 20))
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(15)
          
              
            
            
            
        }
        .padding()
        .onTapGesture {
                hideKeyboard()
        }
        

        
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}




extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
