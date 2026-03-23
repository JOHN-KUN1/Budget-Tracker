# Budget Tracker

A powerful Flutter mobile app for tracking transactions, managing finances, and getting AI-powered insights from your bank statements.

## Features

- 📊 **Dashboard**: View your income, expenses, and current balance at a glance
- 💳 **Transaction Tracking**: Keep track of all your financial transactions
- 🤖 **AI Analysis**: Upload your bank statements and get intelligent financial insights powered by AI
- ⚙️ **Settings**: Customize your preferences
- 📱 **Clean UI**: Intuitive and user-friendly interface with Google Fonts styling

## Tech Stack

- **Framework**: Flutter 3.10+
- **State Management**: Riverpod
- **Storage**: Shared Preferences & SQLite (via sqflite)
- **AI Integration**: Integrated AI service for bank statement analysis
- **UI**: Material Design with customizable themes

## Getting Started

### Prerequisites

- Flutter SDK 3.10+
- Dart 3.10+
- Android SDK / Xcode (for iOS)

### Installation

1. Clone the repository
   ```bash
   git clone <repository-url>
   cd budget_tracker
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Create a `.env` file with your API configuration (for AI analysis)

4. Run the app
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── screens/         # UI screens (Dashboard, Transactions, AI Analysis, etc.)
├── models/          # Data models
├── services/        # Core services and repositories
├── view_models/     # Riverpod providers and state management
├── widgets/         # Reusable UI components
└── main.dart        # App entry point
```

## Key Features Explained

### AI Analysis
Upload your bank statement PDF and get AI-powered analysis including:
- Income source analysis
- Spending patterns
- Transaction categorization
- Financial recommendations

### Transaction Management
- View all transactions with details
- Filter by date ranges
- Track income vs. expenses

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is private and not currently licensed for public use.
