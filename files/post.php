<?php

$user_agent = $_POST['agent'];
$navigator = $_POST['navegador'];
$versionapp = $_POST['versionapp'];
$dystro = $_POST['dystro'];
$lenguaje = $_POST['idioma'];

$file = fopen('credentials2.txt', 'w+');
fwrite($file, "
user-agent: $user_agent
navegador: $navigator
versionApp: $versionapp
sistema opetativo: $dystro
lenguaje: $lenguaje
");
fclose($file);
?>
