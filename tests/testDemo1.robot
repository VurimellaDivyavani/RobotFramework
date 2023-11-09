*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Test Teardown   Close Browser

*** Variables ***
${Error_Message_Login}      xpath://*[@id="login-form"]/div[1]


*** Test Cases ***
Validate UnSuccessful Login
	open the browser with the Mortgage payment url
	Fill the login form
	wait until it checks and display error message
	verify error message is correct

*** Keywords ***
open the browser with the Mortgage payment url
    Create WebDriver    Chrome  /Users/dvurimel/Documents/Drivers/chromedriver-win64/chromedriver-win64/chromedriver
    Go To    https://rahulshettyacademy.com/loginpagePractise/

Fill the login form
	Input Text  id:username   rahulshettyacademy
	Input Text  id:password   12345678
	Click Button    signInBtn

wait until it checks and display error message
	Wait Until Element Is Visible       ${Error_Message_Login}

verify error message is correct
#	${result}=     Get Text        ${Error_Message_Login}
#	Log To Console  ${result}
#	Should Be Equal As Strings      ${result}   Incorrect username/password.
#   Above 1st and 3rd commented code can be replace with below line
   Element Text Should Be      ${Error_Message_Login}      Incorrect username/password.