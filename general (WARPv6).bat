@echo off
chcp 65001 > nul
cd /d "%~dp0"
set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443 ^

--filter-tcp=80,443 ^
--hostlist="%LISTS%list-general.txt" ^
--hostlist="%LISTS%list-general-user.txt" ^
--hostlist-exclude="%LISTS%list-exclude.txt" ^
--hostlist-exclude="%LISTS%list-exclude-user.txt" ^
--ipset-exclude="%LISTS%ipset-exclude.txt" ^
--ipset-exclude="%LISTS%ipset-exclude-user.txt" ^
--dpi-desync=fake,multisplit ^
--dpi-desync-split-seqovl=480 ^
--dpi-desync-split-pos=1 ^
--dpi-desync-fooling=ts ^
--dpi-desync-repeats=4 ^
--dpi-desync-split-seqovl-pattern="%BIN%stun2.bin" ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" ^
--dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" --new ^

--filter-udp=1-65535 
--filter-l7=wireguard
--dpi-desync=fake ^
--dpi-desync-repeats=6 ^
--dpi-desync-any-protocol=1 ^
--dpi-desync-fake-unknown-udp="%BIN%quic_initial_4pda.to.bin" ^
--dpi-desync-fake-unknown-udp="%BIN%ACTIVE_GAME_UDP.bin" ^
--dpi-desync-cutoff=n4