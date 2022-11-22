Feature: ejemplos de tipo delete
  Como usuario
  Quiero realizar peticiones de tipo delete
  Para verificar que se eliminan los usuarios

  Scenario: eliminar a un usuario
    Given url 'https://jsonplaceholder.typicode.com/users/4'
    When method delete
    Then status 200

  Scenario: eliminar usuario separando url de path
    * url 'https://jsonplaceholder.typicode.com'
    Given path 'users/4'
    When method delete
    Then status 200

  Scenario Outline: eliminar usuario con id dado
    * url 'https://jsonplaceholder.typicode.com'
    * def ruta = 'users/<identificador>'
    * replace ruta.identificador = <id>
    Given path ruta
    When method delete
    Then status 200
    Examples:
    | id |
    | 4  |

  Scenario Outline: eliminar usuario con id dado verificando que el response sea vacío
    * url 'https://jsonplaceholder.typicode.com'
    * def ruta = 'users/<identif>'
    * replace ruta.identif = <id>
    Given path ruta
    When method delete
    Then status 200
    And match response == {}
    Examples:
    | id |
    | 4  |

  Scenario Outline: eliminar los usuarios con id 3, 4, 8
    * url 'https://jsonplaceholder.typicode.com'
    * def ruta = 'users/<identificador>'
    * replace ruta.identificador = <id>
    Given path ruta
    When method delete
    Then status 200
    Examples:
    | id |
    | 3  |
    | 4  |
    | 8  |

    # debería dar error - 15 es un id no válido
  Scenario Outline: eliminar un usuario con id inválido
    * url 'https://jsonplaceholder.typicode.com'
    * def ruta = 'users/<identificador>'
    * replace ruta.identificador = <id>
    Given path ruta
    When method delete
    Then status 200
    Examples:
    | id |
    | 15 |
    # la api tiene un fallo ahí, elimina usuarios que no existen

  Scenario Outline: eliminar un usuario y validar que el response contenga algo
    * url 'https://jsonplaceholder.typicode.com'
    * def ruta = 'users/<identificador>'
    * replace ruta.identificador = <id>
    Given path ruta
    When method delete
    Then status 200
    And match response.id == 10
    Examples:
      | id |
      | 10 |
    # da error porque el response no tiene ningún id

  Scenario Outline: eliminar un usuario inválido y validar el id del response
    * url 'https://jsonplaceholder.typicode.com'
    * def ruta = 'users/<identificador>'
    * replace ruta.identificador = <id>
    Given path ruta
    When method delete
    Then status 200
    And match response.id == 68
    Examples:
      | id |
      | 68 |