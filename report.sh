set -e


PROJ_DIR=`pwd`

source ~/ttsetup/venv/bin/activate

rm -rf runs/wokwi || true

./tt/tt_tool.py --create-user-config --openlane2
./tt/tt_tool.py --harden --openlane2


mkdir -p tt_submission/stats || false

TOP_MODULE=$(./tt/tt_tool.py --print-top-module --openlane2)
cp runs/wokwi/final/{gds,lef,spef/*}/${TOP_MODULE}.* tt_submission/
cp runs/wokwi/final/pnl/${TOP_MODULE}.pnl.v tt_submission/${TOP_MODULE}.v
cp runs/wokwi/resolved.json tt_submission/
cp runs/wokwi/final/metrics.csv tt_submission/stats/metrics.csv
cp runs/wokwi/*-yosys-synthesis/reports/stat.log tt_submission/stats/synthesis-stats.txt

tt/tt_tool.py --create-png --openlane2