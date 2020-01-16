//
//  TabbedMain.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

func askNotification(){
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    notificationCenter.requestAuthorization(options: options) {
        (didAllow, error) in
        if !didAllow {
            print("User has declined notifications")
        } else {
            
        }
    }
}

enum OutlineMenu: Int, CaseIterable, Identifiable {
    var id: Int {
        return self.rawValue
    }
    
    
    case plan, today, home, new
    
    var title: String {
        switch self {
        case .plan:    return "Plan"
        case .today:   return "Today"
        case .home:   return "Home"
        case .new: return "New"
        
        }
    }
    
    var image: String {
        switch self {
        case .plan:    return "folder"
        case .today:   return "calendar.circle"
        case .home:   return "house"
        case .new: return "plus.square"
        
        }
    }
    
    
}

struct SplitView: View{
    @State var selectedMenu: OutlineMenu = .home
    @ObservedObject var store: Store<AppState, AppAction>
    @State var content: AnyView? = nil
    @State var dummySelection = 0
    
    var contentView: AnyView {
        switch selectedMenu {
        case .plan:    return AnyView(PlanHome(store: self.store.view(value: {$0.toDoState}, action: {.toDo($0)})).navigationViewStyle(StackNavigationViewStyle()))
        case .today:   return AnyView(TodayMain(store: store).navigationViewStyle(StackNavigationViewStyle()))
        case .home:   return AnyView(Home(store: store).navigationViewStyle(StackNavigationViewStyle()))
        case .new: return AnyView(CreateMain(store: store, tabSelection: $dummySelection).navigationViewStyle(StackNavigationViewStyle()))
        }
    }
    
    var body: some View{
        HStack(spacing: 0){
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 5){
            ForEach(OutlineMenu.allCases){o in
                HStack{
                    Image(systemName: o.image)
                    .foregroundColor(Color.primary.opacity(0.7))
                Text(o.title)
                    .font(.system(size: 17))
                    //.fontWeight(.semibold)
                    .foregroundColor(Color.primary.opacity(0.7))
                    
                
                    Spacer()
                }
                .frame(width: 200, height: 35)
                    .padding(.leading, 10)
                .background(o == self.selectedMenu ? Color.gray.opacity(0.2) : Color.clear)
                .onTapGesture {
                self.selectedMenu = o
                }
            }
                }.padding(.top, 50)
               Spacer()
            }.background(Color.gray.opacity(0.1))
            NavigationView{
            contentView
            }.navigationViewStyle(StackNavigationViewStyle())
        }//.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TabbedMain : View {
    @State var selection: Int
    //@EnvironmentObject var mainEnvObj : MainEnvObj
    @ObservedObject var store: Store<AppState, AppAction>
    

    
    @FetchRequest(
        entity: Document.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date, ascending: false)],
        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "type_private != 'day'"),
            NSPredicate(format: "is_template = false")
        ])
    )
    var documents: FetchedResults<Document>
    

    
    
    
           var body: some View {
              TabView(selection: $selection){
                Text("Library")
                    .tabItem({
                        Image(systemName: "square.stack")
                        Text("Library")
                        }
                )
                    .tag(0)
                Today(store: store)
                //TodayHolder(store: store)
                .tabItem({
                Image(systemName: "app")
                Text("Today")
                })
                    .tag(1)
                
                Home(store: store)
                .tabItem({
                    Image(systemName: "square.grid.2x2")
                    Text("Home")
                })
                .tag(2)
                
                SearchMain(searchObj: SearchObject(documents: documents.map{DocumentLoadable(document: $0)}))
                    .tabItem({
                                   Image(systemName: "magnifyingglass")
                                   Text("Search")
                                   })
                .tag(3)
              }
           
//        TabView(selection: $selection){
//            //Home()//.environmentObject(mainEnvObj)
//            PlanHome(store: store.view(value: {$0.toDoState}, action: {.toDo($0)}))
//            .tabItem({
//                selection == 0 ?
//                    Image(systemName: "folder.fill")
//                        .imageScale(.medium) :
//                    Image(systemName: "folder")
//                        .imageScale(.medium)
//                Text("Plan")
//            })
//            .tag(0)
//
//            TodayMain(store: store)
//            .tabItem({
//                selection == 1 ?
//                    Image(systemName: "calendar.circle.fill")
//                        .imageScale(.medium) :
//                    Image(systemName: "calendar.circle")
//                        .imageScale(.medium)
//                Text("Today")
//            })
//            .tag(1)
//
//            Home(store: store)
//                .tabItem({
//                    selection == 2 ?
//                        Image(systemName: "house.fill")
//                            .imageScale(.medium) :
//                        Image(systemName: "house")
//                            .imageScale(.medium)
//                    Text("Home")
//                })
//                .tag(2)
//
//            //CreateMain().environmentObject(mainEnvObj)
//            CreateMain(store: store, tabSelection: $selection)
//                //Text("hey")
//                .tabItem({
//                    selection == 3 ?
//                        Image(systemName: "plus.square.fill")
//                            .imageScale(.medium) :
//                        Image(systemName: "plus.square")
//                            .imageScale(.medium)
//                    Text("New")
//                })
//                .tag(3)
//
//            Text("""
//                ⚠️Under Construction⚠️
//                For now, please text me at 347-610-9067 with issues, ideas, and encouragement ❤️
//                """).multilineTextAlignment(.center)
//
//                .tabItem({
//                    selection == 4 ?
//                        Image(systemName: "questionmark.diamond.fill")
//                            .imageScale(.medium) :
//                        Image(systemName: "questionmark.diamond")
//                            .imageScale(.medium)
//                    Text("Feedback")
//                })
//                .tag(4)
//
//        }.navigationViewStyle(StackNavigationViewStyle())
    

    }
    //}
}


