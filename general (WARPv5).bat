@echo off
chcp 65001 > nul
cd /d "%~dp0"
set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443 ^

--filter-tcp=80,443 ^
--dpi-desync=fake,multisplit ^
--dpi-desync-split-seqovl=664 ^
--dpi-desync-split-pos=1 ^
--dpi-desync-fooling=ts ^
--dpi-desync-repeats=11 ^
--dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_max_ru.bin" ^
--dpi-desync-fake-tls="%BIN%stun.bin" ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" ^
--dpi-desync-fake-http="%BIN%quic_initial_www_google_com.bin" --new ^

--filter-udp=1-65535 
--filter-l7=wireguard
--dpi-desync=fake
--dpi-desync-repeats=6
--dpi-desync-any-protocol=1
--dpi-desync-fake-wireguard="%BIN%quic_initial_www_google_com.bin" ^
--dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" ^
--dpi-desync-cutoff=n4