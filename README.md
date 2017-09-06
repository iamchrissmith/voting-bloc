# README

[![Build Status](https://semaphoreci.com/api/v1/iamchrissmith/voting-bloc/branches/master/badge.svg)](https://semaphoreci.com/iamchrissmith/voting-bloc)

[Heroku App Demo](https://voting-bloc2.herokuapp.com/)  
[Database Schema](http://ondras.zarovi.cz/sql/demo/?keyword=chris-mini-project)

Demo User Account:  
email: demo@demo.com  
password: demo  

Demo Admin Account:  
email: admin@admin.com  
password: admin  

Voting Bloc is a rails application to track and vote in elections build in Ruby on Rails with React Component mixed in.  

It was built to allow users to vote in election.  Administrators view the results of elections as they are submitted (using React and ActionCable).

Users can also chose to run in an election by becoming a candidate and then selecting the eletion they want to run in.

Goals Accomplished in this project:

## Users
- [X] There are three user roles: admin, candidates and users
  - Users can
    - [X] login,
    - [X] logout,
    - [X] sign up for an account
    - [X] vote in an active election,
    - [X] change their role into Candidate
  - [X] Candidates can do all of the above and
     - [X] have access to edit their candidate profile
     - [X] can put their name forward to run
  - Admins can Delete all
   - [X] users,
   - [X] candidates, and
   - [X] elections.  
   - [X] In creating/editing an election, admins can add candidates to the ballot

## Elections
~- [ ] Multiple elections can be added, voted in and have their results reported~
- [X] Elections should consist of candidates (i.e. a user role)
- [X] All users should only be able to vote once in each election
- [X] Once they have voted, users should be able to see how they voted
- [X] Elections have a start and end date.  
- [X] Before they start any candidate can add their name
- [X] Once they are started, admins can edit the ballot
- [X] and all user types can vote (once).

## Analytics
- [X] During an election admins can monitor voting results
~- [ ] After an election all users can see:
 - [ ] Election turn out (number of votes verse eligible voters)
 - [ ] Election results (votes per candidate in descending order)
 - [ ] Candidates can see their results across elections
 - [ ] Users can see their participation across elections~

## Other Reqs
- [X] Heroku
- [X] Sessions, flashes, and maybe cookies
- [X] Authentication
- [X] Basic Styling

## Extensions
~- [ ] Twitter, Github, Facebook OAuth login~
- [X] React Integration
- [X] Continuous Integration with Semaphore

