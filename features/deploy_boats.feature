Feature: we want to deploy the ship on the grid 

  Scenario: Registering
    Given I have a grid
    When I press "deploy ship"
    Then I should see "Which coordinate"