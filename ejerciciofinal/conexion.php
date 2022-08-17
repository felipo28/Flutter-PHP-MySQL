<?php

$connect = new mysqli("localhost","root","","proyectoandroid");

if($connect){

}else{
	echo "Fallo, revise ip o firewall";
	exit();
}