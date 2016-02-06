Feature: Create Category
  As a blog administrator
  I want to be able to add a new category to my blog

  Background:
    Given the blog is set up
      And I am logged into the admin panel

  Scenario: Successfully save category
    Given I am on the new category page
    
    When I fill in "category_name" with "<dummy-category-name>"
      And I press "Save"
    
    Then I should be on the new category page
      And I should see "Category was successfully saved"
      And I should see "<dummy-category-name>"
    