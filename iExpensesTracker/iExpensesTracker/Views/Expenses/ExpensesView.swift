
//
//  Untitled.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @State private var showAddExpenseSheet = false
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ExpensesViewModel()

    
    private let categories = [
        "Entertainment", "Food", "Streaming Services",
        "Stationery", "Home Loan", "Personal Loan", "Holiday"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.iETLightBackground.ignoresSafeArea()
                VStack {
                    if viewModel.expenses.isEmpty {
                        Text("No expenses yet")
                            .foregroundColor(.iETPrimaryGreen.opacity(0.8))
                            .padding()
                    } else {
                        List($viewModel.expenses) { $expense in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: iconName(for: $expense.category.wrappedValue))
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.iETPrimaryGreen)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text($expense.name.wrappedValue)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Text("Category: \($expense.category.wrappedValue)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Text(formattedDate($expense.date.wrappedValue))
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                Text("$\($expense.amount.wrappedValue, specifier: "%.2f")")
                                    .font(.headline)
                                    .foregroundColor(.iETPrimaryGreen)
                            }
                            .padding(.vertical, 8)
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deleteExpense(expense, context: modelContext)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddExpenseSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.iETPrimaryGreen)
                    }
                }
            }
            .sheet(isPresented: $showAddExpenseSheet) {
                addExpenseSheet
            }
            .onAppear {
                viewModel.loadExpenses(context: modelContext)
            }
        }
    }
    
    private var addExpenseSheet: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $viewModel.newExpenseName)
                }
                
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $viewModel.newExpenseAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                }
            }
            .navigationTitle("New Expense")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showAddExpenseSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addExpense(context: modelContext)
                        showAddExpenseSheet = false
                    }
                }
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
