<?php
	include 'conexion.php';
	$cedula = $_POST['cedula'];

	$queryResult=$connect->query("SELECT m.nombre, m.id_materia FROM tblmateria m WHERE m.cedula = '".$cedula."'");
	
	$result=array();

	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}

	echo json_encode($result);
?>