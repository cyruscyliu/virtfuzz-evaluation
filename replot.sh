# evaluation 1
python3 cov24plot.py nyx-ac97.csv qtest-ac97.csv virtfuzz-ac97.csv
python3 cov24plot.py qtest-ac97.csv virtfuzz-ac97.csv
python3 cov24plot.py nyx-cs4231a.csv qtest-cs4231a.csv virtfuzz-cs4231a.csv
python3 cov24plot.py qtest-cs4231a.csv virtfuzz-cs4231a.csv
python3 cov24plot.py qtest-es1370.csv virtfuzz-es1370.csv
python3 cov24plot.py qtest-ahci.csv virtfuzz-ahci.csv
python3 cov24plot.py qtest-sdhci.csv virtfuzz-sdhci.csv
python3 cov24plot.py qtest-megasas.csv virtfuzz-megasas.csv
python3 cov24plot.py qtest-e1000.csv virtfuzz-e1000.csv
python3 cov24plot.py qtest-ne2000.csv virtfuzz-ne2000.csv
python3 cov24plot.py qtest-pcnet.csv virtfuzz-pcnet.csv
python3 cov24plot.py qtest-rtl8139.csv virtfuzz-rtl8139.csv
python3 cov24plot.py virtfuzz-ati.csv virtfuzz-ati2d.csv
python3 cov24plot.py virtfuzz-cirrus-vga.csv # miss qtest-cirrus-vga.csv
python3 cov24plot.py qtest-uhci.csv virtfuzz-uhci.csv
python3 cov24plot.py qtest-ohci.csv virtfuzz-ohci.csv
python3 cov24plot.py qtest-ehci.csv virtfuzz-ehci.csv

# evaluation 2
python3 cov24plot.py virtfuzz-uhci.csv virtfuzz-m-uhci.csv virtfuzz-f-uhci.csv qtest-uhci.csv
python3 cov24plot.py virtfuzz-ehci.csv virtfuzz-m-ehci.csv virtfuzz-f-ehci.csv qtest-ehci.csv
python3 cov24plot.py virtfuzz-ohci.csv virtfuzz-m-ohci.csv virtfuzz-f-ohci.csv qtest-ohci.csv
