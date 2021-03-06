

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->


![Little Esty Shop](/public/navbar.png)
<!-- TABLE OF CONTENTS -->
<summary><h2 style="display: inline-block">Table of Contents</h2></summary>
<ol>
  <li><a href="#about-the-project">About The Project</a>
  <li><a href="#database-schema">Database Schema</a></li>
  <li><a href="#built-with">Built With</a>
  <li><a href="#setup-instructions">Setup Instructions</a></li>
  <li><a href="#contact">Contact</a></li>
  <li><a href="#acknowledgements">Acknowledgements</a></li>
</ol>

<!-- ABOUT THE PROJECT -->
## About The Project

[Little Esty Shop](https://ancient-lake-50367.herokuapp.com/) is a Brownfield solo project for Turing School of Software & Design's Back-End Engineering (BEE) program. Little Esty Shop is a twist on a popular e-commerce site where merchants and admins can manage inventory and fulfill customer invoices.

User stories tracked using [Github projects](https://backend.turing.edu/module2/projects/bulk_discounts).


### Skills Developed by Project
* Designed schema with custom rake task for database seeding
* Used advanced ActiveRecord to perform multiple complex database queries
* Utilized advanced routing for efficient and organized routing  
* Practiced MVC concepts, effectively staying within rails conventions
* Consumed github API
* Deployed application on [Heroku](https://powerful-eyrie-55286.herokuapp.com/)

<!-- PROJECT BOARD -->
## Project Board

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

<!-- DATABBASE SCHEMA -->
## Database Schema

## Schema
![Database schema](https://i.ibb.co/xFpfMXp/Screen-Shot-2021-04-18-at-11-26-40-PM.png)


<!-- BUILT WITH -->
## Built With

* [Ruby on Rails](https://rubyonrails.org/)
* [Postgresql](https://www.postgresql.org/)


<!-- SETUP INSTRUCTIONS -->
## Setup Instructions
To get a local copy up and running follow these simple steps.

1. Clone the repo
   ```
   git clone https://github.com/brisag/little_esty_shop_bulk_discounts
   ```
2. Install dependencies
   ```
   bundle install
   ```
3. DB creation/migration
   ```
   rails db:create
   rails db:migrate
   rails db:seed
   ```
3. Run tests and view test coverage
   ```
   bundle exec rspec
   open coverage/index.html
   ```
4. Run server and navigate to http://localhost:3000/
   ```
   rails s
   ```

OR

1. Visit heroku
   ```
   https://ancient-lake-50367.herokuapp.com/
   ```


<!-- CONTACT -->
## Contact

* [Brisa Garcia](https://github.com/brisag)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [README template](https://github.com/othneildrew/Best-README-Template)
* [Turing School of Software & Design Project Repo](https://github.com/turingschool-examples/little-esty-shop)
