Blogly Models Diagram:
-----------------------
       Users
  +-----------------+
  | id (PK)         |
  | first_name      |
  | last_name       |
  | email           |
  +-----------------+
           │
           │ 1-to-many
           ▼
       Posts
  +---------------------+
  | id (PK)             |
  | title               |
  | content             |
  | created_at          |
  | user_id (FK to Users)|
  +---------------------+
