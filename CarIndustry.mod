set Kocsik;
set Alkatreszek;
set Extrak;

param Keszlet {a in Alkatreszek}, >=0, default 1e100;
param Ar {k in Kocsik}, >=0, default 0;
param AlkatreszAr {a in Alkatreszek}, >=0, default 0;
param ExtrakAr  { e in Extrak}, >=0, default 0;
param Alkatreszigeny {a in Alkatreszek, k in Kocsik}, >=0, default 0 ;
param ExtraKompatibilitas { e in Extrak, k in Kocsik}, binary, default 0;
param ExtrakAlkatreszigeny { a in Alkatreszek, e in Extrak},>=0,default 0;  
param felhasznalas {a in Alkatreszek}, >=0, <=Keszlet[a], default 0;

param Tulgyartas {k in Kocsik}  default 1e100;

param Gyartjuke { k in Kocsik } binary, default 0;




var gyartas {k in Kocsik},integer;

var extrakBeepitve {Extrak,Kocsik} binary;# Bináris változó az extra alkatrészekhez

var gyartandoKocsi {Kocsik} binary; #Bináris változó ahhoz, hogy gyártjuk -e



s.t. Keszlet_korl {a in Alkatreszek: Keszlet[a] < 1e100}:
	sum {k in Kocsik} Alkatreszigeny [a,k] * gyartas[k] <= Keszlet[a];
        
s.t. Felh_Minimumfelhasznalas {a in Alkatreszek}:
    sum {k in Kocsik} Alkatreszigeny[a,k] * gyartas[k] * Gyartjuke[k] >= felhasznalas[a];
    
s.t. Extra_Kompatibilitas {e in Extrak, k in Kocsik : ExtraKompatibilitas[e,k] <> 1}:
   extrakBeepitve[e,k] = 0;
   
   s.t. Gyartjuk_e { k in Kocsik : Gyartjuke[k] <> 1}:
   gyartandoKocsi[k] = 0;
   
   
   
   
    


maximize Teljes_Bevetel:
    sum {k in Kocsik } (Ar[k] * gyartandoKocsi[k] - sum {a in Alkatreszek} felhasznalas[a] * AlkatreszAr[a])
    - sum {e in Extrak, k in Kocsik } extrakBeepitve[e,k] * ExtrakAr[e] ;





solve;
 param felhasznaltAlkatresz {a in Alkatreszek} :=
        sum {k in Kocsik} Alkatreszigeny[a,k] * gyartas[k] * gyartandoKocsi[k] ;
        
        
        param felhasznaltExtrak {e in Extrak} :=
        sum {k in Kocsik} ExtraKompatibilitas[e,k] * gyartas[k] ;

printf "Bevétel: %g\n",  sum {k in Kocsik} (Ar[k] * gyartandoKocsi[k] - sum {a in Alkatreszek} felhasznalas[a] * AlkatreszAr[a]) 
    - sum {e in Extrak, k in Kocsik} extrakBeepitve[e,k] * ExtrakAr[e] * gyartandoKocsi[k];

printf "\n";

for {k in Kocsik}
{
    printf "- %s: %g\n", k,  gyartandoKocsi[k] * ceil(gyartas[k]);
}

printf "\n";

for {a in Alkatreszek}

{
    printf "Felhasznált %s: %g\n", a, ceil(felhasznaltAlkatresz[a]);
   
}

for { e in Extrak }

{
 printf "Felhasznált Extrák: %s: %g\n", e, ceil(felhasznaltExtrak[e]);
}


end;
