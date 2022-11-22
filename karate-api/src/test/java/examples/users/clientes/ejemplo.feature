Feature: Ejemplo

  Background:
    #* url 'https://reqres.in/'
    * url _urlBase

  Scenario: Metodo GET
    Given path "/api/users/3"
    #Given path "api", "users", "2"
    When method get
    Then status 200

  Scenario Outline: Metodo GET 2
    Given path "/api/users", "<id>"
    When method get
    Then status 200
    And match response.data.last_name == "<apellido>"
    And match response.data.first_name == "<nombre>"

    Examples:
      | id | nombre | apellido |
      | 2  | Janet  | Weaver   |
      | 3  | Emma   | Wong     |

  Scenario: Metodo POST 1
    Given path "api/users"
    And request {"name": "Cristhian", "job": "Tester"}
    When method post
    Then status 201


  Scenario Outline: Metodo POST 2
    Given path "api", "users"
    And request
    """
      {
        "name": "<nombre>",
        "job": "<trabajo>"
      }
    """
    When method post
    Then status 201
    And match response.name == "<nombre>"
    And match response.job == "<trabajo>"

    Examples:
      | nombre    | trabajo       |
      | Cristhian | Tester        |
      | Miguel    | QA            |
      | Dante     | Automatizador |


  Scenario: Metodo DELETE 1
    Given path "/api/users/2"
    When method delete
    Then status 204

  Scenario Outline: Metodo DELETE 2
    Given path "api", "users", "<id>"
    When method delete
    Then status 204
    And match response == ""

    Examples:
      | id |
      | 2  |
      | 3  |


  Scenario: Metodo PUT 1
    Given path "/api/users/2"
    And request {"name": "morpheus", "job": "zion resident"}
    When method put
    Then status 200

  Scenario Outline: Metodo PUT 2
    Given path "api", "users", "<id>"
    And request
    """
      {
        "name": "<nombre>",
        "job": "<trabajo>"
      }
    """
    When method put
    Then status 200
    And match response.name == "<nombre>"
    And match response.job == "<trabajo>"

    Examples:
      | id | nombre    | trabajo       |
      | 2  | Cristhian | Tester        |
      | 3  | Miguel    | QA            |
      | 4  | Dante     | Automatizador |
