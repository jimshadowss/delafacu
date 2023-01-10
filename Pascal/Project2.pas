{Ejercicio 3. Una perfumería dispone en papel de la información de las ventas de sus productos. De
cada venta conoce: código de producto, tipo de producto, fecha, cantidad de unidades vendida y
monto.
Se pide realizar un programa que:
a) A partir de la información de ventas ingresadas por teclado, genere un ABB que almacene para
cada código de producto: su tipo, la cantidad total de unidades vendidas y el monto total vendido
(entre todas las ventas realizadas). El ABB debe ordenarse por código de producto. El ingreso de
información finaliza cuando se lee cantidad vendida 0.
b) Luego de generado el ABB, informar (implementar un módulo para cada inciso):
 i - El tipo de los productos cuyo código está comprendido entre los valores 1500 y 2200.
 ii – La cantidad de productos con monto total vendido comprendido entre 10000 y 50000.}
program Project2;
type
    venta=record
        cod:integer;
        tipo:integer;
        fecha:string;
        cant:integer;
        monto:real;
    end;
    lista=^nodo;
    nodo=record
        dato:venta;
        sig:lista;
    end;
    ventaT=record
        tipo:integer;
        cantidad:integer;
        monto:real;
        cod:integer;
    end;
    arbol=^anodo;
    anodo=record
        dato:ventaT;
        HD:arbol;
        HI:arbol;
    end;
    listaT=^Tnodo;
    Tnodo=record
        dato:integer;
        sig:listaT;
    end;

procedure leerVenta(var v:venta);
    begin
        writeln('Ingrese cantidad');
        readln(v.cant);
        if v.cant<>0 then begin
            writeln('Ingrese codigo');
            readln(v.cod);
            writeln('Ingrese tipo');
            readln(v.tipo);
            writeln('Ingrese fecha');
            readln(v.fecha);
            writeln('Ingrese monto');
            readln(v.monto);
        end;
    end;

procedure agregarAtras(var l:lista;dato:venta;var ult:lista);
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

procedure armarLista(var l:lista);    //
    var
        ult:lista;
        dato:venta;
    begin
        leerVenta(dato);
        while dato.cant<>0 do begin
            agregarAtras(l,dato,ult);
            leerVenta(dato);
        end;
    end;

procedure pasarDatos(var v:ventaT;dato:venta);
    begin
        v.tipo:=dato.tipo;
        v.cantidad:=v.cantidad+dato.cant;
        v.monto:=v.monto+dato.monto;
    end;

procedure armarABB(var a:arbol;v:venta);
    var
        nu:arbol;
    begin
        if a<>nil then begin
            if v.cod<a^.dato.cod then
                armarABB(a^.HI,v)
            else
            if v.cod>a^.dato.cod then
                armarABB(a^.HD,v)
            else
                pasarDatos(a^.dato,v);
        end
        else begin
            new(nu);
            nu^.dato.cantidad:=v.cant;
            nu^.dato.monto:=v.monto;
            nu^.dato.tipo:=v.tipo;
            nu^.dato.cod:=v.cod;
            nu^.HI:=nil;
            nu^.HD:=nil;
            a:=nu;
        end;
    end;

procedure procesarLista(l:lista;var a:arbol); //
    begin
        if l<>nil then begin
            armarABB(a,l^.dato);
            procesarLista(l^.sig,a);
        end;
    end;

procedure agregarSiNo(var l:listaT;dato:integer);
    var
        nu:listaT;
    begin
        writeln('.');
        if l=nil then begin
            new(nu);
            nu^.sig:=nil;
            nu^.dato:=dato;
            l:=nu;
        end;
        if l^.dato<>dato then
            agregarSiNo(l^.sig,dato);
    end;

procedure buscarTipoEnA(a:arbol;var dato:listaT);     //
    begin
        if a<>nil then begin
            buscarTipoEnA(a^.HI,dato);
            if (a^.dato.cod>1500) and (a^.dato.cod<2200) then
                agregarSiNo(dato,a^.dato.tipo);
            buscarTipoEnA(a^.HD,dato);
        end;
    end;

procedure buscarCantEnA(a:arbol;var cant:integer);      //
    begin
        if a<>nil then begin
            buscarCantEnA(a^.HI,cant);
            if (a^.dato.monto>10000) and (a^.dato.monto<50000) then
                cant:=cant+1;
            buscarCantEnA(a^.HD,cant);
        end;
    end;

procedure printListaT(lT:listaT);         //
    begin
        if lT<>nil then begin
            writeln(lT^.dato,' ');
            printListaT(lT^.sig);
        end;
    end;

procedure llamado(var a:arbol;var l:lista;var lT:listaT);
    var
        cant:integer;
    begin
        cant:=0;
        armarLista(l);
        procesarLista(l,a);
        buscarTipoEnA(a,lT);
        buscarCantEnA(a,cant);
        writeln('Tipo de los productos de codigo entre 1500 y 2200:');
        printListaT(lT);
        writeln('Cantidad de ventas con total entre 10000 y 50000: ',cant)
    end;

var
    a:arbol;
    l:lista;
    lT:listaT;
begin
    llamado(a,l,lT);
    readln;
end.
