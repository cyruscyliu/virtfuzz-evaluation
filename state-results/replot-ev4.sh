../statecovshow sprofile-videzzo-qemu-xhci-arp-1-1664178267 "ViDeZZo (24 hours)" > videzzo.dot
../statecovshow sprofile-videzzo++-qemu-xhci-arp-1-1666182257 "ViDeZZo++ (24 hours)" > videzzo++.dot
dot -Tpdf -O videzzo.dot
dot -Tpdf -O videzzo++.dot
