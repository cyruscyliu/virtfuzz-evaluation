#include "statecov.h"

int main(int argc, char **argv) {
    if (argc < 3 || argc > 4) {
        printf("usage: %s output sprofile0 [sprofile1]\n", argv[0]);
        exit(1);
    }

    char pathname_output[256] = {'\0'};
    char pathname_state0[256] = {'\0'};
    char pathname_state1[256] = {'\0'};
    memcpy(pathname_output, argv[1], strlen(argv[1]));
    memcpy(pathname_state0, argv[2], strlen(argv[2]));
    if (argc == 4)
        memcpy(pathname_state1, argv[3], strlen(argv[3]));

    size_t Size = StateMachineSize * sizeof(StateMachine);
    uint8_t *Data0 = (uint8_t *)calloc(Size, 1);
    uint8_t *Data1 = (uint8_t *)calloc(Size, 1);

    FILE *f0 = fopen(pathname_state0, "rb");
    if (f0 == NULL) {
        printf("[-] %s failed to open. Exit.\n", pathname_state0);
        exit(1);
    }
    size_t ret0 = fread(Data0, 1, Size, f0);
    assert(ret0 == Size);
    fclose(f0);
    if (argc == 4) {
        FILE *f1 = fopen(pathname_state1, "rb");
        if (f1 == NULL) {
            printf("[-] %s failed to open. Exit.\n", pathname_state1);
            exit(1);
        }
        size_t ret1 = fread(Data1, 1, Size, f1);
        assert(ret1 == Size);
        fclose(f1);
    }
    // merge
    int a = 0, b = 0, c;
    for (int i = 0; i < Size; i++) {
	if (Data0[i] | Data1[i])
            Data0[i] = 1;
	else
            Data0[i] = 0;
    }
    FILE *fo = fopen(pathname_output, "wb");
    if (fo == NULL) {
        printf("[-] %s failed to open. Exit.\n", pathname_output);
        exit(1);
    }
    size_t reto = fwrite(Data0, 1, Size, fo);
    assert(reto == Size);
    fclose(fo);

    return 0;
}
