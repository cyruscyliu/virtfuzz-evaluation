# evaluation 1
python3 ../cov24plot.py videzzo-qemu-ac97-arp.csv qtest-qemu-ac97-none.csv nyx-qemu-legacy_ac97-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-cs4231a-arp.csv qtest-qemu-cs4231a-none.csv nyx-qemu-legacy_cs4231a-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-es1370-arp.csv qtest-qemu-es1370-none.csv nyx-qemu-legacy_es1370-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-intelhda-arp.csv qtest-qemu-intelhda-none.csv nyx-qemu-legacy_intelhda-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-sb16-arp.csv qtest-qemu-sb16-none.csv nyx-qemu-legacy_sb16-none.csv VQN

python3 ../cov24plot.py videzzo-qemu-ahci-arp.csv qtest-qemu-ahci-none.csv VQ
python3 ../cov24plot.py videzzo-qemu-floppy-arp.csv qtest-qemu-floppy-none.csv nyx-qemu-legacy_floppy-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-sdhci-arp.csv qtest-qemu-sdhci-none.csv nyx-qemu-legacy_sdhci-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-megasas-arp.csv qtest-qemu-megasas-none.csv VQ
python3 ../cov24plot.py videzzo-qemu-e1000-arp.csv qtest-qemu-e1000-none.csv nyx-qemu-legacy_e1000-none.csv VQN

python3 ../cov24plot.py videzzo-qemu-e1000e-arp.csv qtest-qemu-e1000e-none.csv VQ
python3 ../cov24plot.py videzzo-qemu-e1000e_core-arp.csv qtest-qemu-e1000e_core-none.csv VQ
python3 ../cov24plot.py videzzo-qemu-eepro100-arp.csv qtest-qemu-eepro100-none.csv nyx-qemu-legacy_ee100pro-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-ne2000-arp.csv qtest-qemu-ne2000-none.csv nyx-qemu-legacy_ne2000-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-pcnet-arp.csv qtest-qemu-pcnet-none.csv nyx-qemu-legacy_pcnet-none.csv VQN
python3 ../cov24plot.py videzzo-qemu-rtl8139-arp.csv qtest-qemu-rtl8139-none.csv nyx-qemu-legacy_rtl8139-none.csv VQN

python3 ../cov24plot.py videzzo-qemu-ati-arp.csv V
python3 ../cov24plot.py videzzo-qemu-ati2d-arp.csv V
python3 ../cov24plot.py videzzo-qemu-cirrusvga-arp.csv qtest-qemu-cirrusvga-none.csv VQ

python3 ../cov24plot.py videzzo-qemu-ehci-arp.csv qtest-qemu-ehci-none.csv vshuttle-qemu-ehci-none.csv   VQS
python3 ../cov24plot.py videzzo-qemu-ohci-arp.csv qtest-qemu-ohci-none.csv vshuttle-qemu-ohci-none.csv   VQS
python3 ../cov24plot.py videzzo-qemu-uhci-arp.csv qtest-qemu-uhci-none.csv vshuttle-qemu-uhci-none.csv   VQS
python3 ../cov24plot.py videzzo-qemu-xhci-arp.csv qtest-qemu-xhci-none.csv nyx-qemu-legacy_xhci-none.csv nyx-qemu-qemu_xhci-none.csv VQNN

python3 ../cov24plot.py videzzo-qemu-virtioblki386-x86.csv videzzo-qemu-virtioblkx8664-x8664.csv qemufuzzer-qemu-virtioblk-none.csv VVQ
