//
//  HomeView.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Reminder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.time, ascending: true)]
    ) var reminders: FetchedResults<Reminder>
    
    @State private var showAddReminder = false
    @State private var selectedReminder: Reminder? = nil
    @State private var isEditing = false
    @State private var isSelectionMode = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Text("⏰ My Reminders")
                        .font(.title.bold())
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        isSelectionMode.toggle()
                        selectedReminder = nil
                    }) {
                        Text(isSelectionMode ? "Cancel" : "Select")
                            .font(.headline)
                            .padding(8)
                            .foregroundColor(.blue)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.trailing, 40)
                }
                .padding(.horizontal)
                
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
                                ReminderCardView(
                                    reminder: reminder,
                                    isSelectable: isSelectionMode,
                                    isSelected: selectedReminder == reminder,
                                    onTap: {
                                        if isSelectionMode {
                                            selectedReminder = (selectedReminder == reminder) ? nil : reminder
                                        }
                                    }
                                )
                            }
                        }
                    }
                }
            }
            .padding(.top)
            .onTapGesture {
                if isSelectionMode {
                    selectedReminder = nil
                }
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
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                    }
                    .padding()
                    .sheet(isPresented: $showAddReminder) {
                        AddReminderView()
                    }
                }
            }
            
            // Top-right menu for selected reminder
            if let selected = selectedReminder, isSelectionMode {
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
                .transition(.opacity)
                .animation(.easeInOut, value: selectedReminder)
            }
        }
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
        try? context.save()
        selectedReminder = nil
    }
}
