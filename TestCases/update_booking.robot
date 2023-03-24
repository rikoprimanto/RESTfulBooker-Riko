*** Settings ***
Library             RequestsLibrary
Library             Collections
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
${ADDITIONALNEEDS}      Breakfast               


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
    ...                 additionalneeds=${ADDITIONALNEEDS}
    ...                 bookingdates=${bookingdates}     
    ${TOKEN}=    Set Variable    
    ${HEADERS}=          Create Dictionary
    ...                  Content-Type=${CONTENT_TYPE}
    ...                  Cookie=token=${TOKEN}
    Create Session      Update Booking      ${BASE_URL}     verify=True
    ${NEWID}=    Set Variable    
    ${response}=        Put Request    Update Booking      uri=${BOOKING}/${NEWID}     data=${updatebooking}       headers=${HEADERS}
    Should Be Equal As Strings      ${response.status_code}    404