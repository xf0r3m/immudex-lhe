#!/bin/bash

source ~/.sync.d/sync.conf;

if [ ! -d "${HOME}/${ldirectory}" ]; then mkdir "${HOME}/${ldirectory}"; fi

function printhelp {

	echo "Skrypt szybkiej synchronizacji katalogu zdalnego";
	echo "morketsmerke.org";
	echo "2023; COPYLEFT; ALL RIGHTS REVERSED";
	echo "";
	echo "push - Przesłanie danych z katalogu lokalnego na katalog zdalny";
	echo "pull - Pobranie zawartości katalogu zdalnego do katalogu lokalnego";
  echo "Plik konfiguracyjny musi znajdować się na ścieżce: ~/.sync.d/sync.conf";
  echo "Przykładowy plik konfiguracyjny znajduje się na ścieżce: /usr/share/sync.sh/sync.conf";
}
if [ ! "$1" ]; then 

	printhelp;
	exit 1;

else
	if [ "$1" = "push" ]; then 
	
		echo "[*] Synchronizacja: local -> remote";
		rsync -avu ${HOME}/${ldirectory}/* ${ruser}@${server}:${rdirectory};

	elif [ "$1" = "pull" ]; then 

		echo "[*] Synchronizacja remote -> local";
		rsync -avu ${ruser}@${server}:${rdirectory}/* ${HOME}/${ldirectory};

	else 
		printhelp;
		exit 1;
	fi

fi
