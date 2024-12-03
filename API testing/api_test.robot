*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Library           BuiltIn

*** Variables ***
${BASE_URL}           https://landmark.taqtics.co/v1/external
${LOGIN_ENDPOINT}     /generateAuthToken
${VALID_PAYLOAD}      {'Email': 'intern@taqtics.co', 'password': 'TestIntern@123'}
${INVALID_PAYLOAD}    {"Email": "invalid@taqtics.co", "password": "InvalidPass"}
${HEADERS}            {"Content-Type": "application/json"}
${EXPECTED_SCHEMA}    {"type": "object", "properties": {"token": {"type": "string"}}}
${PROTECTED_ENDPOINT}    /generateAuthToken
*** Test Cases ***
Verify API Is Reachable
    [Documentation]    Verify that the API is reachable.
    Create Session    AuthSession    ${BASE_URL}    verify=False
    ${response}=       Get On Session    AuthSession    ${LOGIN_ENDPOINT}
    Log    Response Text: ${response.text}
    Should Be Equal As Integers    ${response.status_code}    200

Verify Valid Credentials
    [Documentation]    Validate that a valid token is generated for valid credentials.
    
    # Create session for the API
    Create Session    AuthSession    ${BASE_URL}    verify=False
    Log    Created session: AuthSession with base URL: ${BASE_URL}
    
    # Define the request body
    ${body}=          Create Dictionary    email=intern@taqtics.co    password=TestIntern@123
    
    # Send POST request to the login endpoint
    ${response}=      Post On Session    AuthSession    ${LOGIN_ENDPOINT}    json=${body}
    
    # Validate response status code
    Log    Response Status Code: ${response.status_code}
    Should Be Equal As Integers    ${response.status_code}    200    Login request failed.


Verify Invalid Credentials
    [Documentation]    Validate error response when invalid credentials are provided.

    # Create session for the API
    Create Session    AuthSession    ${BASE_URL}    verify=False
    Log    Created session: AuthSession with base URL: ${BASE_URL}
    
    # Define the request body with invalid credentials
    ${body}=          Create Dictionary    email=invalid@taqtics.co    password=InvalidPass
    
    # Send POST request and handle the potential error
    ${status}    ${response}=    Run Keyword And Ignore Error    Post On Session    AuthSession    ${LOGIN_ENDPOINT}    json=${body}
    
    # Log the response details
    Log    Request Execution Status: ${status}
    Log    Raw Response: ${response}

    # If the request failed, extract the response from the tuple
    Run Keyword If    '${status}' == 'FAIL'    Set Variable    ${response}    ${response[1]}

    Should Be Equal    ${response.status_code}    401    Incorrect status code for invalid credentials.
    Should Contain    ${response.text}    "Invalid Credentials!"  # Add a check for the error message

Verify Protected Endpoint Without Token
    [Documentation]    Ensure unauthorized error when accessing a protected endpoint without a token.
    Create Session     AuthSession    ${BASE_URL}
    ${response}=       GET On Session    AuthSession    ${PROTECTED_ENDPOINT}
    Should Be Equal As Integers    ${response.status_code}    401  # Ensure 401 Unauthorized response
    Log    Response: ${response.text}

Verify Response Headers
    [Documentation]    Validate response headers for successful API calls.
    Create Session     AuthSession    ${BASE_URL}
    ${response}=       POST On Session    AuthSession    ${LOGIN_ENDPOINT}    json=${VALID_PAYLOAD}    headers=${HEADERS}
    Should Be Equal As Integers    ${response.status_code}    200
    ${content_type}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${content_type}    application/json

Validate JSON Schema
    [Documentation]    Ensure the response JSON matches the expected schema.
    Create Session     AuthSession    ${BASE_URL}
    ${response}=       POST On Session    AuthSession    ${LOGIN_ENDPOINT}    json=${VALID_PAYLOAD}    headers=${HEADERS}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=  Convert String To JSON    ${response.text}
    Run Keyword And Return Status    Validate JSON Schema    ${response_json}    ${EXPECTED_SCHEMA}

Handle Non-JSON Response
    [Documentation]    Ensure the API handles non-JSON responses gracefully.
    Create Session    AuthSession    ${BASE_URL}    verify=False
    ${response}=    GET On Session    AuthSession    ${INVALID_ENDPOINT}
    Log    Response Text: ${response.text}
    Log    Status Code: ${response.status_code}
    
    # Ensure the status code is 400 (integer comparison)
    Should Be Equal As Integers    ${response.status_code}    400

    # Ensure that the response is not JSON
    Run Keyword And Ignore Error    Convert String To JSON    ${response.text}
    ${result}=    Run Keyword And Return Status    Convert String To JSON    ${response.text}
    Should Be False    ${result}

Verify HTTP Method Restrictions
    [Documentation]    Validate that unsupported HTTP methods are rejected.
    Create Session    AuthSession    ${BASE_URL}
    ${response}=       PUT On Session    AuthSession    ${LOGIN_ENDPOINT}    json=${VALID_PAYLOAD}    headers=${HEADERS}
    Should Be Equal As Integers    ${response.status_code}    405
