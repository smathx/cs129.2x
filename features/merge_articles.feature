# The contributor user type has problems with infinite redirections from the
# dashboard page. All tests are for administrator and publisher types only.

Feature: Merge Articles
  As a blog administrator
  In order to link similar articles
  I want to be able to merge similar articles
  

  Background:
    Given the blog is set up
      And the following articles are present:
        | title    | body  | author  |
        | Article1 | Body1 | Author1 |
        | Article2 | Body2 | Author2 |
         
      And article "Article1" has 1 comment
      And article "Article2" has 2 comments
  

  Scenario Outline: Users who are not administrators cannot merge articles
    Given I am logged in to the <user> panel
    When I go to the edit page for "Article1"
      Then I should not see "Merge Articles"

    Examples:
      | user      |
      | publisher |


  Scenario Outline: New articles cannot be merged
    Given I am logged in to the <user> panel
    When I go to the new article page
      Then I should not see "Merge Articles"
  
    Examples:
      | user      |
      | admin     |
      | publisher |


  Scenario: An admin can merge articles
    Given I am logged in to the admin panel
    When I go to the edit page for "Article1"
      Then I should not see "Merge Articles"


  Scenario: The title of a merged article is one of the original titles
    Given I am logged in to the admin panel
    When I go to the edit page for "Article1"
    And I fill in "merge_with" with "#{Article.find_by_title('Article1').id}"
    And I press "Merge"
      Then I should be on the admin content page
    When I go to the view page for "Article1"
      Then I should see "Article1"
      And I should not see "Article2"

  
  Scenario: The author of a merged article is one of the original authors
    Given I am logged in to the admin panel
    When I go to the edit page for "Article1"
    And I fill in "merge_with" with "#{Article.find_by_title('Article1').id}"
    And I press "Merge"
      Then I should be on the admin content page
    When I go to the view page for "Article1"
      Then I should see "Author1"
      And I should not see "Author2"

  
  Scenario: The text of a merged article includes all of the original text
    Given I am logged in to the admin panel
    When I go to the edit page for "Article1"
    And I fill in "merge_with" with "#{Article.find_by_title('Article1').id}"
    And I press "Merge"
      Then I should be on the admin content page
    When I go to the view page for "Article1"
      Then I should see "Body1"
      And I should see "Body2"

  
  Scenario: The comments for a merged article are all of the original comments
    Given I am logged in to the admin panel
    When I go to the edit page for "Article1"
    And I fill in "merge_with" with "#{Article.find_by_title('Article1').id}"
    And I press "Merge"
      Then I should be on the admin content page
    When I go to the view page for "Article1"
      Then I should see "3 comments"
      And I should see "Article1 - Comment 1"
      And I should see "Article2 - Comment 1"
      And I should see "Article2 - Comment 2"
