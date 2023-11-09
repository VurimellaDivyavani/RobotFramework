*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Library     DataDriver      file=resources/data.csv     encoding=utf_8      dialect=unix
Test Teardown   Close Browser
Test Template   Validate UnSuccessful Login

*** Variables ***
${Error_Message_Login}      xpath://*[@id="login-form"]/div[1]
${Shop_page_load}           xpath://*[@id="navbarResponsive"]/ul/li/a
${radio_button_user}        css:input[value='user']

*** Test Cases ***
Login with user     ${username} and password    ${password}    xyz     123456

*** Keywords ***
Validate UnSuccessful Login
	[arguments]     ${username}     ${password}
	open the browser with the Mortgage payment url
	Fill the login form     ${username}     ${password}
	wait until it checks and display error message
	verify error message is correct

open the browser with the Mortgage payment url
    Create WebDriver    Chrome  /Users/dvurimel/Documents/Drivers/chromedriver-win64/chromedriver-win64/chromedriver
    Go To    https://rahulshettyacademy.com/loginpagePractise/

Fill the login form
	[arguments]    ${username}     ${password}
	Input Text      id:username     ${username}
	Input Password  id:password     ${password}
	Click Button    signInBtn

wait until it checks and display error message
	Wait Until Element Is Visible       ${Error_Message_Login}

verify error message is correct
#	${result}=     Get Text        ${Error_Message_Login}
#	Log To Console  ${result}
#	Should Be Equal As Strings      ${result}   Incorrect username/password.
#   Above 1st and 3rd commented code can be replace with below line
   Element Text Should Be      ${Error_Message_Login}      Incorrect username/password.