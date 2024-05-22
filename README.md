# Task Manager

A Flutter-based task management application that allows users to create, track, and manage their tasks.

## Features

- User authentication (login/signup)
- Create and manage tasks
- Set task due dates and priorities
- Mark tasks as complete

## Figma Design
- This figma was used to inform the design from which the application was built
https://www.figma.com/design/PbiDaFFgbHJ0KeBia5FizV/TO-DO?node-id=0-1&t=2VfvD2FrGd2gY3do-0

## Packages Used

- dio
- flutter bloc
- get it
- flutter secure storage
- connectivity plus
- flutter slidable 

## Challenges Faced

- We encountered some obstacles in dealing with the backend in terms of putting meathod. I had to change the header Content-Type to x-www-form-urlencoded so that the data would be received by the dummyjson site

- I wanted to use the sqlflite package to save the task in case the device was in a state where there was no Internet, but it turned out that I could not use two packages to save data in the same application.
The reason was that I used the flutter_secure_storage package to store the token in a secure way

- I encountered a problem in testing that the phone is connected to the Internet. There was only one package testing the connection, but I did not find any solution in Stack Overflow that solves my problem.

## Note

When logging in, you must take into consideration that you want to use the username “kminchelle” and the password “0lelplR” in order to log in successfully.