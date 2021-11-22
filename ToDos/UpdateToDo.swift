//
//  UpdateToDo.swift
//  ToDos
//
//  Created by Rayan Taj on 06/11/2021.
//

import SwiftUI

struct UpdateToDo: View {

    @State var titleTextField : String = " "
    @State var descriptionTextField : String = " "
    @State var categoryPicker: String = " "
    @State var deadlineDate : Date = Date()
    @State var isDone :Bool = false


    @Environment (\.managedObjectContext ) private var viewContext

    @Environment(\.presentationMode) var presentationMode

    var toDo : ToDo?

    
    var categories = ["Travel", "Grocery", "Family", "Entertainment" , "Work", "other"]
    
    
    init(toDo : ToDo) {

        self.toDo = toDo
        
        _titleTextField = State(initialValue: toDo.title ??  " " )
        _descriptionTextField = State(initialValue: toDo.desc ?? " "  )
        _isDone = State(initialValue: toDo.isDone )
        _categoryPicker = State(initialValue: toDo.category ?? " "  )
        _deadlineDate = State(initialValue: toDo.deadline ?? Date())


    }


    var body: some View {
        VStack(spacing: 30){
       
            Text("Update your ToDo ").foregroundColor(.blue)
                .font(.title)

            ZStack{
         
                VStack(alignment: .leading){
                    
                    Text ("Title ")
                        .foregroundColor(.white)
                        
                    TextField(titleTextField, text: $titleTextField)
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
  
            
            
            
            ZStack{
         
                HStack{
                    
                    Text (" Mark as done  ")
                        .foregroundColor(.white)
                    
                    Spacer()
                    ZStack{
                        Toggle(isOn: $isDone) {
                            
                        }
                     
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
                   
                    toDo?.title = titleTextField
                    toDo?.desc = descriptionTextField
                    toDo?.category = categoryPicker
                    toDo?.deadline = deadlineDate
                    toDo?.timestamp = Date()
                    toDo?.isDone = isDone
                    
                    
                    try    viewContext.save()
                    
                    presentationMode.wrappedValue.dismiss()

                } catch  {
                    
                }
                
            }, label: {
                
                Text("Update")
            })
            
            
            
        }.padding()

    }
}

struct UpdateToDo_Previews: PreviewProvider {
    static var previews: some View {
        
        let persistentContainer  = CoreDataManager.shared.persistentContainer
                
        UpdateToDo( toDo: ToDo())
        
            .environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}



