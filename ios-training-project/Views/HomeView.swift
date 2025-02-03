//
//  TimeOffTableView.swift
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var isNavigate = false
    @StateObject var viewModel = UserTimeOffViewModel(context: PersistenceController.shared.viewContext)
    @State private var timeOffDataList: [TimeOff] = []
    
    var body: some View {
        
        NavigationStack{
            
            HStack(spacing: 80){
                
                NavigationLink(
                    destination: FormView(viewModel: self.viewModel).navigationBarBackButtonHidden(true),
                    isActive: $isNavigate
                ){
                    EmptyView()
                    CustomButton(
                        title: "New Time off",
                        action: {
                            isNavigate = true
                        },
                        backgroundColor: .purple
                    )
                    
                }
                CustomButton(
                    title: "Sign Out",
                    action: {
                        signOut()
                    },
                    backgroundColor: .secondary
                )
                
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            
            
            
            TableHeaderView()
            
            List($timeOffDataList,id:\.self.id){ $item in
                
                
                NavigationLink(
                    destination: DetailView(timeOffDetail:item)
                ){
                    EmptyView()
                    
                    HStack(spacing: 50){
                        
                        Text(item.id?.uuidString ?? "N/A")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .lineLimit(1)
                            .frame(width: 80)
                        VStack{
                            Text(item.startDate!,formatter: dateFormatter)
                                .padding(.vertical,2)
                            Text(item.endDate!,formatter: dateFormatter)
                                .padding(.vertical,2)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(item.timeOffType ?? "N/A")
                            
                            CheckBoxView(isChecked: $item.isHalfDay)
                                .font(.system(size: 12))
                        }
                    }
                }
                .shadow(color: Color.gray.opacity(0.1), radius: 2, x: 0, y: 1)
                //                .background(Color.white)
                .font(.system(size: 15))
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .padding(.horizontal,0)
                .padding(.vertical,10)
                .cornerRadius(10)
                
            }
            
            .onAppear {
                
                if let user = viewModel.fetchUser(UserSession.loadFromDefaults()?.userEmail ?? "abc@email.com"){
                    // Create a mock User and MyData for the preview
                    //                    let context = PersistenceController.shared.container.viewContext
                    
                    // Fetch the data for the current user
                    timeOffDataList = viewModel.fetchData(for: user)
                }
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
        UserSession.clearUserData() // Clear user data from UserDefaults
        isLoggedIn = false
    }
    
    
}


#Preview {
    HomeView(viewModel: UserTimeOffViewModel(context: PersistenceController.preview.viewContext))
}
