<?php 
//This is the Producs  controller 
    // Get the database connection file
    require_once $_SERVER['DOCUMENT_ROOT'] . '/library/connections.php';
    // Function to sanitize imput
    require_once $_SERVER['DOCUMENT_ROOT'] . '/library/sanitizeInput.php';
    //Catch all errors
    require_once $_SERVER['DOCUMENT_ROOT'] . '/library/catchErrors.php';
    // Get the Products controller
    require_once $_SERVER['DOCUMENT_ROOT'] . '/models/products/index.php';
    //Grab the action from the request 
    $action = filter_input(INPUT_POST, 'action');
    if ($action == NULL){
    $action = filter_input(INPUT_GET, 'action');
    }
    switch ($action){
        //Endpoint that creates a new product
        case 'create_new_product':
            //Verify required fields
            if(!(isset($_POST['category_id']) and test_input($_POST['product_name']) and test_input($_POST['price'])))
            {
                //Echo the restul to the client
                $response = (object) array('status' => 400);
                $response->Error = 'Unabble to create product: Some required parameters where missing';
                http_response_code(400);
                header('Content-type:application/json;charset=utf-8');
                echo json_encode($response);
                //Quit this call if the required fields are not present
                die();
            }
            //Sanatize input
            $category_id = intval(test_input($_POST['category_id']));
            $product_name = test_input($_POST['product_name']);
            $price = floatval(test_input($_POST['price']));
            $product_description = isset($_POST['product_description']) ? test_input($_POST['product_description']) : NULL;
            $weight = isset($_POST['weight']) ? floatval(test_input($_POST['weight'])) : NULL;
            $measure = isset($_POST['measure']) ? test_input($_POST['measure']) : NULL;
            $height = isset($_POST['height']) ? floatval(test_input($_POST['height'])) : NULL;
            $length = isset($_POST['length']) ? floatval(test_input($_POST['length'])) : NULL;
            $image = isset($_POST['image']) ? test_input($_POST['image']) : NULL;
            $href = isset($_POST['href']) ? test_input($_POST['href']) : NULL;
            //Save sanitized input in an object
            $newProduct = (object) array(
                "category_id" => $category_id,
                "product_name" => $product_name,
                "price" => $price, 
                "product_description" => $product_description,
                "weight" => $weight,
                "measure" => $measure,
                "height" => $height,
                "length"=> $length,
                "image" => $image,
                "href" => $href,
            );
            //Call the function from the model to create a new product in the database 
            $result = createProduct($newProduct);
            //check that the operation was successful 
            if($result->success){
                //return the result to the client 
                echo json_encode($newProduct);
                die();
            }
            else{
                //Echo the restul to the client
                http_response_code(500);
                $response->status = 500;
                $response->Error = "Internal server error. $result->error";
                echo json_encode($response);
                //Quit this call if the required fields are not present
                die();
            }
            die();
            break;
        //Endpoint that gets all the products
        case 'get_products':
            //Check if there are any filters for the search
            $category_id = $_POST['category_id'] ? intval(test_input($_POST['category_id'])) : NULL;
            $results = getProducts($category_id);
            $products = (object) array(
                'products' => $results
            );
            header('Content-type:application/json;charset=utf-8');
            echo json_encode($products);
            die();
            break;
        //Endpoint that gets the  product details of a product 
        case 'get_product':
            //Verify required fields
            if(!(isset($_POST['product_id'])) or $_POST['product_id'] == "")
            {
                echo 'this is happening 1';
                //Echo the restul to the client
                $response = (object) array('status' => 400);
                $response->Error = 'Unable to find product: Missing product id';
                http_response_code(400);
                header('Content-type:application/json;charset=utf-8');
                echo json_encode($response);
                //Quit this call if the required fields are not present
                die();
            }
            //grab the product id
            $product_id = intval(test_input($_POST['product_id']));
            $product = getProduct($product_id);
            header('Content-type:application/json;charset=utf-8');
            echo json_encode($product);
            die();
            break;
        default:
            echo "Defoult is happening";
            die();
    }
?> 