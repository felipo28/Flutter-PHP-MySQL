<?php
	include 'conexion.php';

	$idMateria = $_POST['idMateria'];

	$queryResult=$connect->query("SELECT me.id, me.idMateria, e.cedula, e.nombres, e.apellidos FROM materiaxestudiante me, tblestudiante e 
	WHERE me.idMateria = '".$idMateria."' AND me.cedulaEStu = e.cedula");
	
	
	$result=array();

	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}

	echo json_encode($result);
?>