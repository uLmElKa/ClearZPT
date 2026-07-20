:: general (Dronatar)v4.7 (ALT)
:: Сделано Dronatar для «zapret-discord-youtube» версий 1.9.5 – 1.9.6 – ?
:: Ссылка на обсуждение: https://github.com/Flowseal/zapret-discord-youtube/discussions/3279

:: Метка [WIP] означает, что профиль недостаточно проверен или не завершён.

@echo off
title zapret: %~n0

cd /d "%~dp0"
chcp 65001 >nul
call service.bat status_zapret
net session >nul 2>&1
if %errorLevel% == 0 (echo Запуск...) else (echo Требуются права администратора...)
call service.bat load_game_filter

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443,853,2053,2083,2087,2096,8443,%GameFilter% --wf-udp=%GameFilter%,53-65535 ^

--comment Telegram (WebRTC) [WIP] --filter-udp=1400 --filter-l7=stun --dpi-desync=fake --dpi-desync-fake-stun=0x00 --new ^

--comment WhatsApp (WebRTC) [WIP] --filter-udp=3478-3482,3484,3488,3489,3491-3493,3495-3497 --filter-l7=stun --dpi-desync=fake --dpi-desync-fake-stun=0x00 --dpi-desync-repeats=6 --new ^

--comment Discord (WebRTC) --filter-udp=19294-19344,50000-50032 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-fake-discord="%BIN%quic_initial_www_google_com.bin" --dpi-desync-fake-stun="%BIN%quic_initial_www_google_com.bin" --dpi-desync-repeats=6 --new ^

--comment Discord --filter-tcp=443,2053,2083,2087,2096,8443 --hostlist-domains=dis.gd,discord-attachments-uploads-prd.storage.googleapis.com,discord.app,discord.co,discord.com,discord.design,discord.dev,discord.gift,discord.gifts,discord.gg,gateway.discord.gg,discord.media,discord.new,discord.store,discord.status,discord-activities.com,discordactivities.com,discordapp.com,cdn.discordapp.com,discordapp.net,media.discordapp.net,images-ext-1.discordapp.net,updates.discord.com,stable.dl2.discordapp.net,discordcdn.com,discordmerch.com,discordpartygames.com,discordsays.com,discordsez.com,discordstatus.com --dpi-desync=fake --dpi-desync-fake-tls-mod=sni=web.vk.me --dpi-desync-fooling=ts --dpi-desync-repeats=6 --new ^

--comment list-google(YouTube QUIC)/list-general(QUIC) --filter-udp=443 --hostlist="%LISTS%list-google.txt" --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --dpi-desync-repeats=11 --new ^

--comment list-google(YouTube Streaming)/list-general(HTTP) --filter-tcp=80 --hostlist="%LISTS%list-google.txt" --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-fooling=ts --new ^

--comment list-google(YouTube) --filter-tcp=443 --hostlist-exclude-domains=stable.dl2.discordapp.net --hostlist="%LISTS%list-google.txt" --dpi-desync=fake,multidisorder --dpi-desync-fake-tls-mod=sni=www.google.com --dpi-desync-split-pos=1,midsld,host --dpi-desync-split-seqovl=681 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-fooling=ts --dpi-desync-repeats=6 --new ^

--comment list-general+Extras --filter-tcp=443 --hostlist-exclude-domains=dis.gd,discord-attachments-uploads-prd.storage.googleapis.com,discord.app,discord.co,discord.com,updates.discord.com,discord.design,discord.dev,discord.gift,discord.gifts,discord.gg,gateway.discord.gg,discord.media,discord.new,discord.store,discord.status,discord-activities.com,discordactivities.com,discordapp.com,cdn.discordapp.com,discordapp.net,media.discordapp.net,images-ext-1.discordapp.net,discordcdn.com,discordmerch.com,discordpartygames.com,discordsays.com,discordsez.com,discordstatus.com --hostlist="%LISTS%list-general.txt" --hostlist-domains=adguard.com,amazon.com,amazonaws.com,anydesk.my.site.com,awsapps.com,awsstatic.com,cloudflare-gateway.com,cloudflare.com,cloudflare.dev,cloudfront.net,cobalt.tools,essential.gg,forgecdn.net,github-api.arkoselabs.com,githubstatus.com,imagedelivery.net,itch.io,itch.zone,klipy.com,malw.link,mega.co.nz,minecraftforge.net,modrinth.com,neoforged.net,nexus-cdn.com,nexusmods.com,ntc.party,githubusercontent.com,prostovpn.org,quora.com,roskomsvoboda.org,sndcdn.com,soundcloud.cloud,soundcloud.com,speedtest.net,tampermonkey.net,tesera.io,totalcommander.ch,totallyacdn.com,uploads.ungrounded.net,whatsapp.com,whatsapp.net,whiskergalaxy.com,windscribe.com,windscribe.net,wireguard.com --dpi-desync=fake,multisplit --dpi-desync-fake-tls-mod=rnd,dupsid,sni=web.vk.me --dpi-desync-split-pos=1,midsld,host --dpi-desync-fooling=ts --dpi-desync-repeats=6 --new ^

--comment Cloudflare WARP Gateway(1.1.1.1, 1.0.0.1) --filter-tcp=443,853 --ipset-ip=162.159.36.1,162.159.46.1,2606:4700:4700::1111,2606:4700:4700::1001 --dpi-desync=syndata --dpi-desync-fake-syndata=0x00 --dpi-desync-cutoff=n2 --new ^

--comment WireGuard handshake --filter-udp=53-65535 --filter-l7=wireguard --dpi-desync=fake --dpi-desync-fake-wireguard="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --dpi-desync-repeats=4 --new ^

--comment IP set(TCP 80,443) --filter-tcp=80,443 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake,multisplit --dpi-desync-fake-tls-mod=sni=web.vk.me --dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-fooling=ts --dpi-desync-split-pos=1,midsld,host --dpi-desync-repeats=6 --new ^

--comment IP set(UDP 443) --filter-udp=443 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-repeats=5 --new ^

--comment Games(TCP) --filter-tcp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync-any-protocol --dpi-desync=fakeknown,multisplit --dpi-desync-fake-tls-mod=sni=vk.me --dpi-desync-fooling=ts --dpi-desync-split-pos=1,midsld,host --dpi-desync-split-seqovl=681 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-cutoff=n4 --dpi-desync-repeats=6 --new ^

--comment Games(UDP) --filter-udp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync-any-protocol --dpi-desync=fake --dpi-desync-cutoff=n3 --dpi-desync-repeats=5