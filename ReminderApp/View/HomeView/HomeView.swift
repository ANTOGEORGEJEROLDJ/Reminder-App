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
    @State private var selectedReminder: Reminder? = nil
    @State private var showActionSheet = false
    @State private var isEditing = false
    
    
    var body: some View {
        ZStack {
            // Background gradient
            Color.white
            //            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.3)]),
            //                           startPoint: .topLeading,
            //                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Text("⏰ My Reminders")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                        .padding(.leading)
                    
                    
                    
                    Spacer()
                    
                }
                
                
                if reminders.isEmpty {
                    Spacer()
                    Text("No Reminders Yet")
                        .foregroundColor(.gray.opacity(0.8))
                        .font(.title2)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(reminders) { reminder in
                                ReminderCardView(reminder: reminder,
                                                 onLongPress: {
                                    selectedReminder = reminder
                                },
                                                 isSelected: selectedReminder == reminder)
                            }
                            
                            
                        }
                    }
                }
            }
            .padding(.top)
            .onTapGesture {
                selectedReminder = nil
            }
            
            
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
                            .background(Color.blue)
                        //                            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]),
                        //                                                       startPoint: .topLeading,
                        //                                                       endPoint: .bottomTrailing))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                    }
                    .padding()
                    .sheet(isPresented: $showAddReminder) {
                        AddReminderView()
                    }
                }
            }
            
            // Top-right action menu for selected card
            if let selected = selectedReminder {
                VStack {
                    HStack {
                        Spacer()
                        Menu {
                            Button("📝 Edit") {
                                isEditing = true
                            }
                            Button("🗑️ Delete", role: .destructive) {
                                deleteReminder(reminder: selected)
                            }
                            Button("❌ Cancel") {
                                selectedReminder = nil
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle.fill")
                                .font(.system(size: 30))
                                .padding()
                                .foregroundColor(.black)
                        }
                    }
                    Spacer()
                }
                .animation(.easeInOut, value: selectedReminder)
                .transition(.opacity)
            }
        }
        // Edit Reminder Sheet
        .sheet(isPresented: $isEditing) {
            if let reminderToEdit = selectedReminder {
                EditReminderView(reminder: reminderToEdit) {
                    isEditing = false
                    selectedReminder = nil
                }
            }
        }
    }
    
    private func deleteReminder(reminder: Reminder) {
        context.delete(reminder)
        do {
            try context.save()
            selectedReminder = nil
        } catch {
            print("Error deleting reminder: \(error)")
        }
    }
}
