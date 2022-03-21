
# Формат первого аргумента

```text
Template-fied HEX 32-bit number.
'_' used only in cosmetic purposes:

    0xMKLP_UJBH

unk_1 (expected_to_be_0x0D)    = 0x0000000L
unk_2 (path_chksum_expected)   = 0xPUJB
unk_3 (request_id)             = 0x0000000H
sleep_s                 = 0x10 - 0x0000000K

    0x0_K_L_PUJB_H

M is unused and can be random.
```

Пример: `0x0FD10084` будет ждать 1 секунду, хэш пути должен быть 0x1008, request_id = 4.
