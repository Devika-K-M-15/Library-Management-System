CREATE DATABASE Library;
USE library;

CREATE TABLE Branch(Branch_no INT PRIMARY KEY,
                    Manager_Id INT,
                    Branch_address VARCHAR(30),
                    Contact_no BIGINT NOT NULL);
                    
INSERT INTO Branch VALUES(1, 101, 'Guruvayoor', 9898464645),
						 (2,  102, 'Irinjalakuda', 7474296961),
                         (3,  103, 'Thriprayar', 1414254548),
                         (4,  104, 'Chembukkav', 9797864623),
                         (5,  105, 'Thrissur', 8787132321);
                         
                         
CREATE TABLE Employee(Emp_id INT PRIMARY KEY,
                      Emp_name VARCHAR(20) NOT NULL,
                      Position VARCHAR(20),
					  Salary INT);
                                              
INSERT INTO Employee VALUES(101, 'employee1', 'Manager', 80000),
						 (102, 'employee2', 'Clerck', 40000),
                         (103, 'employee3', 'Accountant', 45000),
                         (104, 'employee4', 'Librarian', 60000),
                         (105, 'employee5', 'Assistant Librarian', 20000);                        
             
             
CREATE TABLE Customer(Customer_id INT PRIMARY KEY AUTO_INCREMENT,
				      Customer_name VARCHAR(20) NOT NULL,
                      Customer_address VARCHAR(30) NOT NULL,
                      Reg_date DATE NOT NULL);

INSERT INTO Customer VALUES(201, 'Rithwika', 'Rithu Home', '2019-03-16'),
						   (202, 'Vaigha', 'Vaigha Home', '2019-09-17'),
                           (203, 'Vaamik', 'Vaamik Home', '2022-07-06'),
                           (204, 'Sharun', 'Sharun Home', '2022-09-16'),
                           (205, 'Resmi', 'Resmi Home', '2019-09-05'),
                           (206, 'Sajin', 'Sajin Home', '2019-08-14'),
                           (207, 'Sooraj', 'Sooraj Home', '2022-01-04'),
                           (208, 'Irin', 'Irin Home', '2022-09-10'); 
                           
CREATE TABLE Books(ISBN BIGINT PRIMARY KEY,
                   Book_title VARCHAR(50) NOT NULL,
                   Category VARCHAR(20) NOT NULL,
				   Rental_price FLOAT, 
                   Status VARCHAR(20),
                   Author VARCHAR(50) NOT NULL,
                   Publisher VARCHAR(50)  NOT NULL);

INSERT INTO Books VALUES
    (9780771038518, 'Sapiens', 'Non-fiction', 125, 'Yes', 'Yuval Noah Harari', 'Dvir Publishing house Israel'),
    (9781786330895, 'Ikigai', 'Self-Help', 130, 'No', 'Hector Garcia and Francesc Miralles', 'Penguin Random House'),
    (9780735211292, 'Atomic habits', 'Self-Help', 140, 'No', 'James Clear', 'Random House Business Books'),
    (9781612680194, 'Rich dad Poor dad', 'Non-fiction', 120, 'No', 'Robert and Sharon', 'Plata publishing'),
    (9781566196048, 'Sherlock Holmes', 'fiction',180, 'Yes', 'Arthur Conan doyle', 'george newnes'),
    (9788173711466, 'Wings of Fire', 'Autobiography', 200,  'Yes', 'Dr. APJ Abdul Kalam', 'Universities Press'),
    (9780684858395, 'The 7 habits of Highly effective People', 'Self-Help', 135, 'Yes', 'Stephen Covey', 'Simon and Schuser'),
    (9781857023992, 'The Motorcycle Diaries', 'Autobiography', 220, 'Yes', 'Che Guvera', 'Harper Perennial'),
    (9780143029670, 'In The Name of Democracy', 'History', 155, 'Yes', 'Bipan Chandra', 'Penguin Books');
    
CREATE TABLE IssueStatus(Issue_id INT PRIMARY KEY,
                         Issued_cust INT UNIQUE,
                         Issue_book_name VARCHAR(50) NOT NULL,
                         Issue_date DATE NOT NULL,
                         isbn_book BIGINT UNIQUE,
                         FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_id),
                         FOREIGN KEY (isbn_book) REFERENCES Books(ISBN));
                         
INSERT INTO IssueStatus VALUES(11, 201, 'Rich dad Poor dad', '2023-06-05', 9781612680194),
						      (12, 203, 'Sapiens', '2023-04-15', 9780771038518),
							  (13, 205, 'Atomic habits', '2023-03-16', 9780735211292),
                              (14, 207, 'The Motorcycle Diaries', '2023-01-04', 9781857023992),
                              (15, 208, 'Ikigai', '2023-07-10', 9781786330895);

CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY,
                          Return_cust INT NOT NULL,
                          Return_book_name VARCHAR(50),
                          Return_date DATE,
                          isbn_book2 BIGINT NOT NULL,
                          FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_id),
                          FOREIGN KEY (isbn_book2) REFERENCES Books(ISBN));

INSERT INTO ReturnStatus VALUES(301, 207, 'The Motorcycle Diaries', '2023-05-05', 9781857023992),
							   (302, 203, 'Sapiens', '2023-06-15', 9780771038518);

    


-- 1. Retrieve the book title, category, and rental price of all available
-- books.
SELECT Book_title, Category, Rental_price FROM Books WHERE Status = 'Yes';

-- 2. List the employee names and their respective salaries in descending
-- order of salary.
SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have
-- issued those books.
SELECT Customer.Customer_name,  IssueStatus.Issue_book_name FROM Customer LEFT JOIN IssueStatus
ON Customer.Customer_id=IssueStatus.Issued_cust
WHERE Issue_id IS NOT NULL;

-- 4. Display the total count of books in each category.
SELECT Category,count(ISBN) FROM books GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees
-- whose salaries are above Rs.50,000.
SELECT Emp_name, Position FROM Employee WHERE salary >50000;

-- 6. List the customer names who registered before 2022-01-01 and have 
-- not issued any books yet.
SELECT Customer_name FROM customer LEFT JOIN IssueStatus
ON Customer.Customer_id=IssueStatus.Issued_cust
WHERE Issue_id IS NULL AND Reg_date<'2022-01-01';

-- 7. Display the branch numbers and the total count of employees in each
-- branch.
SELECT Branch.Branch_no,  count(Employee.Emp_name) FROM Branch LEFT JOIN Employee
ON Branch.Manager_Id=Employee.Emp_id GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month
-- of June 2023.
SELECT DISTINCT(Customer_name) FROM Customer LEFT JOIN IssueStatus 
ON Customer.Customer_id=IssueStatus.Issued_cust
WHERE monthname(IssueStatus.Issue_date)='June' AND year(IssueStatus.Issue_date)='2023';

-- 9. Retrieve book_title from book table containing history.
SELECT Book_title FROM Books WHERE Category = 'History';

-- 10.Retrieve the branch numbers along with the count of employees for
-- branches having more than 5 employees.
SELECT Branch.Branch_no,  count(Employee.Emp_name) FROM Branch LEFT JOIN Employee
ON Branch.Manager_Id=Employee.Emp_id  GROUP BY Branch_no HAVING count(Employee.Emp_name)>5;






