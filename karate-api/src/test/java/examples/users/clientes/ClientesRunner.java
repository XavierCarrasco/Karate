package examples.users.clientes;

import com.intuit.karate.junit5.Karate;

class ClientesRunner {

    @Karate.Test
    Karate testClientes() { return Karate.run("delete").relativeTo(getClass());}
}