*** Settings ***
Documentation       API Test using RESTfulBooker application
Test Timeout        1 minute
Library             RequestsLibrary
Library             Collections
Library             JsonValidator
Library             Process
Library             OperatingSystem
Resource            ../TestCases/auth_token.robot
Resource            ../TestCases/get_all_bookingids.robot
Resource            ../TestCases/create_booking.robot
Resource            ../TestCases/update_booking.robot
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

*** Test Cases ***
RESTfulBooker - Auth Token
    Auth Token
RESTfulBooker - Get All BookingIDs
    Get All BookingIDs
RESTfulBooker - Create Booking
    Create Booking
RESTfulBooker - Update Booking
    Update Booking