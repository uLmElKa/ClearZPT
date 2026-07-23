@echo off
chcp 65001 > nul
cd /d "%~dp0"
set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: %~n0" /min "%BIN%winws.exe" ^
--wf-tcp=80,443 ^
--filter-tcp=80,443 ^
--dpi-desync=fake ^
--dpi-desync-repeats=6 ^
--dpi-desync-fooling=ts ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" ^
--dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin"