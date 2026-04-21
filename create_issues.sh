#!/bin/bash

# GitHub Issue Creator Script
# Creates all issues defined in ISSUES_TO_CREATE.md

# Set your repository info
OWNER="josejimenezpar"
REPO="skills-integrate-mcp-with-copilot"
GITHUB_TOKEN="${GITHUB_TOKEN}"  # Set this environment variable with your GitHub personal access token

# Check if token is set
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set"
    echo "Please set it with: export GITHUB_TOKEN='your_token_here'"
    exit 1
fi

# Function to create an issue
create_issue() {
    local title="$1"
    local body="$2"
    local labels="$3"
    
    curl -s -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        https://api.github.com/repos/$OWNER/$REPO/issues \
        -d "{
            \"title\": \"$title\",
            \"body\": \"$body\",
            \"labels\": [$labels]
        }" | jq -r '.html_url'
}

echo "Creating GitHub Issues for $OWNER/$REPO..."
echo ""

# Issue 1: User Registration
create_issue \
    "Implement user registration system" \
    "## Description\n- Add user registration endpoint with email and password\n- Store user credentials with BCrypt hashing\n- Validate email format and password strength\n- Handle duplicate email prevention\n- Create user profile with first name, last name, and email\n\n## Acceptance Criteria\n- POST /register endpoint accepts email, password, first_name, last_name\n- Passwords are hashed using BCrypt\n- Duplicate emails return 409 Conflict\n- All form fields are validated\n- User profiles are stored in database" \
    "\"enhancement\", \"backend\""

# Issue 2: Login and Session Management
create_issue \
    "Implement login and session management" \
    "## Description\n- Add login endpoint with email/password validation\n- Implement session-based authentication (JWT or server sessions)\n- Add logout functionality\n- Protect endpoints with authentication middleware\n- Track user sessions with expiration\n\n## Acceptance Criteria\n- POST /login endpoint with email and password\n- Returns authentication token/session cookie\n- POST /logout clears session\n- Protected endpoints return 401 if not authenticated\n- Sessions expire after configured duration" \
    "\"enhancement\", \"backend\""

# Issue 3: Role-Based Access Control
create_issue \
    "Implement role-based access control (RBAC)" \
    "## Description\n- Create user roles: Admin and Regular Member\n- Implement role-based authorization decorators/middleware\n- Add admin dashboard endpoints accessible only to admins\n- Restrict member management to admins only\n- Add role-based navigation logic in frontend\n\n## Acceptance Criteria\n- Users have role (admin or member)\n- Admin-only endpoints return 403 for non-admin users\n- Frontend shows different navigation based on role\n- Admin dashboard is protected\n- Member operations don't expose admin features" \
    "\"enhancement\", \"backend\", \"frontend\""

# Issue 4: Database Migration
create_issue \
    "Migrate from in-memory storage to database" \
    "## Description\n- Set up SQLAlchemy ORM with SQLite/PostgreSQL\n- Create database models for Users, Activities, Clubs, Registrations\n- Add database migrations/alembic setup\n- Replace in-memory activities dict with database queries\n\n## Database Models Needed\n- User (email, password_hash, first_name, last_name, role)\n- Activity (name, description, schedule, max_capacity, category)\n- Club (name, description, category, contact_email)\n- ActivityRegistration (user_id, activity_id)\n- ClubMembership (user_id, club_id, member_role)\n\n## Acceptance Criteria\n- Data persists across server restarts\n- All queries use SQLAlchemy\n- Database migrations are tracked\n- No hardcoded data in code" \
    "\"enhancement\", \"backend\", \"database\""

# Issue 5: Club Management
create_issue \
    "Add club creation and management endpoints" \
    "## Description\n- Create Club model with name, description, category, contact_email\n- Implement CRUD endpoints for clubs (admin only)\n- Add club listing to frontend\n\n## Endpoints\n- POST /clubs - Create new club (admin only)\n- GET /clubs - List all clubs with search/filter\n- GET /clubs/{id} - Get club details\n- PUT /clubs/{id} - Update club (admin only)\n- DELETE /clubs/{id} - Delete club (admin only)\n\n## Acceptance Criteria\n- Only admins can create/update/delete clubs\n- All clubs persisted to database\n- Search works by name and description" \
    "\"enhancement\", \"backend\""

# Issue 6: Club Member Management
create_issue \
    "Implement club membership and role assignment" \
    "## Description\n- Create ClubMember model with user_id, club_id, member_role\n- Support member roles: President, Secretary, Member\n- Implement member management endpoints\n- Allow students to join clubs\n\n## Endpoints\n- POST /clubs/{id}/members - Add member (admin)\n- PUT /clubs/{id}/members/{user_id} - Update role (admin)\n- DELETE /clubs/{id}/members/{user_id} - Remove (admin)\n- GET /clubs/{id}/members - List members\n- POST /clubs/{id}/join - Student joins club\n\n## Acceptance Criteria\n- Members have assignable roles within clubs\n- Only one President per club\n- Students can request to join clubs\n- Admin can approve/deny memberships" \
    "\"enhancement\", \"backend\""

# Issue 7: Event Management
create_issue \
    "Expand activity model to separate Events from Activities" \
    "## Description\n- Create Event model with date, time, capacity info\n- Add event status calculation (Upcoming vs Ended)\n- Create separate /events endpoints\n\n## Event Model Fields\n- name, description, club_id\n- date, start_time, end_time\n- max_capacity, category\n- created_at, updated_at\n\n## Endpoints\n- POST /events - Create (admin)\n- GET /events - List with filtering\n- GET /events?status=upcoming - Filter by status\n- PUT /events/{id} - Update (admin)\n- DELETE /events/{id} - Delete (admin)\n\n## Acceptance Criteria\n- Event status auto-calculated\n- Events can be filtered by category\n- All events stored in database\n- Timestamps tracked" \
    "\"enhancement\", \"backend\""

# Issue 8: Event Registration & Capacity
create_issue \
    "Implement event registration with capacity validation" \
    "## Description\n- Add capacity validation to event registrations\n- Prevent duplicate registrations\n- Track event registrations\n\n## Endpoints\n- POST /events/{id}/register - Register with validation\n- GET /events/{id}/participants - List registered participants\n- DELETE /events/{id}/register - Unregister\n\n## Acceptance Criteria\n- Registration fails if capacity reached\n- User can't register twice for same event\n- Clear error messages returned\n- Current participant count tracked" \
    "\"enhancement\", \"backend\""

# Issue 9: Search & Filter
create_issue \
    "Add comprehensive search and filtering" \
    "## Description\n- Implement full-text search across names and descriptions\n- Add filtering by category, status\n- Support pagination\n\n## Features\n- Search activities, events, clubs\n- Filter by category\n- Filter events by status (upcoming/ended)\n- Pagination with limit/offset\n- Search bar in frontend\n\n## Acceptance Criteria\n- Search works across multiple fields\n- Filters can be combined\n- Results are paginated\n- Response times acceptable" \
    "\"enhancement\", \"backend\", \"frontend\""

# Issue 10: Admin Dashboard - Activities
create_issue \
    "Create admin dashboard for managing activities and events" \
    "## Description\n- Create admin endpoints for viewing/managing activities and events\n- Return data in table format\n- Support CRUD operations\n\n## Endpoints\n- GET /admin/activities - Table data\n- GET /admin/events - Table data\n- GET /admin/clubs - Table data\n\n## Acceptance Criteria\n- Accessible only to admins\n- Returns all necessary fields for display\n- Supports sorting/filtering\n- Response format suitable for tables" \
    "\"enhancement\", \"backend\""

# Issue 11: Admin Dashboard - User Management
create_issue \
    "Create admin user management interface" \
    "## Description\n- Create endpoints for user management\n- View all users with details\n- Manage user roles\n\n## Endpoints\n- GET /admin/users - List all users\n- GET /admin/users/{id} - User details\n- PUT /admin/users/{id}/role - Change role\n- DELETE /admin/users/{id} - Delete user\n\n## Acceptance Criteria\n- Only admins can access\n- Can view all user information\n- Can promote/demote users to/from admin\n- User deletion requires confirmation" \
    "\"enhancement\", \"backend\""

# Issue 12: Input Validation & Security
create_issue \
    "Implement comprehensive input validation and sanitization" \
    "## Description\n- Add Pydantic models for request validation\n- Validate all user inputs\n- Add security headers\n\n## Validation Requirements\n- Email format validation\n- Password strength (min 8 chars, etc)\n- Required fields\n- Event time validation (end > start + 20 min)\n- String length limits\n- Input sanitization (XSS prevention)\n\n## Acceptance Criteria\n- All endpoints validate inputs\n- Invalid data returns 400 with clear messages\n- XSS attempts are prevented\n- SQL injection prevented (via SQLAlchemy)\n- CORS headers configured" \
    "\"enhancement\", \"backend\", \"security\""

# Issue 13: User Personal Dashboard
create_issue \
    "Create user personal dashboard" \
    "## Description\n- Show user's registered activities and events\n- Display joined clubs\n- Personalized greeting\n\n## Endpoint\n- GET /dashboard - User's personal view\n\n## Content\n- Registered activities/events\n- Joined clubs with roles\n- Upcoming events for this week\n- \"Already joined\" indicators in activity lists\n\n## Acceptance Criteria\n- Shows personalized greeting\n- Displays user's data only\n- Updates when user registers/joins\n- Responsive design" \
    "\"enhancement\", \"backend\", \"frontend\""

# Issue 14: Responsive UI with Bootstrap
create_issue \
    "Enhance frontend with Bootstrap and responsive design" \
    "## Description\n- Integrate Bootstrap 5 framework\n- Create responsive navbar with role-based navigation\n- Improve overall UI/UX\n\n## Components\n- Responsive navbar with user greeting and logout\n- Search bar in header\n- Bootstrap card layouts\n- Modal dialogs for confirmations\n- Status badges (Upcoming/Ended)\n- Form styling and validation messages\n\n## Acceptance Criteria\n- Mobile-responsive design\n- Bootstrap integrated\n- Navigation changes based on role\n- Forms have proper styling\n- Consistent styling throughout" \
    "\"enhancement\", \"frontend\""

# Issue 15: Admin Dashboard UI
create_issue \
    "Build admin dashboard interface" \
    "## Description\n- Create admin panel with multiple pages\n- Table views for activities, events, users, clubs\n- CRUD operation modals\n\n## Pages\n- /admin/activities.html - Manage activities\n- /admin/events.html - Manage events\n- /admin/clubs.html - Manage clubs\n- /admin/users.html - Manage users\n\n## Features\n- Table views with sortable columns\n- Edit/Delete buttons\n- Create new modal forms\n- Search and filter controls\n- Pagination\n- Confirmation dialogs\n\n## Acceptance Criteria\n- All CRUD operations functional\n- Admin-only accessible\n- Responsive design\n- Confirmation on destructive actions" \
    "\"enhancement\", \"frontend\""

# Issue 16: Activity Details & Registration UI
create_issue \
    "Enhanced activity detail page with registration" \
    "## Description\n- Create detailed activity/event view\n- Show all relevant information\n- Registration button with validation\n\n## Content\n- Full description\n- Formatted schedule\n- Capacity bar (current/max)\n- Current participants list\n- Registration button or status badge\n- Error messages for full activities\n- Success messages after registration\n\n## Acceptance Criteria\n- All activity details displayed\n- Registration button works\n- Proper error handling\n- Success messages shown\n- Can't register if full" \
    "\"enhancement\", \"frontend\""

# Issue 17: Search and Filter UI
create_issue \
    "Add search and filter controls to front-end" \
    "## Description\n- Add interactive search and filtering\n- Real-time results updating\n- Filter controls in UI\n\n## Features\n- Search bar in header (main activities)\n- Category filter dropdown\n- Status filter for events (Upcoming/Ended)\n- Real-time filtering\n- Result count display\n- \"No results\" messaging\n\n## Acceptance Criteria\n- Search works across multiple fields\n- Filters work independently and combined\n- Results update in real-time\n- Clear UX for no results state" \
    "\"enhancement\", \"frontend\""

# Issue 18: Email Notifications (Optional)
create_issue \
    "Add email notifications for activities" \
    "## Description (Optional Enhancement)\n- Send confirmation emails on registration\n- Send activity reminders\n- Send notifications on activity changes\n\n## Features\n- Confirmation email on registration\n- Reminder email 24 hours before activity\n- Update notifications if activity changes\n- Use SMTP or SendGrid\n\n## Acceptance Criteria\n- Emails sent on registration\n- Emails include activity details\n- Configuration for email settings\n- Error handling for email failures" \
    "\"enhancement\", \"backend\", \"optional\""

echo ""
echo "✓ Issues created successfully!"
echo "View them at: https://github.com/$OWNER/$REPO/issues"
