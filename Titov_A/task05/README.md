# Task 05

Подразумевается, что уже есть приложение для генерации ключа и описан способ
его валидации (функция `int __fastcall x_validate_key_main(const char *path, uint32_t key)`). 

Эта функция возвращает `request_id`, который содержит идентификатор запроса (назвал его Request).
Напомню, что Request ID декапсулируется из переданного ключа.

В функции `req_data_t * x_prepare_req_data(uint32_t argc, const char **argv, uint32_t request_id)` происходит обработка входных данных и генерация DTO для дальнейшего выполнения Request'а.

Request выполняется в функции `int x_do_request(uint32_t req_id, req_data_t *req_data, req_result_t *out, uint32_t *out_size)`.
Аргументы функции:
- `req_id` -- ID запроса (получен из `x_validate_key_main`)
- `req_data` -- DTO для запроса (из `x_prepare_req_data`)
- `out` -- результат работы функции. Содержит указатель на одну из структур результата (для удобства объединены в Union `req_result_t`)
- `out_size` -- размер результирующей структуры.

*Примечание: `x_do_request` **в начале работы** выводит строку следующего содержания: `do_request(<request_id>, <req_data*>, <req_result_>, <out_size, всегда 0>)`*

Ниже показана таблица, описывающая поведение в зависимости от Request ID.
В столбце `Addit. args` описаны дополнительные CLI аргументы, требуемые для выполнения запроса.
В столбце `Outs (out_type, out_size)` описан тип возвращаемого указателя на  результирующую структуру.

## Request ID 

|ID|Descrption|Addit. args|Outs `(out_type, out_size)`|
|---|---|---|---|
|1|"Dummy request, hello xd"|---|`(0, 0)`|
|2|Print all arguments (argv)|---|`(0, 0)`|
|3|Check checksum in argv3 for path in argv2 |`path, expected_checksum`|`(req_result_3_t*, 4)`|
|4|Шифр простой замены|`str_to_encode, offset`|`(_req_result_4*, len(str_to_encode) + 1)`|
|5|Char sort|`str_to_srt`|`(char *, len(str_to_srt) + 1)`|
|6|"Should not be called"|---|---|

Ниже подробнее описаны некоторые запросы.

### Request 4

Алфавит: `ABCDEFGHIJKLMNOPQRSTUVWXYZ_`.

Если в `str_to_encode` есть неалфавитный символ, то возвращается ошибка "buffer contains character not within alphabe" и результат slice'ится до текущего индекса

Алгоритм шифра (на python, для корректной строки `str_to_encode`):
```python
result = [
    ALPHABET[ (offset + ALPHABET.index(char)) % len(ALPHABET) ]
    for char in str_to_encode
]
```

Пример расчета для символа `B` и `offset = 5`:
```
offset         = 5
ALPHABET.index = 1
(offset + ALPHABET.index(char)) % len(ALPHABET) = 6

ALPHABET[6] = 'G' = '\x47'
```

### Request 5

Сортировка: Selection Sort с модификацией (swap производится всегда при нахождении бОльшиего элемента) или Bubble Sort с модификацией (обмен производится с элементом фиксированного индекса). 

Worst case complexity: `O(n^2)` comparisons and `O(n^2)` swaps. Is unstable (из-за модификации).
По дороге из-за доп. операции потеряна стабильность сортировки.

# Examples

## Request 2

Очень полезный и информативный пример

```
.\task04.exe 265306386 q w e r t y u i o p

Hello, I am perhaps one of ur first crackme! Be careful with me!
U should pass my checks!
Extracting parameters for check....
size of extraction = 1
path[0411] = .\task04.exe
do_request(2, 0000000000AA7270, 000000000060FE08, 0)
arg[0] = .\task04.exe
arg[1] = 265306386
arg[2] = q
arg[3] = w
arg[4] = e
arg[5] = r
arg[6] = t
arg[7] = y
arg[8] = u
arg[9] = i
arg[10] = o
arg[11] = p
```

## Request 3

```
.\task04.exe <Key with Request ID 3> "asdasd" 29536

Hello, I am perhaps one of ur first crackme! Be careful with me!
U should pass my checks!
Extracting parameters for check....
size of extraction = 1
path[0411] = .\task04.exe
do_request(3, 0000000000BC24B0, 000000000060FE08, 0)
60 73 01 00

^^ ^^
Checksum in mem (number 0x7360 stored as 60 73)
      ^^ ^^
      Checksum match result (1 means matched, 0 -- otherwise)
```

## Request 4

```
\task04.exe 265306388 AMOBUS 5    

Hello, I am perhaps one of ur first crackme! Be careful with me!
U should pass my checks!
Extracting parameters for check....
size of extraction = 1
path[0411] = .\task04.exe
Prepare args for request 4
do_request(4, 00000000001824B0, 000000000060FE08, 0)
46 52 54 47 5A 58 00
         ^^
    '\x47' == 'G' (calculated in the previous section)
```

## Request 5

```
.\task04.exe 265306389 0123456789

Hello, I am perhaps one of ur first crackme! Be careful with me!
U should pass my checks!
Extracting parameters for check....
size of extraction = 1
path[0411] = .\task04.exe
do_request(5, 0000000000992480, 000000000060FE08, 0)
39 38 37 36 35 34 33 32 31 30 00
```