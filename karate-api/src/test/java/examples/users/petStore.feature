Feature: ejemplo 2 karate test script
  Como tester de NTT Data
  Quiero realizar peticiones
  Para verificar que las conexiones sean correctas


  Background:
    * url 'https://petstore.swagger.io/v2/pet'

  Scenario: get pet by id - Happy Path
    * def id = 1
    Given path id
    When method get
    Then status 200


  Scenario: get pet by id - Unhappy Path
    * def id = 7236169231231321
    Given path id
    When method get
    Then status 404


  Scenario Outline: crear una nueva mascota - Happy path
    Given url 'https://petstore.swagger.io/v2/pet'
    And request {id:<id>, name: <name>, status: <status>}
    When method post
    Then status 200
    Examples:
      | id   | name  | status    |
      | 1923 | Hola  | available |
      | 1241 | Como  | pending   |
      | 4123 | Estas | sold      |


  Scenario Outline: crear una nueva mascota con un estado inválido - UHP
    Given url 'https://petstore.swagger.io/v2/pet'
    And request {id:<id>, name: <name>, status: <status>}
    When method post
    Then status 200
    And match $.status == "disponible"
    Examples:
      | id   | name  | status     |
      | 1923 | Hola  | available |
      | 1241 | Como  | pending   |
      | 4123 | Estas | sold      |


  Scenario Outline: As a <description>, I want to get the corresponding response_code <status_code>
    Given url 'https://reqres.in/api/login'
    And request { email: <username>, password: <password>  }
    When method POST
    * print response
    Then response.status == <status_code>
    Examples:
      | username           | password   | status_code | description  |
      | eve.holt@reqres.in | cityslicka | 200         | valid user   |
      | eve.holt@reqres.in | null       | 400         | invalid user |


  Scenario: otra API
    Given url 'https://gorest.co.in/public/v1/users'
    When method get
    Then status 200
    And match $.data[19].id == 40
    When def outputID = ''
    And eval
    """
      for(var i=0; i<response.data.length; i++) {
        if(response.data[i].name==="Upendra Joshi") {
        outputID = i;
        }
      }
    """
    Then print response.data[~~outputID]


  Scenario Outline: imprimir response de un usuario con username especifico
    * url 'https://jsonplaceholder.typicode.com/'
    Given path 'users'
    When method get
    Then status 200
    And match $.[8] contains {username: '<nickname>'}
    When def oID = ''
    And eval
    """
    for(var i = 0; i < response.length; i++) {
      if(response[i].username==="<nickname>") {
      oID = i;
      }
    }
    """
    And def IDm = ~~oID
    Then print response[IDm]
    And print IDm
    Examples:
      | nickname |
      | Delphine |


  Scenario Outline: imprimir response de un usuario con username especifico con funciones propias de Karate
    * url 'https://jsonplaceholder.typicode.com/'
    Given path 'users'
    When method get
    Then status 200
    * def searchFor = '<nickname>'
    * def foundAt = []
    * def fun = function(x, i){ if (karate.match(x.username, searchFor).pass) karate.appendTo(foundAt, i) }
    * karate.forEach(response, fun)
    * def oID = foundAt[0]
    And print response[oID]
    And match $.[8] contains {username: '<nickname>'}
    Examples:
      | nickname |
      | Delphine |


  Scenario Outline: imprimir response de un usuario con username especifico con funciones propias de Karate - UHP
    * url 'https://jsonplaceholder.typicode.com/'
    Given path 'users'
    When method get
    Then status 200
    * def searchFor = '<nickname>'
    * def foundAt = []
    * def fun = function(x, i){ if (karate.match(x.username, searchFor).pass) karate.appendTo(foundAt, i) }
    * karate.forEach(response, fun)
    * def oID = foundAt[0]
    And print response[oID]
    And match $.[8] contains {username: Delfine}
    Examples:
      | nickname |
      | Delphine |


  Scenario Outline: imprimir response de un usuario con zipcode que termine en - Happy Path
    * url 'https://jsonplaceholder.typicode.com/'
    Given path 'users'
    When method get
    Then status 200
    And match $.[2].address contains {zipcode: '<zipcode>'}
    When def oIDm = ''
    And eval
    """
    for(var i = 0; i < response.length; i++) {
      if(response[i].address.zipcode.endsWith("<final>",response[i].address.zipcode.length)) {
      oIDm = i;
      }
    }
    """
    Then print response[~~oIDm]
    Examples:
      | zipcode    | final |
      | 59590-4157 | 4157  |


  Scenario Outline: imprimir response de un usuario con zipcode que termine en - UHP
    * url 'https://jsonplaceholder.typicode.com/'
    Given path 'users'
    When method get
    Then status 200
    And match $.[2].address contains {zipcode: '<zipcode>'}
    When def oIDm = ''
    And eval
    """
    for(var i = 0; i < response.length; i++) {
      if(response[i].address.zipcode.endsWith("<final>",response[i].address.zipcode.length)) {
      oIDm = i;
      }
    }
    """
    * def oID = ~~oIDm
    Then print response[oID]
    Then print oID
    And match response[oID].address.zipcode == '<zipcode>'
    Examples:
      | zipcode    | final |
      | 59590-4157 | 7771  |


  Scenario Outline: imprimir a los usuarios cuya web termine en
    * url 'https://jsonplaceholder.typicode.com/'
    Given path 'users'
    When method get
    Then status 200
    And match $.[8] contains {username: 'Delphine'}
    When def lID = []
    And eval
    """
    for(var i = 0; i < response.length; i++) {
      if(response[i].website.includes("<web>")) {
      karate.appendTo(lID, i)
      }
    }
    """
    Then print lID
    Examples:
      | web  |
      | .net |


  Scenario Outline: imprimir a los usuarios cuya web termine en
    * url 'https://jsonplaceholder.typicode.com/'
    Given path 'users'
    When method get
    Then status 200
    And match $.[8] contains {username: 'Delphine'}
    When def lID = []
    * def searchFor = '<web>'
    * def foundAt = []
    * def fun = function(x, i){ if (x.website.contains(searchFor)) karate.appendTo(foundAt, i) }
    * karate.forEach(response, fun)
    Then print lID
    Examples:
      | web  |
      | .net |


  Scenario: karate find index of first match (complex)
    * def list = [{ a: 1, b: 'x'}, { a: 2, b: 'y'}, { a: 3, b: 'z'}]
    #* def searchFor = { a: 2, b: '#string'}
    * def searchFor = 2
    * def foundAt = []
    * def fun = function(x, i){ if (karate.match(x.a, searchFor).pass) karate.appendTo(foundAt, i) }
    * karate.forEach(list, fun)
    * match foundAt == [1]
    * print foundAt[0]