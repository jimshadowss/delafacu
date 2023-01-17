document.getElementById('boton').onclick = function () {
    console.log("Usamos el boton");
    document.getElementById('email').innerHTML = "Recibido";
    document.getElementById('boton').innerText = "Recibido";
}
