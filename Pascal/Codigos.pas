
Program Codigos;

Type 
    lista =   ^nodo;
    nodo =   Record
        dato:   integer;
        sig:   lista;
    End;
    vector =   array [1..15] Of integer;
    arbol =   ^anodo;
    anodo =   Record
        dato:   integer;
        HI:   arbol;
        HD:   arbol;
    End;

    //------------------PROCESOS DE LISTAS------------------

Procedure AgregarAdelante(Var l:lista; elem: integer);

Var 
    nue:   Lista;
Begin
    New(nue);
    nue^.dato := elem;
    nue^.sig := l;
    l := nue;
End;

Procedure agregarAtras (Var pri, ult: lista; elem: integer);

Var 
    nue :   lista;
Begin
    new (nue);
    nue^.dato := elem;
    nue^.sig := Nil;
    If pri <> Nil Then
        ult^.sig := nue
    Else
        pri := nue;
    ult := nue;
End;

Procedure insertarOrdenado (Var pri: lista; elem: integer);

Var 
    ant, nue, act:   lista;
Begin
    new (nue);
    nue^.dato := elem;
    act := pri;
    While (act<>Nil) And (act^.dato < elem) Do
        Begin
            ant := act;
            act := act^.sig ;
        End;
    If (act = pri) Then
        pri := nue
    Else ant^.sig := nue;
    nue^.sig := act ;
End;

//------------------PROCESOS DE VECTORES------------------

Procedure ordenarVector(Var v:vector;dimL:integer);

Var 
    i,j:   integer;
    act:   integer;
Begin
    For i:=2 To dimL Do
        Begin
            act := v[i];
            j := i-1;
            While (j>0) And (v[j]>act) Do
                Begin
                    v[j+1] := v[j];
                    j := j-1;
                End;
            v[j+1] := act;
        End;
End;

Function busquedaV(v:vector;dimL:integer;x:integer):   real;

Var 
    med,ult,pri:   integer;
Begin
    pri := 1;
    ult := dimL;
    med := ult Div 2;
    While (pri<ult) And (v[med]<>x) Do
        Begin
            If x<v[med] Then
                ult := med
            Else
                If x>v[med] Then
                    pri := med+1;
            med := (pri+ult) Div 2;
        End;
    If pri<ult Then
        busquedaV := v[med]
    Else
        busquedaV := -1;
End;

Procedure busquedaDicotomica(v:vector;ini,fin,dato:integer;Var pos:integer);

Var 
    med:   integer;
Begin
    If ini<=fin Then
        Begin
            med := (ini+fin) Div 2;
            If v[med]=dato Then
                pos := med
            Else
                If v[med]>dato Then
                    busquedaDicotomica(v,ini,med-1,dato,pos)
            Else
                If v[med]<dato Then
                    busquedaDicotomica(v,med+1,fin,dato,pos);
        End
    Else
        pos := -1;
End;

//-------------------------------MERGE-----------------------------------

Procedure buscarMinimo(Var v:vector;Var datoMinimo:integer);

Var 
    indiceMinimo:   1..4;
    i:   integer;
Begin
    datoMinimo := 9999;
    For i:=1 To 4 Do
        Begin
            If v[i]<>Nil Then
                If (v[i]^.dato<datoMinimo) Then
                    Begin
                        datoMinimo := v[i]^.dato;
                        indiceMinimo := i;
                    End;
        End;
    If (datoMinimo<>max) Then
        v[indiceMinimo] := v[indiceMinimo]^.sig;
End;
Procedure agregarAtras(Var l:lista;dato:integer;Var ult:lista);

Var 
    nu:   lista;
Begin
    new(nu);
    nu^.dato := dato;
    nu^.sig := Nil;
    If l=Nil Then
        l := nu
    Else
        ult^.sig := nu;
    ult := nu;
End;
Procedure armarLN(v:vector; Var l:lista);

Var 
    dato:   integer;
    ult:   lista;
Begin
    buscarMinimo(v,dato);
    While dato<>max Do
        Begin
            agregarAtras(l,dato,ult);
            buscarMinimo(v,dato);
        End;
End;


Var 
    i,num:   integer;
Begin
    Randomize;
    num := random (100); {valores en el intervalo 0 a 99}
End.
