// The Swift Programming Language
// https://docs.swift.org/swift-book

/*
 
 struct ProfileView: View {
     
     @EnvironmentObject var dataStore: DataStore
     
     @State var isChangePasswordShown: Bool = false
     @State var name = ""
     

     var body: some View {
         Group {
             if let me = dataStore.authenticatedUser {
                 List {
                     
                     
                     
                     Section {
                         HStack {
                             Text("Name").bold()
                             Spacer()
                             Text("\(me.name ?? "")")
                         }
                         
                         HStack {
                             Text("Email").bold()
                             Spacer()
                             Text("\(me.email_address)")
                         }
                         
                         HStack {
                             Text("Phone Number").bold()
                             Spacer()
                             Text("\(me.phone_number)")
                         }
                         
                         
                         
                     }
                     
                     
                     
                     if let sessions = me.activeSessions {
                         Section("Sessions") {
                             
                             ForEach(sessions) { session in
                                 
                                 VStack {
                                     HStack {
                                         Text("\(session.ipAddress)")
                                         Spacer()
                                         Text("\(session.environment.rawValue)").multilineTextAlignment(.trailing)
                                     }
                                     
                                     Text("\(session.userAgent)").multilineTextAlignment(.leading)
                                 }
                             }
                         }
                     }
                     
                     
                     Section {
                         Button {
                             Task {
                                 isChangePasswordShown.toggle()
                             }
                         } label: {
                             Text("Change Password")
                                 .foregroundColor(.red)
                         }
                     }
                     
                     Section {
                         LogoutButton()
                     }
                 }
                 .listStyle(InsetGroupedListStyle())
             }
             else {
                 ContentUnavailableView("No User", systemImage: "person.crop.circle.badge.questionmark.fill", description: Text("No Active User"))
             }
         }
         .navigationTitle("Profile")
         .popover(isPresented: $isChangePasswordShown) {
             ChangePasswordPopover()
         }
     }
 }

 
 
 */
