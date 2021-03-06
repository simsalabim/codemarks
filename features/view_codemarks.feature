@omniauth_test_success @javascript

Feature: View Codemarks
  In order to use the site
  As anybody
  I want to see codemarks

  Background:
    Given I am logged in

  Scenario: Viewing my Codemarks
    And I have 3 codemarks
    And I am on the codemarks page
    Then I should see 3 codemarks

  Scenario: Viewing one Codemark
    And I have 1 text codemarks
    And I am on the codemarks page
    When I click on that codemark
    Then I should see that codemark
    And I should be on the show page

  Scenario: Viewing one Codemark
    And I have 1 repository codemarks
    And I am on the codemarks page
    When I click on that codemark
    Then I should see that codemark
    And I should be on the show page

  Scenario: I only see my Codemarks when filtered by me
    And I have 3 codemarks
    And someone else has codemarks
    And I go to my codemarks page
    Then I should see 3 codemarks

  Scenario: The top nav selects Mine when filtered by me
    And I have 1 codemarks
    And someone else has codemarks
    And I am on the codemarks page
    When I click on my name
    Then the "Mine" tab should be active

  Scenario: Codemark titles should be links
    And I have a codemarks called "Some Title"
    And I am on the codemarks page
    Then I should see a link, "Some Title"

  Scenario: Viewing public codemarks
    Given there are 2 random codemarks
    And I am on the codemarks page
    Then I should see 2 codemarks

  Scenario: Viewing someone else's codemarks
    Given lilweezy is a user with a codemark
    When I go to his codemarks page
    Then I should see his codemark

  Scenario: Codemarks are paginated
    Given there are 30 random codemarks
    When I go to the second page
    And I wait until all Ajax requests are complete
    Then I should see 6 codemarks

  Scenario: Can view codemarks on topics
    Given there are 2 codemarks for "rspec"
    And I am on the codemarks page
    When I go to the "rspec" topic page
    Then I should see 2 codemarks
    And I should see popularity as the default sort

  Scenario: Can filter between mine and public on topics show
    And superman is a user with a codemark
    When I go to that topic page
    Then I should see his codemark

  Scenario: Codemarks have twitter share links
    Given there are 1 random codemarks
    And I am on the codemarks page
    Then I should see a twitter share link
