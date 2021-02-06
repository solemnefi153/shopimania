<?php 
//This is the main controller 
    // Get the database connection file
    require_once $_SERVER['DOCUMENT_ROOT'] . '/library/connections.php';

    $action = filter_input(INPUT_POST, 'action');
    if ($action == NULL){
    $action = filter_input(INPUT_GET, 'action');
    }
    switch ($action){
        case 'test':
            echo 'This is the test page';
            break;
        default:
            echo 'This is the homepage';
    }
?> 