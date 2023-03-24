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
Create Booking
    ${bookingdates}=   Create Dictionary
    ...                checkin=${CHECKIN}
    ...                checkout=${CHECKOUT}
    ${newbooking}=      Create Dictionary
    ...                 firstname=${FIRSTNAME}
    ...                 lastname=${LASTNAME}
    ...                 totalprice=${TOTALPRICE}
    ...                 depositpaid=${DEPOSITPAID}
    ...                 bookingdates=${bookingdates}
    ${HEADERS}=          Create Dictionary
    ...                  Content-Type=${CONTENT_TYPE}
    ...                  User-Agent=RobotFramework
    Create Session      Create Booking     ${BASE_URL}     verify=True
    ${response}=        POST REQUEST    Create BOOKING     uri=${BOOKING}   data=${newbooking}  headers=${HEADERS}
    log to console    ${response.status_code}
    Should Be Equal      ${response.status_code}     ${200}
    log to console    ${response.content}
    ${BOOKING_ID}=  Get From Dictionary     ${response.json()}      bookingid
    Set Suite Variable      ${BOOKING_ID}   ${BOOKING_ID}