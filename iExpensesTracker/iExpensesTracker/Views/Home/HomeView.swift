//
//  HomeView.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI
import Charts

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    expenseCard
                    
                    budgetsSection
                    
                    savingsSection
                    
                    spendingSection
                    
                    recentExpensesSection
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .navigationTitle("Home")
            .background(Color.iETLightBackground.ignoresSafeArea())
            .onAppear {
                viewModel.loadData(context: modelContext)
            }
        }
    }
}

// MARK: - Subviews
extension HomeView {

    private var expenseCard: some View {
        VStack {
            Text("Expense")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("$\(viewModel.totalExpenses)") 
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    private var budgetsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Budgets")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text("June, 2022")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            ProgressView(value: 0.1)
                .tint(.iETPrimaryGreen)
                .progressViewStyle(.linear)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    private var savingsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Savings")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    
                }) {
                    Text("View details")
                        .font(.subheadline)
                        .foregroundColor(.iETPrimaryGreen)
                }
            }
            Text("You saved $100!")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    private var spendingSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Spending")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text("June, 2022")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(viewModel.expensesByCategory.keys.sorted(), id: \.self) { category in
                        if let total = viewModel.expensesByCategory[category] {
                            SectorMark(
                                angle: .value("Amount", total)
                            )
                            .foregroundStyle(by: .value("Category", category))
                            .cornerRadius(4)
                        }
                    }
                }
                .frame(height: 200)
            } else {
                Text("Charts not available on iOS < 16")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    private var recentExpensesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Expenses")
                .font(.headline)
                .foregroundColor(.black)
            
            ForEach(viewModel.expenses.prefix(3)) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name ?? "Untitled")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        Text("Category: \(expense.category)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("$\(expense.amount, specifier: "%.2f")")
                        .fontWeight(.medium)
                        .foregroundColor(.iETPrimaryGreen)
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
