# gyakopt-23t-beadando-horvathba - Car Industry

A következő projekt egy autógyárról szól, amely 4 típust tud gyártani (Vw, Audi, Suzuki, Opel).

 Ezen autóknak van eladási áruk.
Minden autónak van egy bizonyos alkatrészigénye, amelyet bele kell szerelni ahhoz, hogy le tudjuk gyártani. Ám az alkatrészeknek is van áruk, amely az autók eladási árából a végén le kell vonni.

Az autógyár a meglévő készletükből dolgozik, tehát fontos, hogy csak annyi autót tudnak  gyártani, amennyit a készlet megenged.

A gyár a csavarokból és a kábelekből készletkisöprést tart a gyártási folyamat során, tehát úgy kalkulálják a folyamatot, hogy csavarból és kábelből is a megadott darabszám elfogyjon.

Alapjába véve a cél a profit maximalizálása úgy, hogy a vevői rendeléseket kiszolgáljuk készlet függvényében, valamint, hogy a nem annyira népszerű autókból ne gyártsunk túl sokat, maximum annyit amennyit definiált a termelésirányító munkatárs.

  ## Adatok

```
set Kocsik := Vw Audi Suzuki Opel;

set Alkatreszek := Turbo Klimakompresszor Kipufogodob Csavarok Kabelek;

param Keszlet :=
    Turbo 320
    Klimakompresszor 140
    Kipufogodob 360
    Csavarok 12000
    Kabelek 12700
    ;

param Alkatreszigeny:

             Vw    Audi   Suzuki Opel :=
    Turbo        2     1      0     1
    Klimakompresszor  4      6    3      2
    Kipufogodob    4    2    2    1
    Csavarok   230       190      210   160
    Kabelek    400      420    440     460
    ;

param Ar :=

    Vw 1000
    Audi 12000
    Suzuki 10020
    Opel   18800
    ;

param AlkatreszAr :=

    Turbo 8
    Klimakompresszor 6
    Kipufogodob 4
    Csavarok 1
    Kabelek 2
    ;

param felhasznalas :=

    
    Csavarok 4000
    Kabelek 3500
    ;

param Rendelesek :=

    Vw  3
    Audi 4
    ;

param Tulgyartas :=

    Opel 3
    Suzuki 1	
    ;
```

 ## Korlátozások

 ```
s.t. Keszlet_korl {a in Alkatreszek}:
	sum {k in Kocsik} Alkatreszigeny [a,k] * gyartas[k] <= Keszlet[a];

s.t. Felh_Minimumfelhasznalas {a in Alkatreszek}:
    sum {k in Kocsik} Alkatreszigeny[a,k] * gyartas[k] >= felhasznalas[a];

s.t. Rendelesek_ {k in Kocsik}:
    gyartas[k] >= Rendelesek[k];

s.t. Tultermeles_ {k in Kocsik}:
    gyartas[k] <= Tulgyartas[k];


```
## Kimenet

```
OPTIMAL LP SOLUTION FOUND
Time used:   0.0 secs
Memory used: 0.1 Mb (128901 bytes)
Bevétel: 13734

- Vw: 3
- Audi: 21
- Suzuki: 0
- Opel: 3

Felhasznált Turbo: 30
Felhasznált Klimakompresszor: 140
Felhasznált Kipufogodob: 56
Felhasznált Csavarok: 5034
Felhasznált Kabelek: 11121

```


