@echo off

REM Step 1: Change to the LOGIN AUTOMATION directory
cd "E:\Taqtics - assignment\API testing\LOGIN AUTOMATION"

REM Step 2: Ensure the results folder exists
if not exist results (
    mkdir results
)

REM Step 3: Run Robot Framework tests and store the results in the results folder
robot login_test.robot --output results\output.xml --log results\log.html --report results\report.html

REM Step 4: Start a simple HTTP server to display the report
echo Starting the local web server on port 5000...
python -m http.server 5000 --directory results

REM Inform the user about the test completion and where to view the report
echo Test execution completed. You can view the report at:
echo http://localhost:5000/results/report.html
pause
