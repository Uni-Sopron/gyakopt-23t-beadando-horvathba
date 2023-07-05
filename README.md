# gyakopt-23t-beadando-horvathba - Car Industry

A következő projekt egy autógyárról szól, amely 4 típust tud gyártani (Vw, Audi, Suzuki, Opel).

 Ezen autóknak van eladási áruk.
Minden autónak van egy bizonyos alkatrészigénye, amelyet bele kell szerelni ahhoz, hogy le tudjuk gyártani. Ám az alkatrészeknek is van áruk, amely az autók eladási árából a végén le kell vonni.

Az autógyár a meglévő készletükből dolgozik, tehát fontos, hogy csak annyi autót tudnak  gyártani, amennyit a készlet megenged.

A gyár a csavarokból és a kábelekből készletkisöprést tart a gyártási folyamat során, tehát úgy kalkulálják a folyamatot, hogy csavarból és kábelből is a megadott darabszám elfogyjon.

Alapjába véve a cél a profit maximalizálása úgy, hogy a vevői rendeléseket kiszolgáljuk készlet függvényében, valamint, hogy a nem annyira népszerű autókból ne gyártsunk túl sokat, maximum annyit amennyit definiált a termelésirányító munkatárs.

  ## Adatok

```
data;

set Kocsik := Vw Audi Suzuki Opel;

set Alkatreszek := Turbo Klimakompresszor Kipufogodob Csavarok Kabelek;

set Extrak := GPS Ulesfutes Chip;

param Keszlet :=
    Turbo 3200
    Klimakompresszor 1400
    Kipufogodob 360
    Csavarok 12000
    Kabelek 12700
    ;

param Alkatreszigeny:

             Vw    Audi   Suzuki Opel :=
    Turbo        10     10       10    10
    Klimakompresszor  5      6   7     8
    Kipufogodob    1    1    10    10
    Csavarok   21       21      21  20
    Kabelek    21      21    21     21;
    
    
    
    
    param ExtraAlkatreszigeny:
              Vw    Audi   Suzuki Opel :=
    GPS        0     1      0     1
    Ulesfutes  0      0    1      1
    Chip        1     1     0      1;
    
    
    
    

param Ar :=

    Vw 1400
    Audi 99000
    Suzuki 3000
    Opel   1000
    ;

param AlkatreszAr :=

    Turbo 8
    Klimakompresszor 6
    Kipufogodob 4
    Csavarok 1
    Kabelek 2
    ;
    
    param ExtrakAr :=
    GPS 50
    Ulesfutes 10
    Chip 20
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

s.t. Keszlet_korl {a in Alkatreszek: Keszlet[a] < 1e100}:
	sum {k in Kocsik} Alkatreszigeny [a,k] * gyartas[k] <= Keszlet[a];
    
s.t. Felh_Minimumfelhasznalas {a in Alkatreszek}:
    sum {k in Kocsik} Alkatreszigeny[a,k] * gyartas[k] >= felhasznalas[a];
    
    
s.t. Extra_beszereles {e in Extrak, k in Kocsik : ExtraAlkatreszigeny[e,k] <> 1}:
    extrakBeepitve[e,k] = 0;
    


```
## Kimenet

```
Bevétel: 60400

- Vw: 187
- Audi: 4
- Suzuki: 0
- Opel: 0

Felhasznált Turbo: 1910
Felhasznált Klimakompresszor: 959
Felhasznált Kipufogodob: 191
Felhasznált Csavarok: 4011
Felhasznált Kabelek: 4011
Felhasznált Extrák: GPS: 4
Felhasznált Extrák: Ulesfutes: 0
Felhasznált Extrák: Chip: 191

```


