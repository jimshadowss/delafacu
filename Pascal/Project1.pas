
{Ejercicio 2. Una familia de 4 integrantes lleva registro de sus gastos (tipo de gasto y monto gastado).
Se pide:
a) Generar una estructura que almacene los gastos de los integrantes de la familia, agrupados seg�n
el integrante. Por cada integrante, se leen gastos hasta tipo de gasto 0. Los gastos de cada
integrante deben ordenarse por tipo de gasto.
b) Imprimir la estructura generada en a.
c) A partir de la estructura generada en a, realice un merge para obtener los montos totales gastados
por cada tipo de gasto. Genere un ABB con monto total y tipo de gasto, ordenado por monto total.
d) A partir del ABB, busque e imprima el tipo de gasto con mayor monto total.}

Program Project1;

Type 
    gasto =   Record
        tipo:   integer;
        monto:   real;
    End;
    lista =   ^nodo;
    nodo =   Record
        dato:   gasto;
        sig:   lista;
    End;
    vector =   array[1..4] Of lista;

    arbol =   ^anodo;
    anodo =   Record
        dato:   gasto;
        HI:   arbol;
        HD:   arbol;
    End;

Procedure leerGasto(Var g:gasto);
Begin
    writeln('Ingrese tipo de gasto:');
    readln(g.tipo);
    If g.tipo<> 0 Then
        Begin
            writeln('Ingrese monto:');
            readln(g.monto);
        End;
End;


Procedure insertarOrdenado (Var pri: lista; elem: gasto);

Var 
    ant, nue, act:   lista;
Begin
    new (nue);
    nue^.dato := elem;
    act := pri;
    While (act<>Nil) And (act^.dato.tipo < elem.tipo) Do
        Begin
            ant := act;
            act := act^.sig ;
        End;
    If (act = pri) Then
        pri := nue
    Else ant^.sig := nue;
    nue^.sig := act ;
End;

Procedure armarLista(Var l:lista);

Var 
    g:   gasto;
Begin
    leerGasto(g);
    While g.tipo<>0 Do
        Begin
            insertarOrdenado(l,g);
            leerGasto(g);
        End;
End;

Procedure armarVector(Var v:vector);
//

Var 
    i:   integer;
Begin
    For i:=1 To 4 Do
        Begin
            writeln('Integrante ',i,' de la familia');
            armarLista(v[i]);
        End;
End;

Procedure printGasto(g:gasto);
Begin
    writeln('Tipo: ',g.tipo);
    writeln('Monto: ',g.monto:2:2);
End;

Procedure printLista(l:lista);
Begin
    printGasto(l^.dato);
    If l^.sig<>Nil Then
        printLista(l^.sig);
End;

Procedure printV(v:vector);
//

Var 
    i:   integer;
Begin
    For i:=1 To 4 Do
        Begin
            writeln('Integrante ',i,': ');
            printLista(v[i]);
        End;
End;

Procedure armarABB(Var a:arbol;g:gasto);

Var 
    nu:   arbol;
Begin
    If a<>Nil Then
        Begin
            If a^.dato.tipo>g.tipo Then
                armarABB(a^.HI,g)
            Else
                If a^.dato.tipo<g.tipo Then
                    armarABB(a^.HD,g)
            Else
                a^.dato.monto := a^.dato.monto+g.monto;
        End
    Else
        Begin
            new(nu);
            nu^.dato := g;
            nu^.HI := Nil;
            nu^.HD := Nil;
            a := nu;
        End;
End;

Procedure buscarEnLista(Var a:arbol;l:lista);
Begin
    If l<>Nil Then
        Begin
            armarABB(a,l^.dato);
            buscarEnLista(a,l^.sig);
        End;

End;

Procedure buscarTipo(Var a:arbol;v:vector);
//

Var 
    i:   integer;
Begin
    For i:=1 To 4 Do
        Begin
            buscarEnLista(a,v[i]);
        End;
End;

Procedure buscarEnABB(a:arbol;Var g:gasto);
//
Begin
    If a<>Nil Then
        Begin
            buscarEnABB(a^.HI,g);
            If a^.dato.monto>g.monto Then
                g := a^.dato;
            buscarEnABB(a^.HD,g);
        End;
End;

Var 
    a:   arbol;
    v:   vector;
    gMax:   gasto;

Begin
    gMax.monto := -1;
    armarVector(v);
    printV(v);
    buscarTipo(a,v);
    buscarEnABB(a,gMax);
    writeln('Tipo de gasto mayor: ',gMax.tipo,' con un total de ',gMax.monto);
    readln;
End.
