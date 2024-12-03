Login Automation with Robot Framework

This repository contains automation test cases for login functionality using Robot Framework, which simulates different login scenarios and tests the system's behavior. The tests cover a range of login cases and api cases.


Tools & Technologies
1. Robot Framework
2. Selenium Library
3. Browser: Chrome
4. Robot Framework Report
   
Setup Instructions
1. Install Robot Framework
To begin using Robot Framework, install it using pip:
pip install robotframework

3. Install Selenium Library for Robot Framework
Install the SeleniumLibrary to interact with web elements:
pip install robotframework-seleniumlibrary

3. Install WebDriver
For web automation, you'll need a WebDriver for your browser. Here we use Chrome WebDriver.
Download the latest version of ChromeDriver from: https://sites.google.com/a/chromium.org/chromedriver/
Ensure that the chromedriver.exe is in your system's PATH or specify the full path in the test.

5. Directory Structure
The project follows the structure below:
/TAQTICS - ASSIGNMENT
    ├── /API TESTING
        ├── api_test.robot
        ├── results
        ├── requirements.txt
    ├── /images
    ├── /LOGIN automation
        ├── login_test.robot
        ├── /results
        ├── /requirements.txt
            
5. Required Files
login_test.robot: Contains the test cases for the login functionality.
keywords.robot: Contains custom keywords used across the test cases.
results/: Directory where the test execution results (including the HTML report) are stored.


To run the tests, follow these steps:--

LOGIN TEST CASES -- 
Open a Command Line Terminal (CMD/PowerShell)

Navigate to the Test Directory

bash
Copy code
cd "E:\Taqtics - assignment\API testing\API Automation\LOGIN AUTOMATION"
Run the Tests

bash
Copy code
robot -d results login_test.robot
This command will:

Execute the test cases in login_test.robot.
Store the results in the results/ directory.
Generate an HTML report (report.html) and log files.
Test Reports
Once the tests are executed, Robot Framework generates the following output files:

log.html: Contains a detailed log of the test execution, including the passed and failed steps.
report.html: Provides a summary of the test execution, showing the overall result and the number of tests passed/failed.
To open the report in your browser, navigate to the results/ folder and open report.html:

bash
Copy code
start results\report.html
Or manually navigate to the results folder and open report.html using your preferred web browser.


API TEST CASES -- 

open a Command Line Terminal (CMD/PowerShell) on your system.

Navigate to the Test Directory:

bash
Copy code
cd "E:\Taqtics - assignment\API testing\API Automation\LOGIN AUTOMATION"
Run the Tests using Robot Framework:

bash
Copy code
robot -d results login_test.robot
This will:

Execute all the test cases in login_test.robot.
Store the results in the results/ directory.
Generate an HTML report (report.html) and a detailed log file (log.html).
Test Reports:
After executing the tests, Robot Framework generates the following output files:

log.html: Contains a detailed log of the test execution, including passed and failed steps.
report.html: Provides a summary of the test execution, showing the overall result and the number of tests passed/failed.
To view the test results, navigate to the results/ folder and open report.html in your browser:

bash
Copy code
start results\report.html
Or manually navigate to the results folder and open report.html using your preferred web browser.


Dashboard report of the test cases--- 
https://github.com/A2922/Taqtics/blob/main/images/dashboard.JPG

https://github.com/A2922/Taqtics/blob/main/images/dashboard.JPG


Log Report of test cases -- 
https://github.com/A2922/Taqtics/blob/main/images/log.JPG


