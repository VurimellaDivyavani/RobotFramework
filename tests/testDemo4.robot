*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Test Setup      open the browser with the Mortgage payment url
Test Teardown   Close Browser
Test Template   Validate UnSuccessful Login
Resource        resource.robot

*** Variables ***
${Error_Message_Login}      xpath://*[@id="login-form"]/div[1]
${Shop_page_load}           xpath://*[@id="navbarResponsive"]/ul/li/a
${radio_button_user}        css:input[value='user']


*** Test Cases ***              username            password
Invalid Username                dgagddg             learning
Invalid Password                rahulshettyacademy  plfdfjg
Special Characters in Username      @#@$%^^$$()     learning
Special Characters in Password  rahulshettyacademy      ^&$%#

*** Keywords ***
Validate UnSuccessful Login
	[arguments]     ${username}     ${password}
	Fill the login form     ${username}     ${password}
	wait until it checks and display error message
	verify error message is correct

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