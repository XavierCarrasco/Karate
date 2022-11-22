function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    //env = 'dev';
    env = 'local';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    _urlBase: 'google.com.pe'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  } else if (env == 'local') {
    config._urlBase = 'https://reqres.in/';
  }
  return config;
}