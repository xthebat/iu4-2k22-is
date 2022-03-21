/**
 * Компилируемость was not checked.
 * Типы int32_t и подобные обозначал в стиле Rust'а (i32, u32, ...)
 */

#define NULL ((void *) 0)

typedef struct _req_data_2 req_data_2_t;
struct _req_data_2
{
  const char *argv;
  u32 argc;
}; //sizeof == 0x10

typedef struct _req_data_3 req_data_3_t;
struct _req_data_3
{
  const char *argv2;
  u16 argv3;
}; // sizeof == 0x10

typedef struct _req_data_4 req_data_4_t;
struct _req_data_4
{
  const char *argv2;
  const char *alphabet;
  u32 argv3;
}; // sizeof == 0x18

typedef struct _req_data req_data_t;
union _req_data
{
    req_data_2_t r2;
    req_data_3_t r3;
    req_data_4_t r4;
    const char *r5;
};

u32 x_sleep_wrap_in(u32 sleep_us) {
    /**
     * Python version for checking: 
     * `s = lambda x: (x * 0x10624DD3) >> 0x26`
     * `[s(i) for i in range(0,10000, 100)]`
     * Вуаля, оказывается так компилятор раскрыл деление на 1000
     */
    u64 sleep_ms = (((u64) sleep_us) * 0x10624DD3) >> 0x26;

    // Тыкает extern функцию
    Sleep(sleep_ms);
}

u32 x_sleep_wrap(u32 sleep_s) {
    return x_sleep_wrap_in(sleep_s * 1_000_000);
}

/**
 * Все интересное здесь
 */
u32 x_decapsulate_key(i32 key, u32 *flag, u16 *path_chksum, u32 *req_id)
{
    puts("Extracting parameters for check...\n");

    *flag = (key >>> 0x14) & 0xF;      // Сдвиг арифметический
    *path_checksum = (u16) (key >>> 4);
    *req_id = key & 0xF;

    // На самом деле "size of extraction" -- количество секунд для сна :)
    u32 sleep_s = 0x10 - ( (key >>> 0x18) & 0xF );
    printf("size of extraction = %d\n", sleep_s);

    x_sleep_wrap(sleep_s);

    return 0;
}

u32 x_path_chksum(const char* path, u64 path_len, u16 *result)
{
    // В дизасме оно выглядит как if с do .. while
    // Но мы ведь разбирали на лекции, что это преобразованный for :)))

    // Там в дизасме еще какой-то mental brakedown с [rcx + (rdx - 1) + 1]

    for (u64 i = 0; i < path_len; ++i) {
        *result += ((u8) path[i]);
    }

    return 0;
}

u32 x_check_path_checksum(const char *path, u32 path_chksum_exp, u32 *path_chksum)
{
    x_path_chksum(path, strlen(path), path_chksum);
    return path_chksum_exp == *path_chksum;
}

u32 x_validate_key_main(const char* path, u32 key)
{
    puts("U should pass my checks!");

    u16 path_checksum_exp = 0;  // expected checksum (decapsulated from the key)
    u32 flag = 0;               // must be 0x0D (unk_1 in IDB)
    u32 request_id = 0;         // (unk_3 in IDB)

    x_decapsulate_key(key, &flag, &path_checksum_exp, &request_id);
    assert(flag == 0x0D, "flag == 13");

    u32 path_checksum = 0;      // calculated checksum
    u32 rslt = x_check_path_checksum(path, path_checksum_exp, &path_checksum);

    printf("path[%04X] = %s\n", path_checksum, path);
    assert(rslt == 1, "is_ok");

    return request_id;
}

#define MALLOC(_name) malloc(sizeof(typeof(*_name)))

req_data_t *x_prepare_req_data(int argc, const char** argv, u32 req_id)
{
    req_data_t *data = NULL;

    switch (req_id) {
        case 1: {
            break;
        };
        case 2: {
            req_data_2_t* local_data = MALLOC(local_data);
            local_data->argc = argc;
            local_data->argv = argv;

            data = local_data;
            break;
        };
        case 3: {
            if (argc <= 3) {
                puts("Not enough arguments for this request");
            } else {
                req_data_3_t* local_data = MALLOC(local_data);
                local_data->argv2 = argv[2];
                local_data->argv3 = atoi(argv[3]);

                data = local_data;
            }
            break;
        };
        case 4: {
            if (argc <= 3) {
                puts("Not enough arguments for this request");
            } else {
                req_data_4_t* local_data = MALLOC(local_data);
                local_data->alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ_";
                local_data->argv2 = argv[2];
                local_data->argv3 = atoi(argv[3]);

                data = local_data;
            }
            break;
        };
        case 5: {
            if (argc <= 2) {
                puts("Not enough arguments for this request");
            } else {
                // Allocate a memory for (const char *).
                // Therefore, the result will be pointer to pointer :)
                const char** local_data = MALLOC(local_data);
                local_data->argv2 = argv[2];

                data = local_data;
            }
            break;
        }
    }

    return data;
}

int x_main(int argc, const char** argv)
{
    x_unk(); // Какие-то глобалки перекладывает. Не нашел влияние на первый аргумент

    puts("Hello, I am your first creackme\n");

    if (argc <= 1) {
        printf("Not enough arguments, only %d specified\n", argc);
        return -1;
    }

    const char *path = argv[0];
    u32 key = atoi(argv[1]);

    u32 req_id = x_validate_key_main(path, key);
    req_data_t* data = x_prepare_req_data(argc, argv, req_id);

    u64 unk_1_out;
    u32 unk_2_out;
    x_do_request(req_id, data, &unk_1_out, &unk_2_out);

    // unk
    // did not reversed
}
