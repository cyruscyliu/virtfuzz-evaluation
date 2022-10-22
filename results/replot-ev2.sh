python3 ../cov24plot.py \
    videzzo-qemu-ohci-arp.csv videzzo-qemu-ohci-ap.csv  videzzo-qemu-ohci-rp.csv  videzzo-qemu-ohci-p.csv \
    qtest-qemu-ohci-none.csv \
    vshuttle-qemu-ohci-none.csv  \
    VVVVSQ
python3 ../cov24plot.py \
    videzzo-qemu-xhci-arp.csv videzzo-qemu-xhci-ap.csv  videzzo-qemu-xhci-rp.csv  videzzo-qemu-xhci-p.csv \
    qtest-qemu-xhci-none.csv \
    nyx-qemu-legacy_xhci-none.csv \
    VVVVQN
python3 ../cov24plot.py \
    videzzo-qemu-xhci-arp.csv \
    videzzo++-qemu-xhci-arp.csv \
    nyx-qemu-qemu_xhci-none.csv \
    VVN
