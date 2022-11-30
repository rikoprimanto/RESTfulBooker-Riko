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
Get All BookingIDs
    Create Session      Get All     ${BASE_URL}     verify=True
    ${response}=        Get Request     Get All     uri=${BOOKING}
    log to console    ${response.status_code}
    Should Be Equal      ${response.status_code}     ${200}
    log to console    ${response.content}
    @{BOOKINGIDS}=      Create List
    FOR     ${item}     IN      @{response.json()}
        Insert Into List        ${BOOKINGIDS}       ${COUNTER}      ${item}[bookingid]
        ${COUNTER}=     Set Variable        ${COUNTER+1}
    END
    Set Suite Variable      ${BOOKING_IDS}      ${BOOKING_IDS}