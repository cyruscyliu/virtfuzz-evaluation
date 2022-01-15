# evaluation 1
python3 cov24plot.py virtfuzz-ac97.csv qtest-ac97.csv
python3 cov24plot.py virtfuzz-ac97.csv qtest-ac97.csv nyx-ac97.csv
python3 cov24plot.py virtfuzz-cs4231a.csv qtest-cs4231a.csv
python3 cov24plot.py virtfuzz-cs4231a.csv qtest-cs4231a.csv nyx-cs4231a.csv
python3 cov24plot.py virtfuzz-es1370.csv qtest-es1370.csv
python3 cov24plot.py virtfuzz-intel-hda.csv qtest-intel-hda.csv
python3 cov24plot.py virtfuzz-intel-hda.csv qtest-intel-hda.csv nyx-intel-hda.csv
python3 cov24plot.py virtfuzz-sb16.csv qtest-sb16.csv
python3 cov24plot.py virtfuzz-ahci.csv qtest-ahci.csv
python3 cov24plot.py virtfuzz-floppy.csv qtest-floppy.csv nyx-floppy.csv # missing qtest-floopy.csv
python3 cov24plot.py virtfuzz-sdhci.csv qtest-sdhci.csv
python3 cov24plot.py virtfuzz-megasas.csv qtest-megasas.csv
python3 cov24plot.py virtfuzz-e1000.csv qtest-e1000.csv
python3 cov24plot.py virtfuzz-e1000e.csv virtfuzz-e1000e_core.csv qtest-e1000e.csv qtest-e1000e_core.csv
python3 cov24plot.py virtfuzz-eepro100.csv qtest-eepro100.csv
python3 cov24plot.py virtfuzz-ne2000.csv qtest-ne2000.csv
python3 cov24plot.py virtfuzz-pcnet.csv qtest-pcnet.csv
python3 cov24plot.py virtfuzz-rtl8139.csv qtest-rtl8139.csv
python3 cov24plot.py virtfuzz-ati.csv virtfuzz-ati2d.csv
python3 cov24plot.py virtfuzz-cirrus-vga.csv qtest-cirrus-vga.csv
python3 cov24plot.py virtfuzz-uhci.csv qtest-uhci.csv
python3 cov24plot.py virtfuzz-uhci.csv qtest-uhci.csv vshuttle-uhci.csv
python3 cov24plot.py virtfuzz-ohci.csv qtest-ohci.csv vshuttle-ohci.csv
python3 cov24plot.py virtfuzz-ehci.csv qtest-ehci.csv vshuttle-ehci.csv

# evaluation 2
python3 cov24plot.py virtfuzz-uhci.csv virtfuzz-m-uhci.csv virtfuzz-f-uhci.csv qtest-uhci.csv
python3 cov24plot.py virtfuzz-ehci.csv virtfuzz-m-ehci.csv virtfuzz-f-ehci.csv qtest-ehci.csv
python3 cov24plot.py virtfuzz-ohci.csv virtfuzz-m-ohci.csv virtfuzz-f-ohci.csv qtest-ohci.csv
python3 cov24plot.py virtfuzz-uhci.csv virtfuzz-m-uhci.csv virtfuzz-f-uhci.csv vshuttle-uhci.csv qtest-uhci.csv
python3 cov24plot.py virtfuzz-ehci.csv virtfuzz-m-ehci.csv virtfuzz-f-ehci.csv vshuttle-ehci.csv qtest-ehci.csv
python3 cov24plot.py virtfuzz-ohci.csv virtfuzz-m-ohci.csv virtfuzz-f-ohci.csv vshuttle-ohci.csv qtest-ohci.csv
