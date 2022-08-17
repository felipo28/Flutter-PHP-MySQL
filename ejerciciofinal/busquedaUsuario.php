<?php
    include 'conexion.php';

    $usuario = $_POST['usuario'];

    $consultar=$connect->query("SELECT * FROM tblprofesores WHERE usuario='".$usuario."'");

    $resultado=array();

    while($extraerDatos=$consultar->fetch_assoc()){
        $resultado[]=$extraerDatos;
    }

    echo json_encode($resultado);
?>