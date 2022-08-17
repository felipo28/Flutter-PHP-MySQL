<?php
	include 'conexion.php';
	$action = $_POST["action"];

	if ("Traer_Datos" == $action) {
		$idMateria = $_POST['idMateria'];
		$cedula = $_POST['cedula'];

		$queryResult=$connect->query("SELECT n.id_notas, n.id, n.primer_parcial FROM tblnotas n, materiaxestudiante me 
		WHERE me.cedulaEStu = '".$cedula."' AND n.id_notas = me.id AND me.idMateria = '".$idMateria."'");
	
		$result=array();
		while($fetchData=$queryResult->fetch_assoc()){
			$result[]=$fetchData;
		}
		echo json_encode($result);
	}

	if ("Elimiar_Datos" == $action) {
		$id = $_POST['id'];
		
		$connect->query("DELETE FROM tblnotas WHERE id ='".$id."'");
		return;
	}

	if ("Modificar_Datos" == $action) {
		$id = $_POST['id'];
		$primer_parcial = $_POST['primer_parcial'];

		$connect->query("UPDATE tblnotas SET primer_parcial = '".$primer_parcial."' WHERE id = '".$id."'");
		return;
	}

	if ("Guardar_Datos" == $action) {
		$id_notas = $_POST['id_notas'];
		$primer_parcial = $_POST['primer_parcial'];

		$connect->query("INSERT INTO tblnotas(id_notas, primer_parcial) VALUES ('".$id_notas."','".$primer_parcial."')");
		return;
	}
?>
