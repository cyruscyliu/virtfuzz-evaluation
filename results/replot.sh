# evaluation 1
python3 cov24plot.py virtfuzz-ac97.csv qtest-ac97.csv VQ
python3 cov24plot.py virtfuzz-ac97.csv qtest-ac97.csv nyx-ac97.csv VQN
python3 cov24plot.py virtfuzz-cs4231a.csv qtest-cs4231a.csv VQ
python3 cov24plot.py virtfuzz-cs4231a.csv qtest-cs4231a.csv nyx-cs4231a.csv VQN
python3 cov24plot.py virtfuzz-es1370.csv qtest-es1370.csv VQ
python3 cov24plot.py virtfuzz-intel-hda.csv qtest-intel-hda.csv VQ
python3 cov24plot.py virtfuzz-intel-hda.csv qtest-intel-hda.csv nyx-intel-hda.csv VQN
python3 cov24plot.py virtfuzz-sb16.csv qtest-sb16.csv VQ
python3 cov24plot.py virtfuzz-sb16.csv qtest-sb16.csv nyx-sb16.csv VQN
python3 cov24plot.py virtfuzz-ahci.csv qtest-ahci.csv VQ
python3 cov24plot.py virtfuzz-floppy.csv qtest-floppy.csv VQ
python3 cov24plot.py virtfuzz-floppy.csv qtest-floppy.csv nyx-floppy.csv VQN
python3 cov24plot.py virtfuzz-sdhci.csv qtest-sdhci.csv VQ
python3 cov24plot.py virtfuzz-megasas.csv qtest-megasas.csv VQ
python3 cov24plot.py virtfuzz-e1000.csv qtest-e1000.csv VQ
python3 cov24plot.py virtfuzz-e1000.csv qtest-e1000.csv nyx-e1000.csv VQN
python3 cov24plot.py virtfuzz-e1000e.csv virtfuzz-e1000e_core.csv qtest-e1000e.csv qtest-e1000e_core.csv VVQQ
python3 cov24plot.py virtfuzz-eepro100.csv qtest-eepro100.csv VQ
python3 cov24plot.py virtfuzz-eepro100.csv qtest-eepro100.csv nyx-eepro100.csv VQN
python3 cov24plot.py virtfuzz-ne2000.csv qtest-ne2000.csv VQ
python3 cov24plot.py virtfuzz-ne2000.csv qtest-ne2000.csv nyx-ne2000.csv VQN
python3 cov24plot.py virtfuzz-pcnet.csv qtest-pcnet.csv VQ
python3 cov24plot.py virtfuzz-pcnet.csv qtest-pcnet.csv nyx-pcnet.csv VQN
python3 cov24plot.py virtfuzz-rtl8139.csv qtest-rtl8139.csv VQ
python3 cov24plot.py virtfuzz-rtl8139.csv qtest-rtl8139.csv nyx-rtl8139.csv VQN
python3 cov24plot.py virtfuzz-ati.csv virtfuzz-ati2d.csv VV
python3 cov24plot.py virtfuzz-cirrus-vga.csv qtest-cirrus-vga.csv VQ
python3 cov24plot.py virtfuzz-uhci.csv qtest-uhci.csv VQ
python3 cov24plot.py virtfuzz-uhci.csv qtest-uhci.csv vshuttle-uhci.csv VQV
python3 cov24plot.py virtfuzz-ohci.csv qtest-ohci.csv vshuttle-ohci.csv VQV
python3 cov24plot.py virtfuzz-ehci.csv qtest-ehci.csv vshuttle-ehci.csv VQV

# evaluation 2
python3 cov24plot.py virtfuzz-uhci.csv virtfuzz-m-uhci.csv virtfuzz-f-uhci.csv qtest-uhci.csv VVVQ
python3 cov24plot.py virtfuzz-ehci.csv virtfuzz-m-ehci.csv virtfuzz-f-ehci.csv qtest-ehci.csv VVVQ
python3 cov24plot.py virtfuzz-ohci.csv virtfuzz-m-ohci.csv virtfuzz-f-ohci.csv qtest-ohci.csv VVVQ
