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
Update Booking
    ${bookingdates}=   Create Dictionary
    ...                checkin=${CHECKIN}
    ...                checkout=${CHECKOUT}
    ${updatebooking}=   Create Dictionary
    ...                 firstname=${FIRSTNAME}
    ...                 lastname=${LASTNAME}
    ...                 totalprice=0
    ...                 depositpaid=${DEPOSITPAID}
    ...                 bookingdates=${bookingdates}
    ${HEADERS}=          Create Dictionary
    ...                  Content-Type=${CONTENT_TYPE}
    Create Session      Update Booking      ${BASE_URL}     verify=True
    ${response}=        Put Request     Update Booking  uri=${BOOKING}     data=${updatebooking}       headers=${HEADERS}
    log to console    ${response.status_code}
    Should Be Equal      ${response.status_code}     ${200}