#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <fcntl.h>

#define StateMachineSize (1 << 8) // 256
#define NodeSize (1 << 6) // 64
#define EdgeSize ((1 << 6) * ((1 << 6) - 1)) // 64 * 63

typedef struct StateMachine {
    size_t LastNode;
    uint8_t NodeMap[NodeSize];
    uint8_t EdgeMap[EdgeSize];
} StateMachine;

uint8_t GetNodeValue(StateMachine *Table, uint8_t StateMachineId, size_t Node) {
    return Table[StateMachineId].NodeMap[Node];
}

uint8_t GetEdgeValue(StateMachine *Table, uint8_t StateMachineId, size_t Edge) {
    return Table[StateMachineId].EdgeMap[Edge];
}

int main(int argc, char **argv) {
    if (argc != 3) {
        printf("usage: %s sprofile-xxx time\n", argv[0]);
        exit(1);
    }

    char pathname_state[256] = {'\0'};
    memcpy(pathname_state, argv[1], strlen(argv[1]));

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
    int i = 0, j;
    uint8_t v;
    // for (j = 0; j < NodeSize; j++) {
    //     v = GetNodeValue(TableAccumulated, i, j);
    //     printf("%d: %d\n", j, v);
    // }
    printf("digraph {\n");
    printf("label=\"%s\"", argv[2]);
    printf("labelloc=top\n");
    printf("abeljust=rifht\n");
    printf("fontsize=50\n");
    printf("    layout=\"neato\"\n");
    printf("    1[label=\"1\", pos=\"7.855429578101654,1.5140099548832815!\", shape = \"square\"];\n");
    printf("    2[label=\"2\", pos=\"7.4269434641285805,2.97329964528262!\", shape = \"square\"];\n");
    printf("    3[label=\"3\", pos=\"6.73002826264945,4.32512653964478!\", shape = \"square\"];\n");
    printf("    4[label=\"4\", pos=\"5.789872304840562,5.520632091856895!\", shape = \"square\"];\n");
    printf("    5[label=\"5\", pos=\"4.640455276569586,6.516607616402685!\", shape = \"square\"];\n");
    printf("    6[label=\"6\", pos=\"3.3233201040150915,7.277055962836147!\", shape = \"square\"];\n");
    printf("    7[label=\"7\", pos=\"1.8860714840754182,7.774492546588333!\", shape = \"square\"];\n");
    printf("    8[label=\"8\", pos=\"0.3806553265899392,7.990938713464064!\", shape = \"square\"];\n");
    printf("    9[label=\"9\", pos=\"-1.13851870618628,7.918571535047462!\", shape = \"square\"];\n");
    printf("    10[label=\"10\", pos=\"-2.6165437065393715,7.5600065497173485!\", shape = \"square\"];\n");
    printf("    11[label=\"11\", pos=\"-3.9999999999999982,6.92820323027551!\", shape = \"square\"];\n");
    printf("    12[label=\"12\", pos=\"-5.23888587156228,6.045996594834066!\", shape = \"square\"];\n");
    printf("    13[label=\"13\", pos=\"-6.288424757942298,4.945271889764844!\", shape = \"square\"];\n");
    printf("    14[label=\"14\", pos=\"-7.110683589239387,3.665812173819284!\", shape = \"square\"];\n");
    printf("    15[label=\"15\", pos=\"-7.675943788915978,2.2538604547314405!\", shape = \"square\"];\n");
    printf("    16[label=\"16\", pos=\"-7.963775380584677,0.760448346433463!\", shape = \"square\"];\n");
    printf("    17[label=\"17\", pos=\"-7.963775380584677,-0.760448346433461!\", shape = \"square\"];\n");
    printf("    18[label=\"18\", pos=\"-7.67594378891598,-2.253860454731435!\", shape = \"square\"];\n");
    printf("    19[label=\"19\", pos=\"-7.110683589239388,-3.6658121738192824!\", shape = \"square\"];\n");
    printf("    20[label=\"20\", pos=\"-6.288424757942302,-4.94527188976484!\", shape = \"square\"];\n");
    printf("    21[label=\"21\", pos=\"-5.238885871562282,-6.045996594834065!\", shape = \"square\"];\n");
    printf("    22[label=\"22\", pos=\"-4.0000000000000036,-6.928203230275507!\", shape = \"square\"];\n");
    printf("    23[label=\"23\", pos=\"-2.616543706539375,-7.560006549717347!\", shape = \"square\"];\n");
    printf("    24[label=\"24\", pos=\"-1.1385187061862818,-7.9185715350474615!\", shape = \"square\"];\n");
    printf("    25[label=\"25\", pos=\"0.38065532658993906,-7.990938713464064!\", shape = \"square\"];\n");
    printf("    26[label=\"26\", pos=\"1.886071484075413,-7.774492546588335!\", shape = \"square\"];\n");
    printf("    27[label=\"27\", pos=\"3.3233201040150884,-7.277055962836148!\", shape = \"square\"];\n");
    printf("    28[label=\"28\", pos=\"4.6404552765695835,-6.516607616402687!\", shape = \"square\"];\n");
    printf("    29[label=\"29\", pos=\"5.789872304840561,-5.520632091856896!\", shape = \"square\"];\n");
    printf("    30[label=\"30\", pos=\"6.730028262649446,-4.325126539644786!\", shape = \"square\"];\n");
    printf("    31[label=\"31\", pos=\"7.426943464128579,-2.9732996452826246!\", shape = \"square\"];\n");
    printf("    32[label=\"32\", pos=\"7.855429578101653,-1.514009954883285!\", shape = \"square\"];\n");
    printf("    33[label=\"33\", pos=\"8.0,-1.959434878635765e-15!\", shape = \"square\"];\n");
    for (j = 0; j < EdgeSize; j++) {
        v = GetEdgeValue(TableAccumulated, i, j);
        if (v) {
            printf("    %d->%d[label=%d]\n", j / 64, j % 64, v);
        }
    }
    printf("}\n");

    return 0;
}
