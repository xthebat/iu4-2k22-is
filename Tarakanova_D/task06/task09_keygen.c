#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int __fastcall x_copy_file_SerialNumber(char *ser_number)
{
  char Buffer[1032]; // [rsp+20h] [rbp-60h] BYREF
  FILE *Stream; // [rsp+428h] [rbp+3A8h]

  Stream = popen("wmic path win32_physicalmedia get SerialNumber", "r");
  if ( !Stream )
    exit(1);
  fgets(Buffer, 1024, Stream);
  memset(Buffer, 0, 1024);
  fgets(Buffer, 1024, Stream);
  strcpy(ser_number, Buffer);
  ser_number[strlen(ser_number) - 1] = 0;
  pclose(Stream);
  return 0;
}

int main(const int argc, const char** argv[])
{
	//int *lic_status, __int64 username, __int64 password
    long long result; // rax
    size_t point; // rbx
    char ser_number[128]; // [rsp+20h] [rbp-60h] BYREF
    char _hash; // [rsp+A9h] [rbp+29h]
    short salt_string; // [rsp+AAh] [rbp+2Ah]
    int i; // [rsp+ACh] [rbp+2Ch]
    int v_global_flag = 1;
    int password;
    //int* buf;


    if (argc<2){
        printf("not enough args, gimme username");
        return -1;
    }

    i = 0;
    int len = strlen(argv[1]);
    int username[len];

    printf("len: %i\n", len);
    printf(" username:");
    while(i < len)
    {
        username[i] = (int)argv[1][i];
        printf("%c", username[i]);
        i++;
    }
    printf("\n", len);
    memset(ser_number, 0, sizeof(ser_number));
    x_copy_file_SerialNumber(ser_number);
    salt_string = 0;
    i = 0;

    printf(" serial_number:%s \n", ser_number);

    while(i < strlen(ser_number))
    {
        salt_string += ser_number[i];
        i++;
    }
    printf(" salt:%d \n", salt_string);
    printf(" password:");
    for (int j = 0; j < 8 ; j++ )
    {
		_hash = (char)((int)salt_string ^ username[j]) % 25 + 'a';
		password = (int)_hash;
        if ( v_global_flag ){
			putchar(password);
		}

    }
    if ( v_global_flag ){
        putchar('\n');
    }

    return 0;
}
