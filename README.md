# Gokul Mess Management System

A comprehensive, real-time mess management solution designed to streamline operations for mess owners and provide a seamless experience for students.

## 🚀 Key Features

### For Mess Owners
- **Real-time "No-Lag" Dashboard**: Monitor daily meal consumption (Lunch/Dinner) instantly.
- **Student Management**: View and manage student profiles, including contact details and subscription status.
- **Analytics**: Visual insights into daily consumption trends and financial metrics tailored for mess operations.
- **Manual Verification**: Quick verification system for student check-ins.
- **Settings & Configuration**: Manage mess rules, pricing, and operational parameters.

### For Students
- **Personalized Portal**: View meal history, check subscription status, and manage profile details.
- **Leave Management**: Apply for leaves directly through the app to adjust billing automatically.
- **Parcel Collection**: Secure OTP-based system for collecting parcels.
- **Transaction History**: Transparent view of all payments and dues.

## 🛠️ Technology Stack

- **Framework**: [Next.js](https://nextjs.org) (App Router)
- **Language**: [TypeScript](https://www.typescriptlang.org)
- **Styling**: [Tailwind CSS v4](https://tailwindcss.com), [Shadcn UI](https://ui.shadcn.com) for components.
- **State Management**: [Zustand](https://github.com/pmndrs/zustand) for client-side state.
- **Backend & Database**: [Supabase](https://supabase.com) (PostgreSQL, Auth, Realtime, Storage).
- **Data Fetching**: [TanStack Query](https://tanstack.com/query/latest) for efficient server state management.
- **Icons**: [Lucide React](https://lucide.dev).
- **Charts**: [Recharts](https://recharts.org) for data visualization.

---

## 🏁 Getting Started

Follow these steps to set up the project locally.

### Prerequisites
- Node.js & pnpm installed.
- A [Supabase](https://supabase.com) project created.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/mess-management-system.git
    cd mess-management-system
    ```

2.  **Install dependencies:**
    ```bash
    pnpm install
    ```

3.  **Environment Configuration:**
    Create a `.env` file in the root directory and add your Supabase credentials:
    ```env
    NEXT_PUBLIC_SUPABASE_URL=your_project_url_here
    NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=your_publishable_key_here
    ```

4.  **Database Setup:**
    - Go to your Supabase SQL Editor.
    - Run the contents of `supabase/schema.sql` to create the necessary tables and policies.
    - (Optional) Run other migration files in `supabase/` if needed for triggers or initial data.

5.  **Run the development server:**
    ```bash
    pnpm dev
    ```
    Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## 📂 Project Structure

```
├── app/                  # Next.js App Router pages
│   ├── auth/             # Authentication routes
│   ├── owner/            # Owner dashboard & features
│   ├── student/          # Student portal & features
│   └── login/            # Login page
├── components/           # React components
│   ├── ui/               # Reusable Shadcn UI components
│   └── owner/            # Owner-specific complex components
├── hooks/                # Custom React hooks (TanStack Query)
├── lib/                  # Utility functions & Supabase client
├── store/                # Zustand state stores
├── supabase/             # Database schema, migrations, and types
├── public/               # Static assets
└── types/                # TypeScript type definitions
```

## 🗄️ Database Schema Overview

The system uses a relational database model tailored for mess operations:

- **Users**: Stores student/owner profiles, extending Supabase Auth.
- **Daily Logs**: Tracks daily meal consumption (Lunch/Dinner) with status (Consumed, Skipped, Leave).
- **Leaves**: Manages student leave requests and subscription pauses.
- **Transactions**: Records payments and financial transactions.
- **Parcel OTPs**: Handles secure parcel collection verification.

## 🤝 Contribution

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the [MIT License](LICENSE).
