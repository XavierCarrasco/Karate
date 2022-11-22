Feature: ejemplos de tipo PUT
  Como usuario
  Quiero realizar peticiones de tipo PUT
  Para verificar la modificación de usuarios

  Scenario: modificar un usuario
    Given url 'https://jsonplaceholder.typicode.com/users/4'
    And request
    """
      {
      "name": 'Homero',
      "username": 'homeroS',
      "email": 'homero.simpson@ejemplo.com',
      "address": {
        "street": 'Avenida Siempreviva 742',
        "suite": '01',
        "city": 'Springfield',
        "zipcode": '12345-6789'
        }
      }
    """
    When method put
    Then status 200

  Scenario: modificar usuario con url separado del path
    * url 'https://jsonplaceholder.typicode.com'
    Given path 'users/4'
    And request {name: 'Homero', username: 'homeroS', email: 'homero.simpson@ejemplo.com', address{street: 'Avenida Siempreviva 742', suite: '01', city: 'Springfield', zipcode: '12345-6789'}}
    When method put
    Then status 200

  Scenario Outline: modificar usuario con datos dados
    * url 'https://jsonplaceholder.typicode.com'
    * def ruta = 'users/<identificador>'
    * replace ruta.identificador = <id>
    Given path ruta
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
    Examples:
    | id | name   | username | email                      | street                  | suite | city        | zipcode    |
    | 4  | Homero | homeroS  | homero.simpson@ejemplo.com | Avenida Siempreviva 742 | 01    | Springfield | 12345-6789 |

  Scenario Outline: modificar usuario y verificar el nombre
    * url 'https://jsonplaceholder.typicode.com'
    * def ruta = 'users/<identif>'
    * replace ruta.identif = <id>
    Given path ruta
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
    And match response.name == 'Homero'
    Examples:
    | id | name   | username | email                      | street                  | suite | city        | zipcode    |
    | 4  | Homero | homeroS  | homero.simpson@ejemplo.com | Avenida Siempreviva 742 | 01    | Springfield | 12345-6789 |