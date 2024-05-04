{ config, ... }:

# Secret welcome chant

{
  age.secrets.hello.file = ../secrets/hello.age;

  environment.variables = {
    HI = config.age.secrets.hello.path;
  };

}
