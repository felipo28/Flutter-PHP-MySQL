<?php
	include 'conexion.php';
	
	$nombre = $_POST['nombre'];
	$apellidos = $_POST['apellidos'];
	$usuario = $_POST['usuario'];
	$cedula = $_POST['cedula'];
	$correo = $_POST['correo'];
	$clave = $_POST['clave'];
	
	$connect->query("INSERT INTO tblprofesores(nombre, apellidos, usuario, clave, cedula, email) 
	VALUES ('".$nombre."','".$apellidos."','".$usuario."','".$clave."','".$cedula."','".$correo."')");
?>