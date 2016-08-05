#!/bin/bash


#================
#tytuł		:skrypt-epity.sh
#opis		:Skrypt do instalacji programu e-pity dla systemu Linux - Ubuntu/Debian.
#autor		:Nolt
#data		:20150310
#aktualizacja	:20160520
#wersja		:0.4
#licencja:	:Eclipse Public License 1.0 (https://opensource.org/licenses/eclipse-1.0.txt)
#================



#tworzenie_folderu
echo "--- Do poprawnego uruchomienia aplikacji e-pity, muszę utworzyć folder Pity$data w katalogu domowym oraz pobrać brakujące paczki dla Twojej architektury systemu. ---"
sleep 5

data=$(date +%Y)

echo "--- Tworzę wymagany folder Pity$data! ---"
	if [ -d ~/Pity$data ] ; then
echo "--- Folder Pity$data jest już założony ---"
sleep 2
	else
echo "--- Tworzę folder Pity$data w katalogu domowym ---"
mkdir ~/Pity$data
	fi

sleep 2

#pobieranie adobeair
echo "Czy pobrać plik instalacyjny AdobreAIR 2.6? (t/n)"
read t
	if [ -e ~/Pity$data/AdobeAIRInstaller.bin ] ; then
echo "--- Nie pobieram pliku, jest już pobrany ---"
sleep 2
		elif [ "$t" = "t" ] ; then
echo "--- Pobieram plik AdobreAIR 2.6! ---"
sleep 3
cd ~/Pity$data/ && wget http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin
chmod +x AdobeAIRInstaller.bin
	else
echo "--- Nie pobieram pliku, jest już pobrany ---"
	fi

sleep 2

#pobieranie epity
echo "Czy pobrać plik instalacyjny porogramu e-pity? (t/n)"
read t
	if [ -e ~/Pity$data/setup_e-pity2015Linux.air ] ; then
echo "--- Nie pobieram gdyż plik jest już pobrany! ---"
sleep 2
		elif [ "$t" = "t" ] ; then
echo "--- Pobieram instalator aplikacji epity! ---"
sleep 3
cd ~/Pity$data/ && wget http://download.e-pity.pl/down/setup_e-pity2015Linux.air
chmod +x setup_e-pity2015Linux.air
	else
echo "--- Nie pobieram gdyż plik jest już pobrany! ---"
	fi

sleep 2

#sprawdzanie dystrybucji i architektury
echo "Sprawdzimy jaką dystrybucję oraz architekturę systemu Linux posiadasz(obsługiwane Debian i Ubuntu)"

distro=$(lsb_release -si)
bit=$(uname -m)

	if [ "$distro" = "Debian" ] ; then

		if [ "$bit" = "x86_64" ] ; then

echo "Debian x86_64"

sudo dpkg --add-architecture i386 && sudo apt-get update && sudo apt-get install -y libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 lib32nss-mdns libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libgnome-keyring0:i386 libxaw7
sudo ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0 && sudo ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

		else

echo "Debian i686"

sudo apt-get install -y libgtk2.0-0 libxslt1.1 libxml2 libnss3 libxaw7 libgnome-keyring0
sudo ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0 && sudo ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

		fi

	elif [ "$distro" = "Ubuntu" ] ; then 

		if [ "$bit" = "x86_64" ] ; then

echo "Ubuntu x86_64"

sudo apt-get install -y libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 lib32nss-mdns libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libgnome-keyring0:i386 libxaw7
sudo ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0 && sudo ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

		else

echo "Ubuntu i686"

sudo apt-get install -y libgtk2.0-0 libxslt1.1 libxml2 libnss3 libxaw7 libgnome-keyring0
sudo ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0 && sudo ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0
		fi
	fi

sleep 2

#instalacja
echo "Będę instalował pobrane aplikacje!"
cd ~/Pity$data/
sudo ./AdobeAIRInstaller.bin
sudo /usr/bin/Adobe\ AIR\ Application\ Installer ~/Pity$data/setup_e-pity2015Linux.air

echo "--- Gratulacje, wszystko poszło pięknie i gładko. Folder z plikami instalacyjnymi nie jest już potrzebny, mogę go usunąć za Ciebie :) (t/n)? ---"
read t
	if [ "$t" = "t" ] ; then
rm -fr ~/Pity$data
echo "--- Dzięki, spadam! ---"
	else
echo "--- Dzięki, spadam! ---"
	fi
exit
