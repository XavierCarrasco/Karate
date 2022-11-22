#language:es

Característica: sample karate test script
for help, see: https://github.com/intuit/karate/wiki/IDE-Support

Antecedentes:
* url 'https://jsonplaceholder.typicode.com'

Escenario: get all users and then get the first user by id
Dado ruta 'users'
Cuando metodo get
Entonces estado 200
Y relacionar $.[2].username == "Samantha"