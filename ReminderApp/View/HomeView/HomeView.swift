//
//  HomeView.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Reminder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.time, ascending: true)]
    ) var reminders: FetchedResults<Reminder>

    @State private var showAddReminder = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Text("⏰ My Reminders")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.leading)

                    Spacer()
                }

                if reminders.isEmpty {
                    Spacer()
                    Text("No Reminders Yet")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.title2)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(reminders) { reminder in
                                ReminderCardView(reminder: reminder)
                                    .padding(.horizontal)
                                    .transition(.scale)
                            }
                        }
                    }
                }
            }
            .padding(.top)

            // Floating Add Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAddReminder = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]),
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                    }
                    .padding()
                    .sheet(isPresented: $showAddReminder) {
                        AddReminderView()
                    }
                }
            }
        }
    }
}
