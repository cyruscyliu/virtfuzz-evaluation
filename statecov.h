#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <fcntl.h>
#include <stdbool.h>

#define StateMachineSize (1 << 8) // 256
#define NodeSize (1 << 6) // 64
#define EdgeSize ((1 << 6) * ((1 << 6) - 1)) // 64 * 63

typedef struct StateMachine {
    size_t LastNode;
    uint8_t NodeMap[NodeSize];
    uint8_t EdgeMap[EdgeSize];
} StateMachine;

static uint8_t GetNodeValue(StateMachine *Table, uint8_t StateMachineId, size_t Node) {
    return Table[StateMachineId].NodeMap[Node];
}

static uint8_t GetEdgeValue(StateMachine *Table, uint8_t StateMachineId, size_t Edge) {
    return Table[StateMachineId].EdgeMap[Edge];
}
