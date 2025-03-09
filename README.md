# iExpensesTracker
An iOS application in Swift that allows you to register, classify, and visualize daily expenses, using MVVM and a local (or cloud) database for information persistence.

# iExpensesTracker

iExpensesTracker is an iOS application built in Swift using the MVVM architecture. Its main goal is to enable users to record, categorize, and review their daily expenses in a simple and organized way.

## Features

- **Expense Recording**:  
  - Auto-generated date and time.  
  - Predefined categories (Entertainment, Food, Streaming Services, Stationery, Home Loan, Personal Loan, Holiday).  
  - Expense amount.  

- **Database**:  
  - Use of SQLite, Firebase, or any other persistence solution.  
  - Secure and efficient data handling for queries and updates.

- **Expense Summary**:  
  - Monthly summary.  
  - Category-based summary.  
  - Optional visualizations (charts or tables).

- **MVVM Architecture**:  
  - **Model**: Defines the data entities and business logic.  
  - **View**: Registration form and summary screens, designed for easy user interaction.  
  - **ViewModel**: Holds the presentation logic and interacts with the data layer.

## Folder Structure
  - **Models**: Classes and structs representing data (for example, `Expense`).  
  - **ViewModels**: Manages presentation logic and adapts data for the views.  
  - **Views**: UI elements and screens of the app.  
  - **Services**: Layer for data storage (SQLite/Firebase) and any additional services (network, etc.).  
  - **Resources**: Graphic assets, `.xcassets` files, etc.

## Prerequisites

- Xcode 14+  
- iOS 14+  
- Swift 5.5+

## How to Run

1. Clone the repository:  
2. Open the project in Xcode.  
3. Select a simulator or a physical device.  
4. Click **Run** (or press `Cmd + R`).  

## Contributing

This project is open to all kinds of contributions and improvements. Feel free to open issues and pull requests!

---

**Thank you for using iExpensesTracker!**  
Any suggestions or bug reports are welcome to help us keep improving the app.
