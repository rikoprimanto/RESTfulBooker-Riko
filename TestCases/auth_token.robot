*** Settings ***
Library             RequestsLibrary
Library             Collections
Library             JsonValidator
Library             Process
Library             OperatingSystem

*** Variables ***
${BASE_URL}             https://restful-booker.herokuapp.com
${AUTH}                 /auth
${BOOKING}              /booking
${COUNTER}              ${1}
${CONTENT_TYPE}         application/json
${USERNAME}             admin
${PASSWORD}             password123
${FIRSTNAME}            Riko
${LASTNAME}             Primanto
${TOTALPRICE}           600
${DEPOSITPAID}          true
${CHECKIN}              2022-11-2
${CHECKOUT}             2022-11-5

*** Keywords ***
Auth Token
    ${HEADERS}=         Create Dictionary
    ...                 Content-Type=${CONTENT_TYPE}
    ...                 User-Agent=RobotFramework
    Create Session      Obtain Token        ${BASE_URL}     verify=True
    ${response}=        Post Request        Obtain Token        uri=${AUTH}     data={"username":"${USERNAME}","password":"${PASSWORD}"}      headers=${HEADERS}
    log to console    ${response.status_code}
    Should Be Equal      ${response.status_code}     ${200}
    log to console    ${response.content}
    ${TOKEN}=           Get From Dictionary     ${response.json()}      token
    Set Suite Variable      ${TOKEN}        ${TOKEN}