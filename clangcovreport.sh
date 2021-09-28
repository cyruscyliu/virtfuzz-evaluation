#/bin/bash -x
# Copyright (c) 2021 Qiang Liu <cyruscyliu@gmail.com>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Name convention of PROFILE: profile-tool-device-timestamp, e.g.,
# profile-virtfuzz-ehci-1632676609, profile-nyx-ehci-1632676609.

BINARY=$1
DIR=$2

rm /tmp/clangcovreport-*.sh
rm /tmp/*.profdata
profiles=$(find $2 -name profile* -type f)
for profraw in $profiles; do
    TOOL=$(basename $profraw | cut -d"-" -f2)
    DEVICE=$(basename $profraw | cut -d"-" -f3)
    TIMESTAMP=$(basename $profraw | cut -d"-" -f4)
    profdata=/tmp/$(basename $profraw).profdata
    echo "llvm-profdata merge -output=$profdata $profraw" >> /tmp/clangcovreport-merge.sh
    mkdir -p reports/
    output=reports/cov-$(basename $profraw)
    echo "llvm-cov report $BINARY -instr-profile=$profdata -format=text -summary-only > $output" >> /tmp/clangcovreport-report.sh
done

parallel -j$(nproc) --bar < /tmp/clangcovreport-merge.sh
parallel -j$(nproc) --bar < /tmp/clangcovreport-report.sh
