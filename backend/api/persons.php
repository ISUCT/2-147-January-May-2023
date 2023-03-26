<?php
header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

include '../../database.php';

$q = $_GET['data']; 

$parametr = explode("/", $q);
$type = $parametr[0];
$name = $parametr[1];
$last_id = $parametr[2];

$mehtod = $_SERVER['REQUEST_METHOD'];

if($mehtod === 'GET'){
   
    if($type == null){
        
        if($name != null and !isset($last_id)){

            $query = $link->query("SELECT count(*) AS count FROM Persons where Name like \"$name%\"");
            $count = $query->fetch_assoc();

            $query = $link->query("SELECT id_Persons, Name, Level, Exp, Image FROM Persons where Name like \"$name%\"");
            $result = array();

            while($rowData = $query->fetch_assoc()){
                $result[] = $rowData;
            }

                if($result[0] == null){
                    http_response_code($response_code = 404);
                    echo json_encode ("Persons not found");
                    die();
                }

            $endResult = array('count'=>$count['count'], 'data'=>$result);
            echo json_encode($endResult);
        }
        else{
            http_response_code($response_code = 400);
            echo json_encode("Error, Bad Request");
        }
    }
    else {
        http_response_code($response_code = 400);
        echo json_encode("Error, Bad Request");
    }
}
else{
    http_response_code($response_code = 405);
    echo json_encode("Method not supported, use GET");
}