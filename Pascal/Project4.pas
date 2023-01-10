{Ejercicio 1. Un teatro tiene funciones los 7 días de la semana. Para cada día se tiene una lista con
las entradas vendidas. Se desea procesar la información de una semana. Se pide:
a) Generar 7 listas con las entradas vendidas para cada día. De cada entrada se lee día (de 1 a 7),
código de la obra, asiento, monto. La lectura finaliza con el código de obra igual a 0. Las listas deben
estar ordenadas por código de obra de forma ascendente.
b) Generar una nueva lista que totalice la cantidad de entradas vendidas por obra. Esta lista debe
estar ordenada por código de obra de forma ascendente.
c) Realice un módulo recursivo que informe el contenido de la lista generada en b)}
program Project4;
type
    entrada=record
        dia:1..7;
        cod:integer;
        asiento:integer;
        monto:real;
    end;
    lista=^nodo;
    nodo=record
        dato:entrada;
        sig:lista;
    end;
    vLista=array[1..7] of lista;
procedure leerEntrada(var e:entrada);
    begin
        writeln('Ingrese codigo:');
        readln(e.cod);
        if e.cod<>0 then begin
            writeln('Ingrese dia:');
            readln(e.dia);
            writeln('Ingrese asiento:');
            readln(e.asiento);
            writeln('Ingrese monto:');
            readln(e.monto);
        end;
    end;


procedure insertarOrdenado (var pri: lista; e: entrada);
  var
    ant, nue, act: lista;
  begin
    new (nue);
    nue^.dato := e;
    act := pri;
    while (act<>nil) and (act^.dato.cod < e.cod) do begin
      ant := act;
      act := act^.sig ;
    end;
    if (act = pri) then
      pri := nue
    else ant^.sig := nue;
      nue^.sig := act ;
  end;

procedure armarLista(var l:lista);
    var
        e:entrada;
    begin
        leerEntrada(e);
        while e.cod<>0 do begin
            insertarOrdenado(l,e);
            leerEntrada(e);
        end;
    end;

procedure armarVector(var v:vLista);
    var
        i:integer;
        e:entrada;
    begin
        for i:=1 to 7 do begin
            armarLista(v[i]);
        end;
    end;

procedure buscarMinimo(var v:vLista;var datoMinimo:entrada);
  var
    indiceMinimo:1..7;
    i:integer;
  begin
    datoMinimo.cod:=9999;
    for i:=1 to 7 do begin
      if v[i]<>nil then
        if (v[i]^.dato.cod<datoMinimo.cod) then begin
          datoMinimo:=v[i]^.dato;
          indiceMinimo:=i;
        end;
    end;
      if (datoMinimo.cod<>9999) then
        v[indiceMinimo]:=v[indiceMinimo]^.sig;
  end;
procedure agregarAtras(var l:lista;dato:entrada;var ult:lista);
  var
    nu:lista;
  begin
    new(nu);
    nu^.dato:=dato;
    nu^.sig:=nil;
    if l=nil then
      l:=nu
    else
      ult^.sig:=nu;
    ult:=nu;
  end;
procedure armarLN(v:vLista; var l:lista);
  var
    dato:entrada;
    ult:lista;
  begin
    buscarMinimo(v,dato);
    while dato.cod<>9999 do begin
      agregarAtras(l,dato,ult);
      buscarMinimo(v,dato);
    end;
  end;

procedure informar(l:lista);
    begin
        writeln('Codigo de obra: ',l^.dato.cod);
        writeln('Dia de la obra: ',l^.dato.dia);
        writeln('Asiento: ',l^.dato.asiento);
        writeln('Monto: ',l^.dato.monto);
        if l^.sig<>nil then
            informar(l^.sig);
    end;

var
    v:vLista;
    LN:lista;

begin
    armarVector(v);
    armarLN(v,LN);
    informar(LN);
    readln;
end.
