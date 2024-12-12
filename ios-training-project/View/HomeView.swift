//
//  TimeOffTableView.swift
//

import SwiftUI

struct HomeView: View {
    
    var user: User
    @Binding var isLoggedIn: Bool // Binding to manage the login state
    
    @State private var timeOffDataList: [TimeOff] = []
    let persistenceController = PersistenceController.shared
    
    
    var body: some View {
        
        
        NavigationStack{
            
            NavigationLink(
                destination: FormView(user: user).navigationBarBackButtonHidden(true),
                isActive: $isLoggedIn
            ){
                EmptyView()
                
                HStack(spacing: 80){
                    
                    CustomButton(
                        title: "New Time off",
                        action: {
                            isLoggedIn = true
                        },
                        backgroundColor: .purple
                    )
                    .padding(.vertical)
                    .frame(width: .infinity)
                    
                    //                    Spacer()
                    
                    CustomButton(
                        title: "Sign Out",
                        action: {
                            signOut()
                        },
                        backgroundColor: .secondary
                    )
                    .padding(.vertical)
                    .frame(width: .infinity)
                    
                }
                
            }
            
            TableHeaderView()
                .padding(.vertical,0)
            
            List($timeOffDataList,id:\.self.id){ $item in
                
                HStack(alignment: .top){
                    
                    VStack{
                        NavigationLink(destination: DummyDetailView(timeOffDetail: item.id!.uuidString)){
                            Text(item.id!.uuidString)
                                .padding(.horizontal)
                                .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                        }
                        .frame(maxWidth: .infinity,alignment: .topLeading)
                    }
                    //                    .border(.blue)
                    .padding(.vertical,10)
                    
                    VStack{
                        Text(item.startDate!,formatter: dateFormatter)
                            .padding(.vertical,2)
                        Text(item.endDate!,formatter: dateFormatter)
                            .padding(.vertical,2)
                    }
                    .frame(alignment: .center)
                    .padding(.vertical,10)
                    
                    
                    VStack(alignment: .leading){
                        Text(item.timeOffType!)
                            .padding(.horizontal)
                        HStack{
                            CheckBoxView(isChecked: $item.isHalfDay)
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.vertical,10)
                    
                }
                .background(Color.white)
                .font(.system(size: 15))
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .padding(.horizontal,0)
                .padding(.vertical,12)
                .cornerRadius(10)
            }
            .onAppear {
                // Fetch the data for the current user
                timeOffDataList = persistenceController.fetchData(for: user)
            }
            .listStyle(PlainListStyle())
            .background(Color.clear)
            .listRowInsets(EdgeInsets())
            .padding(0)
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    private func signOut() {
        // Reset the isLoggedIn state to false
        isLoggedIn = false
    }
    
    
}

//#Preview {
//    HomeView()
//}

#Preview {
    // Create a mock User and MyData for the preview
    let context = PersistenceController.shared.container.viewContext
    
    // Create and save User
    let user = User(context: context)
    user.email = "abc@email.com"
    user.password = "abc123"
    user.username = "ABC"
    
    // Create and save MyData
    let data1 = TimeOff(context: context)
    data1.id = UUID()
    data1.timeOffType = TimeOffType.allCases.randomElement()?.rawValue
    data1.holidayName = "\(user.username!) - TF\(Int.random(in: 10...99))"
    data1.startDate = Date()
    data1.endDate = Date().addingTimeInterval(60*60*24)
    data1.isHalfDay = Bool.random()
    data1.creationDate = Date().addingTimeInterval(-60*60*24)
    data1.user = user
    
    // Save context to persist the objects
    do {
        try context.save()
    } catch {
        print("Error saving context: \(error)")
    }
    
    // Return HomeView with the user and a constant isLoggedIn state
    return HomeView(user: user, isLoggedIn: .constant(true))
}
