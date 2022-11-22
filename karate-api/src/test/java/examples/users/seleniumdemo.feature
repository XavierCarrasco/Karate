Feature: ejemplo de Selenium
  Como usuario
  Quiero realizar una búsqueda en Google
  Para verificar el primer resultado

Scenario: Ejemplo de Atomatizaicón UI
  * configure driver = { type: 'chrome' }
  * configure driver = { target: null }
  Given driver 'https://www.facebook.com'
  * maximize()
  And waitFor("input[title='Search']")
  And input("input[title='Search']", 'karate ui automation')
  And waitFor(".FPdoLc input[value='Google Search']")
  When click(".FPdoLc input[value='Google Search']")
  Then waitFor("//h3[text()='UI Testing with Karate - Knoldus Blogs']")
