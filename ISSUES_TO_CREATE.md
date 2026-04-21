# New Features - Issues to Create

Based on comparison with Student-Clubs-Management-System, here are the new features to add:

---

## 1. User Authentication & Accounts

**Issue Title:** Implement user registration system
**Description:**
- Add user registration endpoint with email and password
- Store user credentials with BCrypt hashing
- Validate email format and password strength
- Handle duplicate email prevention
- Create user profile with first name, last name, and email

---

## 2. User Authentication & Accounts (Part 2)

**Issue Title:** Implement login and session management
**Description:**
- Add login endpoint with email/password validation
- Implement session-based authentication (JWT or server sessions)
- Add logout functionality
- Protect endpoints with authentication middleware
- Track user sessions with expiration

---

## 3. Role-Based Access Control

**Issue Title:** Implement role-based access control (RBAC)
**Description:**
- Create user roles: Admin and Regular Member
- Implement role-based authorization decorators/middleware
- Add admin dashboard endpoints accessible only to admins
- Restrict member management to admins only
- Add role-based navigation logic in frontend

---

## 4. Data Persistence Layer

**Issue Title:** Migrate from in-memory storage to database
**Description:**
- Set up SQLAlchemy ORM with SQLite/PostgreSQL
- Create database models for:
  - Users (email, password_hash, first_name, last_name, role)
  - Activities/Events (name, description, schedule, max_capacity)
  - Activity Categories
  - User Activity Registrations
  - Club Memberships (with roles)
- Add database migrations/alembic setup
- Replace in-memory activities dict with database queries

---

## 5. Club Management Feature

**Issue Title:** Add club creation and management endpoints
**Description:**
- Create Club model with name, description, category, contact_email
- Implement endpoints:
  - POST /clubs - Create new club (admin only)
  - GET /clubs - List all clubs with search/filter
  - GET /clubs/{id} - Get club details
  - PUT /clubs/{id} - Update club (admin only)
  - DELETE /clubs/{id} - Delete club (admin only)
- Add club listing to frontend with detail views

---

## 6. Club Member Management

**Issue Title:** Implement club membership and role assignment
**Description:**
- Create ClubMember model with user_id, club_id, member_role
- Support roles: President, Secretary, Member, etc.
- Implement endpoints:
  - POST /clubs/{id}/members - Add member to club (admin)
  - PUT /clubs/{id}/members/{user_id} - Update member role (admin)
  - DELETE /clubs/{id}/members/{user_id} - Remove member (admin)
  - GET /clubs/{id}/members - List club members
- Allow students to join clubs as regular members

---

## 7. Event Management Features

**Issue Title:** Expand activity model to separate Events from Activities
**Description:**
- Create Event model with:
  - name, description, club_id (foreign key)
  - date, start_time, end_time
  - max_capacity
  - category
  - created_at, updated_at timestamps
- Add event status calculation (Upcoming vs Ended) based on datetime
- Create separate /events endpoints:
  - POST /events - Create event (admin)
  - GET /events - List events with status filtering
  - GET /events?status=upcoming - Filter by status
  - PUT /events/{id} - Update event (admin)
  - DELETE /events/{id} - Delete event (admin)

---

## 8. Event Registration & Capacity Management

**Issue Title:** Implement event registration with capacity validation
**Description:**
- Create EventRegistration model
- Add capacity validation:
  - Check max_participants before allowing signup
  - Prevent double registration
  - Return informative error messages
- Add endpoints:
  - POST /events/{id}/register - Register for event
  - GET /events/{id}/participants - List registered participants
  - DELETE /events/{id}/register - Unregister from event
- Track registration timestamps

---

## 9. Search & Filter Functionality

**Issue Title:** Add comprehensive search and filtering
**Description:**
- Implement full-text search across:
  - Activity/Event names and descriptions
  - Club names and descriptions
- Add filter endpoints:
  - Filter by category (activity_type query param)
  - Filter events by status (upcoming/ended)
  - Filter clubs by type
  - Pagination support (limit/offset)
- Add search bar to frontend

---

## 10. Admin Dashboard - Activity Management

**Issue Title:** Create admin dashboard for managing activities/events
**Description:**
- Create admin endpoint: GET /admin/activities - returns table data with all fields
- Create admin endpoint: GET /admin/events - returns all events
- Create admin endpoint: GET /admin/clubs - returns all clubs
- Support CRUD operations from dashboard:
  - Edit/delete buttons with confirmation
  - Add new buttons
  - Display in table format with all relevant columns

---

## 11. Admin Dashboard - User Management

**Issue Title:** Create admin user management interface
**Description:**
- Create admin endpoint: GET /admin/users - returns all users with details
- Create admin endpoint: GET /admin/users/{id}/roles - view user roles
- Implement endpoints:
  - Change user role (upgrade/downgrade to admin)
  - View user registration and activity history
  - Delete user accounts (with confirmation)
- Create frontend admin table views

---

## 12. Input Validation & Security

**Issue Title:** Implement comprehensive input validation and sanitization
**Description:**
- Add Pydantic models for request validation:
  - Email format validation
  - Password strength requirements
  - Required field validation
  - Time validation (event end > event start + 20 min)
  - String length limits
- Add input sanitization (XSS prevention)
- Add SQL injection prevention (already handled by SQLAlchemy)
- Implement CORS security headers

---

## 13. User Experience - Personal Dashboard

**Issue Title:** Create user personal dashboard
**Description:**
- Create GET /dashboard endpoint showing user's:
  - Registered activities/events
  - Joined clubs
  - Upcoming events today/this week
- Add personalized greeting ("Welcome, John")
- Show registration status for browse activities
- Display "Already joined" indicators

---

## 14. User Experience - Responsive UI

**Issue Title:** Enhance frontend with Bootstrap and responsive design
**Description:**
- Integrate Bootstrap 5 CSS framework
- Update index.html with responsive navbar
  - Role-based navigation (different for admin vs member)
  - User greeting and logout button
  - Search bar in header
- Create responsive card layouts for activities/clubs/events
- Add modal dialogs for confirmations
- Implement status badge styling (Upcoming/Ended)
- Improve form styling and validation messages

---

## 15. Frontend - Admin Dashboard UI

**Issue Title:** Build admin dashboard interface
**Description:**
- Create new pages:
  - /admin/activities.html
  - /admin/events.html
  - /admin/clubs.html
  - /admin/users.html
- Add table views with columns:
  - Edit and Delete buttons
  - Search bars
  - Pagination controls
- Add modal forms for Create/Edit operations
- Add confirmation dialogs for deletions

---

## 16. Frontend - Activity Details & Registration

**Issue Title:** Enhanced activity detail page with registration
**Description:**
- Create activity detail modal/page showing:
  - Full description
  - Schedule with proper formatting
  - Capacity bar (current/max participants)
  - List of current participants (if admin)
  - Registration button or "Already registered" badge
- Add error messages for full activities
- Add success messages after registration

---

## 17. Frontend - Search and Filter UI

**Issue Title:** Add search and filter controls to front-end
**Description:**
- Add search bar in main header
- Add category filter dropdowns
- Add status filter for events (Upcoming/Ended)
- Implement real-time filtering
- Show result count
- Add "No results" messaging

---

## 18. Email System (Optional Enhancement)

**Issue Title:** Add email notifications for activities
**Description:**
- Send confirmation emails on registration
- Send activity reminders (day before)
- Send updates when activity details change
- Use SMTP/SendGrid for email delivery

---

## Quick Setup Notes

To implement these features, consider:

1. **Database Setup:** Choose SQLite for development, PostgreSQL for production
2. **Authentication:** Use JWT tokens with HTTPOnly cookies
3. **ORM:** Use SQLAlchemy for database abstraction
4. **Validation:** Use Pydantic for request validation
5. **Frontend:** Integrate Bootstrap, jQuery for DOM manipulation
6. **Testing:** Add unit tests for each endpoint

---

**Total Features:** 18 issues
**Dependency Chain:**
- Issues 1-2 must be done before 3
- Issues 4 must be done before 5-10
- Issues 9-17 can be parallel after 4
