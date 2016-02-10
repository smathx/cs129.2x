Feature: Data Setup
  As a blog administrator
  In order to test typo
  I want to be able to create a valid dataset
  

  Background:
    Given the blog is set up
      And the following users are present:
        | name    | profile   |
        | Author1 | publisher |
        | Author2 | publisher |
      
      And the following articles are present:
        | title    | body  | author  |
        | Article1 | Body1 | Author1 |
        | Article2 | Body2 | Author2 |
         
      And article "Article1" has 1 comment
      And article "Article2" has 2 comments
  

  Scenario: First article can be viewed
    When I go to the view page for "Article1"
      Then I should see "Article1"
       And I should see "1 comment"
       And I should see "Article1 - Comment 1"

       
  Scenario: Second article can be viewed
    When I go to the view page for "Article2"
      Then I should see "Article2"
       And I should see "2 comments"
       And I should see "Article2 - Comment 1"
       And I should see "Article2 - Comment 2"


  Scenario: Author names are on the admin content page
    Given I am logged in to the admin panel
    When I go to the admin content page
      Then I should see " Author1"
       And I should see " Author2"
