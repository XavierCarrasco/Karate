Feature: ejemplos de tipo GET
  Como usuario
  Quiero realizar peticiones de tipo get
  Para verificar que la conexión es correcta

  Scenario: obtener todos los usuarios
    Given url 'https://jsonplaceholder.typicode.com/users'
    When method get
    Then status 200

  Scenario: obtener usuarios separando la url de la ruta (path)
    * url 'https://jsonplaceholder.typicode.com'
    Given path 'users'
    When method get
    Then status 200

  Scenario: obtener un usuario en específico
    * url 'https://jsonplaceholder.typicode.com'
    Given path 'users/5'
    When method get
    Then status 200

  Scenario Outline: obtener un usario específico con el id dado
    * url 'https://jsonplaceholder.typicode.com'
    * def oPath = 'users/<oID>'
    * replace oPath.oID = <id>
    Given path oPath
    When method get
    Then status 200

    Examples:
    | id |
    | 5  |

  Scenario Outline: obtener un usario específico dado y verificar el id
    * url 'https://jsonplaceholder.typicode.com'
    * def oPath = 'users/<oID>'
    * replace oPath.oID = <id>
    Given path oPath
    When method get
    Then status 200
    And match response.id == <id>

    Examples:
    | id |
    | 5  |