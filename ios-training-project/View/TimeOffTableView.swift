//
//  TimeOffTableView.swift
//

import SwiftUI

struct TimeOffTableView: View {
    
    @ObservedObject var viewModel = TimeOffTableViewModel()
    
    var body: some View {
        
        VStack{
            
            TableHeaderView()
                .padding(.vertical,0)
            
            List(viewModel.tableData,id:\.self.id){ item in
                
                HStack(alignment: .top){
                    
                    VStack{
                        NavigationLink(destination: DummyDetailView(timeOffDetail: item)){
                            Text(item.timeOffId)
                                .padding(.horizontal)
                                .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                        }
                        .frame(maxWidth: .infinity,alignment: .topLeading)
                    }
                    //                    .border(.blue)
                    .padding(.vertical,10)
                    
                    VStack{
                        Text(item.startDate)
                            .padding(.vertical,2)
                        Text(item.endDate)
                            .padding(.vertical,2)
                    }
                    .frame(alignment: .center)
                    .padding(.vertical,10)
                    
                    
                    VStack(alignment: .leading){
                        Text(item.type)
                            .padding(.horizontal)
                        HStack{
                            CheckBoxView(isChecked: item.isHalfDay)
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
            .listStyle(PlainListStyle())
            .background(Color.clear)
            .listRowInsets(EdgeInsets())
            .padding(0)
        }
        //        .onAppear {
        //            viewModel.methodToFetchTimeOffData
        //        }
        
    }
}

#Preview {
    TimeOffTableView()
}
