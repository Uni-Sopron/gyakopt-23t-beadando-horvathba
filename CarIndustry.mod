set Kocsik;
set Alkatreszek;

param Keszlet {a in Alkatreszek}, >=0, default 1e100;
param Ar {k in Kocsik}, >=0, default 0;
param AlkatreszAr {a in Alkatreszek}, >=0, default 0;
param Alkatreszigeny {a in Alkatreszek, k in Kocsik}, >=0, default 0;
param felhasznalas {a in Alkatreszek}, >=0, <=Keszlet[a], default 0;
param Rendelesek {k in Kocsik}, >=0, default 0;
param Tulgyartas {k in Kocsik}, >=Rendelesek[k], default 1e100;

var gyartas {k in Kocsik}, >=Rendelesek[k], <=Tulgyartas[k];

s.t. Keszlet_korl {a in Alkatreszek}:
	sum {k in Kocsik} Alkatreszigeny [a,k] * gyartas[k] <= Keszlet[a];

s.t. Felh_Minimumfelhasznalas {a in Alkatreszek}:
    sum {k in Kocsik} Alkatreszigeny[a,k] * gyartas[k] >= felhasznalas[a];

s.t. Rendelesek_ {k in Kocsik}:
    gyartas[k] >= Rendelesek[k];

s.t. Tultermeles_ {k in Kocsik}:
    gyartas[k] <= Tulgyartas[k];



maximize Teljes_Bevetel: sum {k in Kocsik} (Ar[k] - sum {a in Alkatreszek} felhasznalas[a] * AlkatreszAr[a])  * gyartas[k];

solve;
 param felhasznaltAlkatresz {a in Alkatreszek} :=
        sum {k in Kocsik} Alkatreszigeny[a,k] * gyartas[k];

printf "Bevétel: %g\n", sum {k in Kocsik} ceil((Ar[k] - sum {a in Alkatreszek} felhasznalas[a] * AlkatreszAr[a])  * gyartas[k]);

printf "\n";

for {k in Kocsik}
{
    printf "- %s: %g\n", k, ceil(gyartas[k]);
}

printf "\n";

for {a in Alkatreszek}

{
    printf "Felhasznált %s: %g\n", a, ceil(felhasznaltAlkatresz[a]);
}

data;

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

end;
