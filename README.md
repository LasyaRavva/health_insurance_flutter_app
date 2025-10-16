# Health Insurance App

A comprehensive health insurance mobile application built with Flutter and Node.js.

## Features

- 🔐 **Authentication**: Login with mobile number/email/policy number via OTP or password
- 💳 **Insurance Card**: View digital insurance card
- 🛡️ **Coverage**: Check what's covered under your policy
- 📸 **Claims**: Submit claims with photo upload
- 🏥 **Hospitals**: Find nearby network hospitals

## Tech Stack

### Frontend

- **Flutter** - Cross-platform mobile development
- **Dart** - Programming language
- **Provider** - State management
- **HTTP** - API communication

### Backend

- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **Multer** - File upload handling

## Project Structure

```
health-insurance-app/
├── frontend/          # Flutter mobile app
│   ├── lib/
│   │   ├── screens/   # UI screens
│   │   ├── models/    # Data models
│   │   ├── services/  # API services
│   │   ├── styles/    # Themes & colors
│   │   └── widgets/   # Reusable widgets
│   └── pubspec.yaml
│
└── backend/           # Node.js API server
    ├── server.js      # Main server file
    ├── package.json   # Dependencies
    └── uploads/       # File uploads directory
```

## Setup Instructions

### Frontend Setup

1. **Install Flutter**: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

2. **Navigate to frontend directory**:

   ```bash
   cd frontend
   ```

3. **Install dependencies**:

   ```bash
   flutter pub get
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

### Backend Setup

1. **Install Node.js**: [Node.js Download](https://nodejs.org/)

2. **Navigate to backend directory**:

   ```bash
   cd backend
   ```

3. **Install dependencies**:

   ```bash
   npm install
   ```

4. **Start the server**:
   ```bash
   node server.js
   ```

Server will run on `http://localhost:3000`

## API Endpoints

- `POST /login` - Login with password
- `POST /send-otp` - Send OTP
- `POST /verify-otp` - Verify OTP
- `GET /users/:userId` - Get user details
- `GET /claims` - Get user claims
- `POST /claims` - Submit new claim
- `GET /hospitals` - Get nearby hospitals
- `GET /coverage/:userId` - Get coverage info

## Color Palette

- Primary Blue: `#007BFF`
- Primary Green: `#28A745`
- Primary Teal: `#20B2AA`
- Secondary Yellow: `#FFC107`
- Secondary Orange: `#FF9800`

## Screenshots

_(Add screenshots here)_

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

## Author

Created with ❤️ for health insurance management
