# 📚 Social Library Management System (MySQL)

A relational database designed to manage a library's inventory, member registrations, and loan tracking.

## 🚀 Features
- **Normalization:** Separated Authors, Categories, and Members to ensure data integrity.
- **Automated Tracking:** Uses SQL Views to monitor active loans and overdue items.
- **Scalability:** Indexed search columns for high-performance querying.

## 🗺️ Database Schema
![Database Diagram](./diagram.png) *(Upload your Workbench PNG here!)*

## 🛠️ How to Use<img width="726" height="494" alt="db_schema_v1" src="https://github.com/user-attachments/assets/538d469e-e988-420e-9451-eff2f8917510" />

1. Run `schema.sql` to build the structure.
2. Run `seed_data.sql` to populate sample data.
3. Use the `active_loans` view to see current library status.

## 📊 Key Queries
The project includes advanced queries covering:
- Multi-table Inner/Left Joins
- Conditional Logic using `CASE`
- Data aggregation for library analytics
