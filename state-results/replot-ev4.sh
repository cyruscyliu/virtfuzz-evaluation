../statecovshow sprofile-videzzo-qemu-xhci-arp-1-1664178267 "ViDeZZo (24 hours)" > videzzo.dot
../statecovshow sprofile-videzzo++-qemu-xhci-arp-1-1666182257 "ViDeZZo++ (24 hours)" > videzzo++.dot
../statecovshow sprofile-nyx-qemu-qemu_xhci-none-9-1664088872 "Nyx (24 hours)" > nyx.dot
dot -Tpdf -O videzzo.dot
dot -Tpdf -O videzzo++.dot
dot -Tpdf -O nyx.dot
