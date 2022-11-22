Feature: sample karate test script
  Como tester de NTT Data
  Quiero realizar peticiones
  Para verificar que las conexiones sean correctas

  Background:
    * url 'https://jsonplaceholder.typicode.com/'

  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200
    And match $.[2].username == "Samantha"


  Scenario Outline: get user by given id
    * def oPath = 'users/<ID>'
    * replace oPath.ID = <id>
    Given path oPath
    When method get
    Then status 200
    And match $.id == <id>
    Examples:
    |id|
    |1 |


  Scenario Outline: get user by given invalid id
    * def oPath = 'users/<ID>'
    * replace oPath.ID = <id>
    Given path oPath
    When method get
    Then status 404
    And match $ == {}
    Examples:
      |id|
      |15|


  Scenario: buscar usuario por nombre que se llame Nicholas Runolfsdottir V
    * def ID = ''
    Given path 'users'
    When method get
    Then status 200
    And eval
    """
    for(var i=0; i<response.length; i++){
      if(response[i].name==="Nicholas Runolfsdottir V"){
      ID = i;
      }
    }
    """
    And def oID = ~~ID
    And match $.[7].name == 'Nicholas Runolfsdottir V'
    And print response[oID]


  Scenario: buscar usuario por nombre que se llame Nicholas Runolfsdottir V
    Given path 'users'
    When method get
    Then status 200
    And match $.[7].name == 'Nicholas Runolfsdottir V'
    * def searchFor = 'Nicholas Runolfsdottir V'
    * def foundAt = []
    * def fun = function(x, i){ if (karate.match(x.name, searchFor).pass) karate.appendTo(foundAt, i) }
    * karate.forEach(response, fun)
    * def oID = foundAt[0]
    And def ID = ~~oID
    And print response[ID]


  Scenario Outline: Alta de 3 usuarios
    Given path 'users'
    And request
    """
        {
        "name": '<name>',
        "username": '<username>',
        "email": "tomas1@tomas.com",
        "address": {
          "street": "carmenca",
          "suite": "Apt. 156",
          "city": "Lima",
          "zipcode": "54321-6789"
        }
      }
    """
    When method post
    Then status 201
    And match $.name == '<name>'
    And match $.username == '<username>'
    Examples:
      | name   | username |
      | tomas  | tomas0   |
      | tomas1 | tomas1   |
      | tomas2 | tomas2   |


  Scenario Outline: create a user and then get it by id
    * def user = { name: <name>, username: <username>, email: <email>, address: {street: <street>, suite: <suite>, city: <city>, zipcode: <zipcode>} }
    Given path 'users'
    And request user
    When method post
    Then status 201
    * def oID = $.id
    * print 'created id is: ', oID
    * def pathAyuda = 'users/<id>'
    * replace pathAyuda.id = oID
    * print pathAyuda

    Given path pathAyuda
    When method get
    Then status 200
    And match $.id == 'oID'
    Examples:
      | name      | username | email         | street      | suite    | city    | zipcode    |
      | Test User | testuser | test@user.com | Has No Name | Apt. 123 | Electri | 54321-6789 |


  Scenario Outline: create an user Happy Path
    * def user =
    """
        {
        "name": '<name>',
        "username": '<username>',
        "email": '<email>',
        "address": {
          "street": '<street>',
          "suite": '<suite>',
          "city": '<city>',
          "zipcode": '<zipcode>'
        }
      }
    """
    Given path 'users'
    And request user
    When method post
    Then status 201
    And match $.name == '<name>'
    And match $.username == '<username>'
    Examples:
      | name      | username | email         | street      | suite    | city    | zipcode    |
      | Test User | testuser | test@user.com | Has No Name | Apt. 123 | Electri | 54321-6789 |


  Scenario Outline: create an user - UHP
    * def user =
    """
        {
        "name": '<name>',
        "username": '<username>',
        "email": '<email>',
        "address": {
          "street": '<street>',
          "suite": '<suite>',
          "city": '<city>',
          "zipcode": '<zipcode>'
        }
      }
    """
    Given path 'users'
    And request user
    When method post
    Then status 201
    And match $.name == 'UserTest'
    And match $.username == 'usertest'
    Examples:
      | name      | username | email         | street      | suite    | city    | zipcode    |
      | Test User | testuser | test@user.com | Has No Name | Apt. 123 | Electri | 54321-6789 |


  Scenario: delete an user by id

    Given url 'https://jsonplaceholder.typicode.com/users/1'
    When method delete
    Then status 200
    And match $ == {}


  Scenario Outline: Delete an user by given id
    * def oPath = 'users/<ID>'
    * replace oPath.ID = <id>
    Given path oPath
    When method delete
    Then status 200
    And match $ == {}
    Examples:
      | id |
      | 1  |


  Scenario Outline: Delete an user by given id - UHP
    * def oPath = 'users/<ID>'
    * replace oPath.ID = <id>
    Given path oPath
    When method delete
    Then status 200
    And match $ == {}
    Examples:
      | id |
      | 15 |


  Scenario Outline: Update 5 users
    * def oURL = 'https://jsonplaceholder.typicode.com/users/<ID>'
    * replace oURL.ID = <id>

    Given url oURL
    And request
    """
        {
        "name": '<name>',
        "username": '<username>',
        "email": '<email>',
        "address": {
          "street": '<street>',
          "suite": '<suite>',
          "city": '<city>',
          "zipcode": '<zipcode>'
        }
      }
    """
    When method put
    Then status 200
    And match $.id == <id>
    And match $.name == '<name>'
    And match $.username == '<username>'
    And match $.email contains '<email>'
    And match $.address.street == '<street>'
    And match $.address.suite == '<suite>'
    And match $.address.city == '<city>'
    And match $.address.zipcode == '<zipcode>'

    Examples:
      | id | name     | username  | email              | street | suite | city     | zipcode    |
      | 1  | ejemplo1 | username1 | email1@hotmail.com | La 1   | 101   | Chiclayo | 54321-6789 |
      | 2  | ejemplo2 | username2 | email2@hotmail.com | La 2   | 201   | Trujillo | 54321-6789 |
      | 3  | ejemplo3 | username3 | email3@hotmail.com | La 3   | 301   | Lima     | 54321-6789 |
      | 4  | ejemplo4 | username4 | email4@hotmail.com | La 4   | 401   | Cuzco    | 54321-6789 |
      | 5  | ejemplo5 | username5 | email5@hotmail.com | La 5   | 501   | Piura    | 54321-6789 |


  Scenario Outline: Update an user by given id
    * def oPath = 'users/<ID>'
    * replace oPath.ID = <id>
    Given path oPath
    And request
    """
        {
        "name": '<name>',
        "username": '<username>',
        "email": '<email>',
        "address": {
          "street": '<street>',
          "suite": '<suite>',
          "city": '<city>',
          "zipcode": '<zipcode>'
          }
        }
    """
    When method put
    Then status 200
    And match $.id == <id>
    And match $.name == '<name>'
    Examples:
      | id | name     | username  | email              | street | suite | city     | zipcode    |
      | 1  | ejemplo1 | username1 | email1@hotmail.com | La 1   | 101   | Chiclayo | 54321-6789 |


  Scenario Outline: Update an user by given id - UHP
    * def oPath = 'users/<ID>'
    * replace oPath.ID = <id>
    Given path oPath
    And request
    """
        {
        "name": '<name>',
        "username": '<username>',
        "email": '<email>',
        "address": {
          "street": '<street>',
          "suite": '<suite>',
          "city": '<city>',
          "zipcode": '<zipcode>'
          }
        }
    """
    When method put
    Then status 200
    And match $.id == <id>
    And match $.name == 1ejemplo
    Examples:
      | id | name     | username  | email              | street | suite | city     | zipcode    |
      | 10 | ejemplo1 | username1 | email1@hotmail.com | La 1   | 101   | Chiclayo | 54321-6789 |
