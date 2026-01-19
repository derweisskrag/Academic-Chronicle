## Tabel

\begin{center}
Tabel 1: Rakenduse Aritmeetiliste Operatsioonide Jõudlus (Lühike Katseandmestik)
\end{center}

| Parameeter | WebAssembly (ms) | Cython (ms) | Erinevus (%) | 
|------------|------------------|-------------|--------------|
| Maatriksi Inversioon (50x50) | 124.5 | 188.9 | 51.7 | 
| Andmete Filtreerimine (10^6 rida) | 85.2 | 84.1 | -1.3 | 
| Jada Liitmine (10^8 iteratsiooni) | 55.7 | 92.5 | 66.1 | 


## Joonis


![Kolme Platvormi (WebAssembly, Cython, ja Native C) Jõudlusnäitajate Võrdlus Lokaalsetel Andmestruktuuridel. 
Allikas: Autori koostatud 2025. a. (põhineb Tabel 1 andmetel)](image.png)

## Skeem

![Repository Patterni arhitektuuri põhimõte andmetele juurdepääsul. 
Allikas: (Fowler 2003, lk 322)](image-1.png)

## Allikad

- Fowler, M. (2003). Patterns of Enterprise Application Architecture. Addison-Wesley.