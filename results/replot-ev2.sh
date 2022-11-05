python3 ../cov24plot3.py \
    videzzo-qemu-ohci-arp.csv videzzo-qemu-ohci-ap.csv  videzzo-qemu-ohci-rp.csv  videzzo-qemu-ohci-p.csv \
    qtest-qemu-ohci-none.csv \
    vshuttle-qemu-ohci-none.csv  \
    VVVVSQ
python3 ../cov24plot3.py \
    videzzo-qemu-xhci-arp.csv videzzo-qemu-xhci-ap.csv  videzzo-qemu-xhci-rp.csv  videzzo-qemu-xhci-p.csv \
    qtest-qemu-xhci-none.csv \
    nyx-qemu-legacy_xhci-none.csv \
    VVVVQN
python3 ../cov24plot3.py \
    videzzo-qemu-xhci-arp.csv \
    videzzo++-qemu-xhci-arp.csv \
    nyx-qemu-qemu_xhci-none.csv \
    VVN
python3 ../cov24plot3.py \
    videzzo-qemu-uhci-arp.csv videzzo-qemu-uhci-ap.csv  videzzo-qemu-uhci-rp.csv  videzzo-qemu-uhci-p.csv \
    qtest-qemu-uhci-none.csv \
    vshuttle-qemu-uhci-none.csv  \
    VVVVSQ
python3 ../cov24plot3.py \
    videzzo-qemu-ehci-arp.csv videzzo-qemu-ehci-ap.csv  videzzo-qemu-ehci-rp.csv  videzzo-qemu-ehci-p.csv \
    qtest-qemu-ehci-none.csv \
    vshuttle-qemu-ehci-none.csv  \
    VVVVSQ
