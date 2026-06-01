# DBMS-Based Customer Billing Management System

A comprehensive web application for managing customer billing records for pump and agricultural service management.

## 📋 Project Overview

This system provides a secure, user-friendly platform for storing, updating, and managing customer information and billing details. It simplifies billing management, reduces manual record-keeping, and improves accuracy through database-driven operations.

## ✨ Key Features

### Customer Management
- ✅ Add, update, and delete customer records
- ✅ Store customer details (name, phone, land area, pump usage time)
- ✅ Search and filter customer data
- ✅ Payment status tracking

### Billing Management
- ✅ Automatic bill calculation
- ✅ Billing history tracking
- ✅ Payment status management
- ✅ PDF bill generation

### Admin Dashboard
- ✅ Secure login authentication
- ✅ View billing summary and analytics
- ✅ Generate reports and summaries
- ✅ Data management interface

### Additional Features
- ✅ Responsive and mobile-friendly design
- ✅ User-friendly navigation
- ✅ Data backup and recovery system
- ✅ Secure database management

## 🛠 Technology Stack

| Component | Technology |
|-----------|-----------|
| **Frontend** | HTML5, CSS3, JavaScript, Bootstrap 5 |
| **Backend** | Node.js with Express (or PHP/Django alternative) |
| **Database** | MySQL/PostgreSQL |
| **Authentication** | JWT / Session-based Admin Login |
| **PDF Generation** | jsPDF / ReportLab |
| **Server** | Apache/Nginx |

## 📁 Project Structure

```
DBMS-Customer-Billing/
├── backend/                    # Backend application
│   ├── config/                # Configuration files
│   ├── controllers/           # Request handlers
│   ├── models/               # Data models
│   ├── routes/               # API routes
│   ├── middleware/           # Authentication & validation
│   ├── utils/                # Utility functions
│   ├── .env.example          # Environment variables template
│   ├── server.js             # Entry point
│   └── package.json          # Dependencies
├── frontend/                  # Frontend application
│   ├── assets/               # Images, icons, fonts
│   ├── css/                  # Stylesheets
│   ├── js/                   # JavaScript files
│   ├── pages/                # HTML pages
│   │   ├── index.html
│   │   ├── login.html
│   │   ├── dashboard.html
│   │   ├── customers.html
│   │   ├── billing.html
│   │   └── reports.html
│   └── README.md
├── database/                  # Database files
│   ├── schema.sql            # Database schema
│   ├── sample_data.sql       # Sample data
│   └── backups/              # Backup files
├── docs/                      # Documentation
│   ├── API_DOCUMENTATION.md  # API endpoints
│   ├── DATABASE_SCHEMA.md    # Database design
│   ├── SETUP_GUIDE.md        # Installation guide
│   └── USER_GUIDE.md         # User manual
├── .gitignore
├── .env.example
├── CONTRIBUTING.md
└── README.md
```

## 🚀 Quick Start

### Prerequisites
- Node.js (v14 or higher)
- MySQL/PostgreSQL
- Git
- npm or yarn

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/Kartik-patra-dev/DBMS-Customer-Billing.git
cd DBMS-Customer-Billing
```

2. **Backend Setup**
```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your database credentials
npm start
```

3. **Frontend Setup**
```bash
cd ../frontend
# Open index.html in your browser or use a local server
# For development: python -m http.server 8000
```

4. **Database Setup**
```bash
# Import schema.sql into your MySQL/PostgreSQL database
mysql -u root -p your_database < database/schema.sql
```

## 📚 Documentation

- [API Documentation](docs/API_DOCUMENTATION.md) - REST API endpoints
- [Database Schema](docs/DATABASE_SCHEMA.md) - Database design
- [Setup Guide](docs/SETUP_GUIDE.md) - Detailed installation instructions
- [User Guide](docs/USER_GUIDE.md) - How to use the system

## 🔐 Security Features

- Secure admin login with password hashing (bcrypt)
- JWT token-based authentication
- Input validation and sanitization
- SQL injection prevention
- CSRF protection
- Session management

## 📊 Database Schema

The system uses the following main tables:
- **users** - Admin accounts
- **customers** - Customer information
- **billing** - Billing records
- **payments** - Payment tracking

See [DATABASE_SCHEMA.md](docs/DATABASE_SCHEMA.md) for detailed schema.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details.

## 📝 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

**Kartik Patra**
- GitHub: [@Kartik-patra-dev](https://github.com/Kartik-patra-dev)

## 📞 Support

For issues, questions, or suggestions, please open an [issue](https://github.com/Kartik-patra-dev/DBMS-Customer-Billing/issues) on GitHub.

## 🗓 Project Timeline

- [x] Project initialization
- [ ] Database schema design
- [ ] Backend API development
- [ ] Frontend development
- [ ] Authentication system
- [ ] Testing
- [ ] Deployment
- [ ] Documentation

---

**Last Updated**: June 1, 2026
