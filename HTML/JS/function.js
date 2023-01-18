
alert(10
    *
    5);
document.getElementById('boton').onclick = function () {
    console.log("Usamos el boton");
    document.getElementById('email').innerHTML = "Recibido";
    document.getElementById('form').style.display = "none";
    alert("Recibido");
}
