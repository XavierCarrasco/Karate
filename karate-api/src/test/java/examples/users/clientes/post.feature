Feature: ejemplos de tipo POST
  Como usuario
  Quiero ejecutar peticiones de tipo post
  Para validar la creación de usuarios

  Scenario: crear un nuevo usuario
    Given url 'https://jsonplaceholder.typicode.com/users'
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
    When method post
    Then status 201

  Scenario: crear nuevo usuario separando url y path
    * url 'https://jsonplaceholder.typicode.com'
    Given path 'users'
    # otra forma de declarar el body
    And request {name: 'Homero', username: 'homeroS', email: 'homero.simpson@ejemplo.com', address: {street: 'Avenida Siempreviva 742', suite: '01', city: 'Springfield', zipcode: '12345-6789'}}
    When method post
    Then status 201

  Scenario Outline: crear usuario con datos dados
    * url 'https://jsonplaceholder.typicode.com'
    Given path 'users'
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
    When method post
    Then status 201
    Examples:
    | name   | username | email                      | street                  | suite | city        | zipcode    |
    | Homero | homeroS  | homero.simpson@ejemplo.com | Avenida Siempreviva 742 | 01    | Springfield | 12345-6789 |

  Scenario Outline: crear usuario con datos dados y verificando el nombre
    * url 'https://jsonplaceholder.typicode.com'
    Given path 'users'
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
    When method post
    Then status 201
    # otra forma de llamar al response: $
    And match $.name == 'Homero'
    Examples:
    | name   | username | email                      | street                  | suite | city        | zipcode    |
    | Homero | homeroS  | homero.simpson@ejemplo.com | Avenida Siempreviva 742 | 01    | Springfield | 12345-6789 |