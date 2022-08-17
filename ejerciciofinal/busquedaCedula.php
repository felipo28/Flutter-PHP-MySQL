<?php
    include 'conexion.php';

    $cedula = $_POST['cedula'];

    $consultar=$connect->query("SELECT * FROM tblprofesores WHERE cedula='".$cedula."'");

    $resultado=array();

    while($extraerDatos=$consultar->fetch_assoc()){
        $resultado[]=$extraerDatos;
    }

    echo json_encode($resultado);
?>