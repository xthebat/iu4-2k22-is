# Parameters

- `sleep` Количество секунд ожидания (сек) от 1 до 15,
- `request_id` ID запроса от 0 до 6
- `path` Путь до исполняемого файла (для Windows необходимо использовать `\`)

# How to run

Команда для запуска:
`cargo run -- -p "C:\path\to\task04.exe" -s <sleep> -r <request_id>`

Пример вывода:
```text
    Finished dev [unoptimized + debuginfo] target(s) in 0.05s
     Running `target\debug\task04.exe -p C:\Users\Toliak\Downloads\task04\task04.exe -s 1 -r 4`
Key: 0x0FD10084
Execute this:
C:\Users\Toliak\Downloads\task04\task04.exe 265355396
```

Вывод приложения:
- HEX запись ключа
- и команда для запуска
(у раста [какие-то явные проблемы с выводом runtime логов от запущенного процесса](https://stackoverflow.com/questions/34611742/how-do-i-read-the-output-of-a-child-process-without-blocking-in-rust), 
поэтому вывод команды необходимо произвести самостоятельно) 
