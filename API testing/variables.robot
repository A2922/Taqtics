*** Variables ***
${BASE_URL}          https://landmark.taqtics.co/v1/external
${LOGIN_ENDPOINT}    /generateAuthToken
${VALID_PAYLOAD}     {"email": "intern@taqtics.co", "password": "TestIntern@123"}
${INVALID_PAYLOAD}   {"email": "invalid@taqtics.co", "password": "InvalidPass"}
${HEADERS}           {"Content-Type": "application/json"}
${EXPIRED_TOKEN}     eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....   # Replace with actual token
${PROTECTED_ENDPOINT} /protectedResource
${EXPECTED_SCHEMA}   {"type": "object", "properties": {"token": {"type": "string"}}}
