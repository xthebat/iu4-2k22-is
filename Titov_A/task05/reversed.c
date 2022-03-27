/**
 * Компилируемость was not checked.
 * Типы int32_t и подобные обозначал в стиле Rust'а (i32, u32, ...)
 */

#define NULL ((void *) 0)

// Structures скопипащены из моей task04

typedef struct _req_data_2 req_data_2_t;
struct _req_data_2
{
  const char **argv;   // тут была опечатка в task04
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
 


typedef struct _req_result_3 req_result_3_t;
struct _req_result_3 {
    u16 checksum;
    u16 checksum_matched;
}

typedef struct _req_result_4 req_result_4_t;
struct _req_result_4 {
    char *result;
}

typedef struct _req_result req_result_t;
union _req_result {
    req_result_3_t *r3;
    req_result_4_t *r4;
}
