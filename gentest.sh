#!/bin/bash
for f in tests/*.testfile; do
	base=${f%%.testfile}
	file -b -m rix.magic ${f} >${base}.result
done
