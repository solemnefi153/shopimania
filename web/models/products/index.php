<?php 
//Products Model 
//Create new product
function createProduct($newProduct){
    try
    {
        //Set up a connection to the database 
        $db = databaseConnect(); 
        #Create the statemment to insert  the new product in the products table 
        $stmt = "INSERT INTO products (product_id, category_id, product_name, price";
        $stmt .= $newProduct->product_description ? ", product_description" : "";
        $stmt .= $newProduct->weight ? ", weight" : "";
        $stmt .= $newProduct->measure ? ", measure" : "";
        $stmt .= $newProduct->height ? ", height" : "";
        $stmt .= $newProduct->length ? ", length" : "";
        $stmt .= $newProduct->image ? ", image" : "";
        $stmt .= $newProduct->href ? ", href" : "";
        $stmt.= ") VALUES (( nextval('prosucts_sequence'), :category_id, :product_name, :price";
        $stmt .= $newProduct->product_description ? ", :product_description" : "";
        $stmt .= $newProduct->weight ? ", :weight" : "";
        $stmt .= $newProduct->measure ? ", :measure" : "";
        $stmt .= $newProduct->height ? ", :height" : "";
        $stmt .= $newProduct->length ? ", :length" : "";
        $stmt .= $newProduct->image ? ", :image" : "";
        $stmt .= $newProduct->href ? ", :href" : "";
        $stmt.= ");";
        //Prepare the statement 
        $preparedStmt = $db->prepare($stmt);
        $preparedStmt->bindValue(':category_id', $newProduct->category_id, PDO::PARAM_INT);
        $preparedStmt->bindValue(':product_name', $newProduct->product_name, PDO::PARAM_STR);
        $preparedStmt->bindValue(':price', $newProduct->price, PDO::PARAM_STR);
        if(isset($newProduct->product_description))
            $preparedStmt->bindValue(':product_description', $newProduct->product_description, PDO::PARAM_STR);
        if(isset($newProduct->weight))
            $preparedStmt->bindValue(':weight', $newProduct->weight, PDO::PARAM_STR);
        if(isset($newProduct->measure))
            $preparedStmt->bindValue(':measure', $newProduct->measure, PDO::PARAM_STR);
        if(isset($newProduct->height))
            $preparedStmt->bindValue(':height', $newProduct->height, PDO::PARAM_STR);
        if(isset($newProduct->length))
            $preparedStmt->bindValue(':length', $newProduct->length, PDO::PARAM_STR);
        if(isset($newProduct->image))
            $preparedStmt->bindValue(':image', $newProduct->image, PDO::PARAM_STR);
        if(isset($newProduct->href))
            $preparedStmt->bindValue(':href', $newProduct->href, PDO::PARAM_STR);
        //Execute the prepared statement
        $success = $preparedStmt->execute();
        //Create a result object 
        $result = (object) array('success' => $success);
        //Return the result object 
        return $result;
    }
    catch (PDOException $ex)
    {
        //Create a result object 
        $result = (object) array('success' => false);
        //Save the error message in the result object 
        $result->Error = 'Unabble to create product: ' . $ex->getMessage();
        //Return the result object 
        return $result;
    }
}
//Get all the products from the database
function getProducts($category_id){
    try
    {
        //Set up a connection to the database 
        $db = databaseConnect(); 
        #Create the statemment to insert  the new product in the products table 
        $stmt = "SELECT * FROM products ";
        $stmt .= $category_id ? " where category_id = :category_id;" : ";";
        //Prepare the statement 
        $preparedStmt = $db->prepare($stmt);
        if(isset($category_id))
            $preparedStmt->bindValue(':category_id', $category_id, PDO::PARAM_INT);
        //Execute the prepared statement
        $preparedStmt->execute();
        $rows = $preparedStmt->fetchAll(PDO::FETCH_ASSOC);
        //Return all the products that were found 
        return $rows;
    }
    catch (PDOException $ex)
    {
        //Create a result object 
        $result = (object) array('success' => false);
        //Save the error message in the result object 
        $result->Error = 'Unable to return products: ' . $ex->getMessage();
        //Return the result object 
        return $result;
    }
}
//Get the product details of a product 
function getProduct($product_id){
    try
    {
        //Set up a connection to the database 
        $db = databaseConnect(); 
        #Create the statemment to insert  the new product in the products table 
        $stmt = "SELECT * FROM products where product_id = :category_id;";
        //Prepare the statement 
        $preparedStmt = $db->prepare($stmt);
        $preparedStmt->bindValue(':product_id', $product_id, PDO::PARAM_INT);
        //Execute the prepared statement
        $preparedStmt->execute();
        $rows = $preparedStmt->fetchAll(PDO::FETCH_ASSOC);
        //Return all the products that were found 
        return $rows;
    }
    catch (PDOException $ex)
    {
        //Create a result object 
        $result = (object) array('success' => false);
        //Save the error message in the result object 
        $result->Error = 'Unable to return products: ' . $ex->getMessage();
        //Return the result object 
        return $result;
    }
}
// getOneProduct
// updateProduct 
// deleteProduct 
?>