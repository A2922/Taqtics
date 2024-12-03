*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser to Login Page
Suite Teardown    Close Browser

*** Variables ***
${URL}                 https://landmark.taqtics.co/
${BROWSER}             chrome
${VALID_EMAIL}         intern@taqtics.co
${VALID_PASSWORD}      TestIntern@123
${DASHBOARD_URL}       /dashboard

*** Test Cases ***
Valid Login
    Input Email       ${VALID_EMAIL}
    Input Password    ${VALID_PASSWORD}
    Click Login Button
    Wait Until Location Contains    ${DASHBOARD_URL}    10s
    Click Intern Menu 
    Sleep            5s
    Click Logout Button
    Wait Until Location Contains    ${URL}    10s             

*** Test Cases ***
SQL Injection Attempt
    [Documentation]    Validate the system's resistance to SQL injection attempts in the email and password fields.
    Sleep              2s
    Input Email         ${EMPTY}
    Input Password      ${EMPTY}
    Input Email       ' OR 1=1 --
    Input Password    ${EMPTY}
    Click Login Button
    Wait Until Page Contains    Please input valid email!    5s
    
*** Test Cases ***
Case Sensitivity in Login
    [Documentation]    Ensure the email and password fields are case-sensitive during login.
     
    Execute JavaScript    window.open('https://landmark.taqtics.co/', '_blank')
    
    # Switch to the newly opened tab/window
    Switch Window       NEW  5s 
    Input Email         ${EMPTY} 
    Input Password      ${EMPTY} 
    Input Email    INTERN@TAQTICS.CO
    Input Password    testintern@123
    Click Login Button
    Wait Until Page Contains    Invalid Credentials!    5s
    
*** Test Cases ***
Login with Empty Credentials
    [Documentation]    Ensure the system rejects attempts to log in with empty email and password fields.
    Execute JavaScript    window.open('https://landmark.taqtics.co/', '_blank')
    
    # Switch to the newly opened tab/window
    Switch Window       NEW  5s 
    Input Email         ${EMPTY}
    Input Password      ${EMPTY}
    Click Login Button
    Wait Until Page Contains  Please input your email!    10s



*** Test Cases ***
Invalid Login - Incorrect Password
    [Documentation]    Ensure the system rejects logins with an invalid password.
    Input Email        ${VALID_EMAIL}
    Input password     WrongPassword123
    Click Login Button
    Wait Until Page Contains     Invalid Credentials!     5s
    Location Should Contain    ${URL}


*** Test Cases ***
Password with Special Characters
    [Documentation]    Validate that the system allows special characters in the password.
    Input Email       ${VALID_EMAIL}
    Input Password    Test@#%$123
    Click Login Button
    Wait Until Page Contains    Invalid Credentials!    5s

*** Test Cases ***
Login with Unregistered Email
    [Documentation]    Ensure the system rejects attempts to log in with an unregistered email.
    Execute JavaScript    window.open('https://landmark.taqtics.co/', '_blank')
    
    # Switch to the newly opened tab/window
    Switch Window       NEW  5s 
    Input Email       ankit@taqtics.com
    Input Password    ${VALID_PASSWORD}
    Click Login Button
    Wait Until Page Contains    Not Found  5s


*** Test Cases ***
Login with Long Input Values
    [Documentation]    Ensure the system rejects excessively long input values for email and password.
    Input Email       ${EMPTY}
    Input Password    ${EMPTY}
    ${long_email}=    Set Variable    ${EMPTY.join([char * 256 for char in 'a'])}@example.com
    ${long_password}=    Set Variable    ${EMPTY.join(['a' * 256])}
    Input Email       ${long_email}
    Input Password    ${long_password}
    Click Login Button
    Wait Until Page Contains    Please input valid email!    12s



*** Keywords ***
Open Browser to Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Input Email
    [Arguments]    ${email}
    Input Text    id=email    ${email}

Input Password
    [Arguments]    ${password}
    Input Text    id=password    ${password}

Click Login Button
    Click Button    css=button[type="submit"]

Click Intern Menu
    Click Element    css=#root > div.header_container > div > span

Click Logout Button
    Click Element      xpath=/html/body/div[2]/div/div/ul/li[2]

Close Previous Tabs
    [Documentation]    Close all tabs except the current one.

    # Get a list of all open tabs (windows)
    ${all_windows}=    List Windows

    # Get the current active window
    ${current_window}=    Get Window Handle

    # Loop through all tabs and close the ones that are not active
    FOR    ${window}    IN    @{all_windows}
        Run Keyword If    "${window}" != "${current_window}"    Close Window    ${window}
    END
