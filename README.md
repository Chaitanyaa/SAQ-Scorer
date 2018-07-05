# SAQ Scorer
•	Automatic Assessment For Marking Student Short Answers Using NLP Techniques.<br/>
•	This project was to develop a basic application for the faculty and students on the lines of Short Answer Question scoring benefits.<br/>
•	It uses Natural Processing Languages (NLP) techniques to identify different types of variations in writing styles for a particular answer and score all kinds of answers on a same scale.<br/> 
•	This application leverages the research conducted in recent Natural Language Processing studies to provide a fair, timely and accurate assessment of student short-answers based on the semantic meaning of those answers.<br/>



# <a href = "http://saqscorer.azurewebsites.net/Final/">Automatic Assessment for Marking Student Short Answer</a><br/>
Click the above link !!.....<br/>
 
Depending on the login credential used the user is redirected either to admin interface or student interface.<br/>

# What Admin can do ?<br/>
Add students(Users Tab of admin interface)<br/>
Add questions along with answers to question bank(Tests Tab of admin interface)<br/>
Create a test with questions from question bank and assign them to any number of added students(Tests Tab of admin interface)<br/>
Note:To choose multiple questions/students from list box ------- hold Ctrl key and select.<br/>
Evaluate a created test after the student has attempted it(Tests Tab of admin interface)<br/>
View the created test: questions and students assigned to that test.(Tests Tab of admin interface)<br/>
View student wise scores report(Report Tab of admin interface)<br/>
# What Student can do ?<br/>
Choose a test which is assigned to him and attempt that test.<br/>
View the score of the chosen test after the test has been attempted and evaluated by the admin.<br/>

# Following questions with answers have already been added:<br/>
Can add more questions & answers through tests tab of admin interface. <br/>

1.What is a Variable ?<br/>
Variable is a location in memory that can store values<br/>
2.What is a Pointer ?<br/>
A pointer is a variable that holds the address of another variable.<br/>
3.What is function signature ?<br/>
A function signature is a declaration of the function that includes the parameter types and the number of parameters.<br/>
4.What is function pointer ?<br/>
A function pointer is a pointer that contains the address of the function in memory.<br/>


# 10 Simple Steps to complete a cycle of sample test:<br/>
Login as an admin(i.e Username:Chaitanya,Password:password)<br/>
Click Add test (Tests Tab---> Add test----> provide a test name and choose questions and students from list boxes)<br/>
Note:To choose multiple questions/students from list box ------- hold Ctrl key and select.<br/>
Verify the created test by clicking View Test (Tests Tab-->Choose test---->View Test)<br/>
Login as a student(i.e Username:user1,Password:pass1)<br/>
Choose the test assigned to him and click Take test(write the answers and submit)<br/>
Repeat the steps 4 & 5 with all the assigned students of that particular test.<br/>
Now again Login as an admin(i.e Username:Chaitanya,Password:password)<br/>
Choose the test name and click Evaluate test (After ensuring all the assigned students have taken the test--->Tests Tab---> Evaluate test)<br/>
View the score report of all students by going to the reports tab of admin interface.<br/>
Each student can login back to check their individual scores by clicking View score.<br/>

# Core logic.<br/>
Sample Input: “The QUIck brown fox! jumped over@ the, lazy Lazy dog”<br/>
Output Canonical form array: [brown:a, dog:n, fox:n, jump:v, lazy:a, quick:a]<br/>
Note: v=verb a=adjective n=noun<br/>
The model answer and student answer is first pre-processed like above and are compared for an exact match.<br/>
An exact match is determined based on:<br/>
a) A matching parts-of-speech tag<br/>
b) A word match<br/>
The summation of distance between the corresponding parts-of speech match words of student's and model answer is calculated and<br/> subtracted from 5.So,the score is given on the scale of 0-5.<br/>
Distance between two similar words is 0.<br/>


Note:There is a limitation to the cloud storage space and also the application is not secure.(As they weren't my primary concerns for project)<br/>
