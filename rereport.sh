bash -x covtablegen-new.sh e1000.c reports/cov-profile-qtest-e1000- > qtest-e1000.csv
bash -x covtablegen-new.sh e1000.c reports/cov-profile-virtfuzz-e1000- > virtfuzz-e1000.csv
bash -x covtablegen-new.sh cs4231a qtestcs4231areports/cov-profile-qtest-cs4231a- > qtest-cs4231a.csv
bash -x covtablegen-new.sh rtl8139.c reports/cov-profile-qtest-rtl8139- > qtest-rtl8139.csv
bash -x covtablegen-new.sh megasas.c reports/cov-profile-qtest-megaraid- > qtest-megasas.csv

bash -x covtablegen-new.sh ohci.c reports/cov-profile-qtest-ohci- > qtest-ohci.csv
bash -x covtablegen-new.sh uhci.c qtestuhcireports/cov-profile-qtest-uhci- > qtest-uhci.csv
bash -x covtablegen-new.sh ehci.c qtestehcireports/cov-profile-qtest-ehci- > qtest-ehci.csv

bash -x covtablegen-new.sh ohci.c reports/cov-profile-virtfuzz-ohci- > virtfuzz-ohci.csv
bash -x covtablegen-new.sh uhci.c reports/cov-profile-virtfuzz-uhci- > virtfuzz-uhci.csv
bash -x covtablegen-new.sh ehci.c virtfuzzehcireports/cov-profile-virtfuzz-ehci- > virtfuzz-ehci.csv

bash -x covtablegen-new.sh ohci.c reports/cov-profile-virtfuzz-f-ohci- 1 > virtfuzz-f-uhci.csv
bash -x covtablegen-new.sh uhci.c reports/cov-profile-virtfuzz-f-uhci- 1 > virtfuzz-f-uhci.csv
bash -x covtablegen-new.sh ehci.c reports/cov-profile-virtfuzz-f-ehci- 1 > virtfuzz-f-ehci.csv

bash -x covtablegen-new.sh ohci.c reports/cov-profile-virtfuzz-m-ohci- 1 > virtfuzz-m-uhci.csv
bash -x covtablegen-new.sh uhci.c reports/cov-profile-virtfuzz-m-uhci- 1 > virtfuzz-m-uhci.csv
bash -x covtablegen-new.sh ehci.c virtfuzzmehcireports/cov-profile-virtfuzz-m-ehci- 1 > virtfuzz-m-ehci.csv
