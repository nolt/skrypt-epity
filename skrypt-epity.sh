#!/bin/bash

#================
#tytuł		:skrypt-epity.sh
#opis		:Skrypt do instalacji programu e-pity dla systemu Linux - Ubuntu/Debian.
#autor		:Nolt
#data		:20150310
#aktualizacja	:20171221
#wersja		:1.3
#licencja:	:Eclipse Public License 1.0 (https://opensource.org/licenses/EPL-1.0)
#================

data=$(date +%Y)

#tworzenie_folderu
echo "--- Do poprawnego uruchomienia aplikacji e-pity, muszę utworzyć folder Pity$data w katalogu domowym oraz pobrać potrzebne pliki. ---"
sleep 5

echo "--- Tworzę wymagany folder Pity$data! ---"
mkdir ~/Pity$data

#pobieranie epity
echo "Pobieram paczkę z programem e-pity$date."
cd ~/Pity$data/ && wget https://dl.dropboxusercontent.com/s/yzzuhuawe7fp1ev/e-pity2017.tar.xz

sleep 1

#sprawdzanie dystrybucji i architektury
echo "Sprawdzę jaką dystrybucję oraz architekturę systemu Linux posiadasz (obsługiwane Debian i Ubuntu). Paczka .deb AdobeAIR zostanie pobrana i zainstalowana automatycznie."

distro=$(lsb_release -si)
bit=$(uname -m)

	if [ "$distro" = "Debian" ] ; then

		if [ "$bit" = "x86_64" ] ; then

echo "Debian x86_64"

cd ~/Pity$data/
wget https://dl.dropboxusercontent.com/s/z67403tfng6s01b/adobeair_2.6.0.2_amd64.deb
sudo dpkg -i adobeair_2.6.0.2_amd64.deb ; sudo apt-get install -f

		else

echo "Debian i686"

cd ~/Pity$data/
wget https://dl.dropboxusercontent.com/s/8paimajkk4bs57p/adobeair_2.6.0.2_i386.deb
sudo dpkg -i adobeair_2.6.0.2_i386.deb ; sudo apt-get install -f

		fi

	elif [ "$distro" = "Ubuntu" ] ; then 

		if [ "$bit" = "x86_64" ] ; then

echo "Ubuntu x86_64"

cd ~/Pity$data/
wget https://dl.dropboxusercontent.com/s/z67403tfng6s01b/adobeair_2.6.0.2_amd64.deb
sudo dpkg -i adobeair_2.6.0.2_amd64.deb ; sudo apt-get install -f

		else

echo "Ubuntu i686"

cd ~/Pity$data/
wget https://dl.dropboxusercontent.com/s/8paimajkk4bs57p/adobeair_2.6.0.2_i386.deb
sudo dpkg -i adobeair_2.6.0.2_i386.deb ; sudo apt-get install -f
		fi
	fi

sleep 1

#instalacja epity
echo "Będę instalował i konfigurował pobraną aplikację e-pity!"
cd /opt/
sudo tar xvf ~/Pity$data/e-pity2017.tar.xz

#tworzenie skrótu
echo "Tworzę skrót na pulpicie do programu e-pity"

cat > ~/Pulpit/e-pity.desktop <<EOF
[Desktop Entry]
Type=Application
Terminal=false
Icon=/opt/e-pity/share/Assets/icons/epity.ico
Name=e-pity
Exec=/opt/e-pity/bin/e-pity
Categories=Utility;
EOF

user=$(id -un)
grupa=$(id -gn)

chown $user:$grupa ~/Pulpit/e-pity.desktop
chmod +x ~/Pulpit/e-pity.desktop


echo "--- Gratulacje, wszystko poszło pięknie i gładko. Folder z plikami instalacyjnymi nie jest już potrzebny więc go usuwam. ---"
rm -fr ~/Pity$data

sleep 1
echo "--- Dzięki, spadam! ---"

exit
