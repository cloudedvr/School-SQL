Blogly Routes Diagram:
-----------------------
GET /users/<user_id>
    → User Detail Page (shows user info and their posts)
      └─ "Add New Post" button

GET /users/<user_id>/posts/new
    → New Post Form

POST /users/<user_id>/posts/new
    → Create Post, then redirect to User Detail Page

GET /posts/<post_id>
    → Post Detail Page (with Edit and Delete options)

GET /posts/<post_id>/edit
    → Edit Post Form

POST /posts/<post_id>/edit
    → Update Post, then redirect to Post Detail Page

POST /posts/<post_id>/delete
    → Delete Post, then redirect to User Detail Page
