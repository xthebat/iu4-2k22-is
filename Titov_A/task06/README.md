The program highly likely is file decipherer, that validates username and password and, then, decrypts the file.
Also it is able to print raw content (if no necessary arguments provided).

**Warning** Environment variable `ARE_YOU_SURE` must be provided with any non-zero length string.

**Warning** Do not enter username / password with length greater than 8 characters. It will cause the buffer overflow.

# Arguments

MAN-like documentation from the reversed task:

```
./task09.exe " " -u <username> -p <password> -f <file path> [-d -r -k -? ]

  " "
    Space argument, that is being required for password validation.
    Is Required.

  -u <username>
    Username.
    Is Required.

  -p <password>
    User's password, that will be validated in runtime.
    Is Required.

  -f <file path>
    Path to the file that will be processed in runtime.
    Is Required.

  -d
    Debug mode.
    Optional.
  
  -r
    Decipher the file.
    Optional.

  -k <key>
    Provide key for xoring with the file content.
    Optional.

  -?
    Prints rude words.
    Optional.

```

# Что делает

Work In Progress.
Либо выведет контент файла (по пути, переданному в `-f` аргументе), либо выведет заксоренный контент файла.
