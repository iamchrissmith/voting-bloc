# README

[![Build Status](https://semaphoreci.com/api/v1/iamchrissmith/voting-bloc/branches/master/badge.svg)](https://semaphoreci.com/iamchrissmith/voting-bloc)

Voting Bloc is a rails application to track and vote in elections build in Ruby on Rails

## Users
- [X] There are three user roles: admin, candidates and users
  - Users can
    - [X] login,
    - [X] logout,
    - [X] sign up for an account
    - [ ] vote in an active election,
    - [ ] and put their name forward to run (i.e. change their type into Candidate)
  - [ ] Candidates can do all of the above and
     - [ ] have access to edit their candidate profile
  - Admins can Delete all
   - [ ] users,
   - [ ] candidates, and
   - [ ] elections.  
   - [ ] In creating/editing an election, admins can add users/candidates to the ballot

## Elections
- [ ] Multiple elections can be added, voted in and have their results reported
- [ ] Elections should consist of candidates (i.e. a user role)
- [ ] All users should only be able to vote once in each election
- [ ] Once they have voted, users should be able to see how they voted in all past elections
- [ ] Elections have a start and end date.  Before they start any candidate or user can add their name and no one can vote.  Once they are started, no one can edit the ballot and all user types can vote (once).

## Analytics
- [ ] During an election admins can monitor voting results
- [ ] After an election all users can see:
 - [ ] Election turn out (number of votes verse eligible voters)
 - [ ] Election results (votes per candidate in descending order)
 - [ ] Candidates can see their results across elections
 - [ ] Users can see their participation across elections

## Other Reqs
- [X] Heroku
- [ ] Sessions, flashes, and maybe cookies
- [ ] Authentication
- [ ] Basic Styling

## Extensions
- [ ] Twitter, Github, Facebook OAuth login
- [ ] UI/JS
- [X] CI
