*** Settings ***
Documentation    A resource file with reusable keywords and variables.
...
...              The system specific keywords created here form our own
...              domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary.
Library          SeleniumLibrary

*** Variables ***
${user_name}            rahulshettyacademy
${invalid_password}     12345678
${valid_password}       learning
${url}                  https://rahulshettyacademy.com/loginpagePractise/


*** Keywords ***

open the browser with the Mortgage payment url
    Create WebDriver    Chrome  /Users/dvurimel/Documents/Drivers/chromedriver-win64/chromedriver-win64/chromedriver
    Go To               ${url}

Close Browser session
	Close Browser