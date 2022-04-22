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

**Warning**: `-r` and `-k` are complementary. They should not be provided together.

# Password

1. Необходимо установить ENV переменную `ARE_YOU_SURE` в любое строковое значение. Для CMD синтаксис следующий: `set ARE_YOU_SURE="sample text"`

2. Для вычисления пароля необходимо узнать SerialNumber следующей командой: `wmic path win32_physicalmedia get SerialNumber`.

Команда возвращает две строки, необходимо взять нижнюю.
Её вид следующий: `0025_3854_91B3_186E.  \r`.
Important: the string ends  with 2 spaces (0x20) and R-char (0x0D). Take this into account while doing next steps.

3. Необходимо высчитать "магическое число" из серийного номера (п.2) путём сложения всех char (u8) в один u32.

4. Для вычисления пароля необходим username and magic number from p.3.
Username must have length less or equal 8. 
If the length is less than 8, the username **must** be padded with zeroes.

5. Password calculation is begin performed for each username character using the formula:
```
// salt is u32
// password is u8[8]
// username is u8[8]

password[i] = (username[i] ^ salt) % 25  + 'a'
```

Also, there is a complete description with the type convertions:
```
password[i] = ( ((username[i] as u32) ^ salt) % 25 ) as u8 + ('a' as u8)
```


# Что делает (сама нагрузка программы)

1. Считывает файл в память.
2. Применяет преобразование (о нём ниже).
3. Выводит данные на экран.

## File content transformation:

- No `-r` and `-k` arguments specified.
The raw content of the file will be revealed on the screen

- `-r` argument provided.
Will be generated random salt, that will be XORed with each character of the file content.  
**Warning**: there is no random initialization, therefore, key `41` (dec) will be used. This behaviour equals to passing `-k 41` instead of `-r` as an argument .

- `-k <key (u8 number)>`.
Manually specifies salt, that will be XORed with each character of the file content.
