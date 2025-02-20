# README
# 🏗️ MyBasecamp - A Project Management Tool

## 🚀 Task - What is the problem? And where is the challenge?
Managing projects and team collaboration efficiently can be challenging. Existing tools like Basecamp provide great solutions, but sometimes, we need a custom implementation with specific features.

### 🎯 My Challenge
- Allow users to register, log in, and manage projects.  
- Provide a system where project members can upload attachments, post messages, and collaborate.  
- Ensure user roles (Admin & User) control permissions effectively.  
- Host the platform online for accessibility.

## 🔧 Description - How we solved the problem?
MyBasecamp was built using **Ruby on Rails**, with a **PostgreSQL database** and Bootstrap for a clean UI. I implemented:  

- User Authentication** (Sign up, Log in, Log out)  
- Role-based Permissions** (Admin/User)  
- Project Management** (Create, Edit, Delete projects)  
- Discussions & Threads** (Admins create threads, users post messages)  
- Attachments Support** (Upload PNG, JPG, PDF, TXT files)  
- Cloud Hosting** (For accessibility and scalability)  

## 💻 Installation Guide

1️ Clone the repository:**
    -git clone git@git.us.qwasar.io:my_basecamp_2_179396_xhmawi/my_basecamp_2.git 
    -cd mybasecamp
2️ Install dependencies:
    -bundle install
3️ Set up the database:
    -rails db:create
    -rails db:migrate
4️ Start the server:
    -rails server
Now, visit http://localhost:3000 in your browser! 🎉

## Usage TODO - How does it work?

1️ User Registration & Login
    -New users can sign up and log in.
    -Users must update their profile after signing up.
2️ Project Management
    -Users can create, edit, and delete projects.
    -Only the project owner can manage the project.
3️ Role-Based Access
    -Admins can create threads and manage users.
    -Users can participate in discussions and upload files.
4️ Discussion & Messaging
    -Inside each project, admins can create discussion threads.
    -Project members can post messages inside threads.
5️ File Attachments
    -Users can upload attachments (images, PDFs, text files).
    -Files are displayed in each project.
6️ Hosting
    -The platform is deployed in the cloud for easy access.

### The Core Team
IBRAHIM SANI IBRAHIM
Software Developer
Contact: lambairoro@gmail.com