#include "statecov.h"

int main(int argc, char **argv) {
    if (argc != 5) {
        // 0 is for state coverage, and 1 is for state transition
        printf("usage: %s sprofile-xxx targetindex timestamp 0|1\n", argv[0]);
        exit(1);
    }

    char pathname_state[256] = {'\0'};
    memcpy(pathname_state, argv[1], strlen(argv[1]));
    bool control = atoi(argv[4]);

    size_t Size = StateMachineSize * sizeof(StateMachine);
    uint8_t *Data = (uint8_t *)calloc(Size, 1);

    FILE *f = fopen(pathname_state, "rb");
    if (f == NULL) {
        printf("[-] %s failed to open. Exit.\n", pathname_state);
        exit(1);
    }
    size_t ret = fread(Data, 1, Size, f);
    assert(ret == Size);
    fclose(f);

    StateMachine *TableAccumulated = (StateMachine *)Data;
    int i = 0/*there will be only one state machine*/, j, count = 0;
    uint8_t v;
    if (control == 0) {
        for (j = 0; j < NodeSize; j++) {
            v = GetNodeValue(TableAccumulated, i, j);
            if (v) count++;
        }
    } else {
        for (j = 0; j < EdgeSize; j++) {
            v = GetEdgeValue(TableAccumulated, i, j);
            if (v) count++;
        }
    }
    printf("%s %s %d\n", argv[3], argv[2], count);
    return 0;
}
