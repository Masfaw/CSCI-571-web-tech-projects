<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
/**
 * Matheos Asfaw
 * CSCI 571 Home Work 8
 */



//constant Variables
define("MYACCESSTOKEN", "EAABbXZCIGHZBABAEwrTH21K0kRExhu3jxZBlkrf3nZC9NxwxQg90YrUQ1FhYPRoLenH9gx2mYD6mZChpZCTVzDtYGRJ8cy9e3eJvlWtFsX1IsrA0jEW9ByIMpj2iu0wy9CVsA4NDPizLUDtLNHapyV");
define("MYFEILDS", "id,name,picture.width(700).height(700)");
define("DETAIL_FEILDS", "id,name,picture.width(700).height(700),albums.limit(5){name,photos.limit(2){name,picture}},posts.limit(5)");

//define("DETAIL_FEILDS", "id,name,picture.width(700).height(700),albums.limit(5){name,photos.limit(2){name,picture}},posts.limit(5){created_time,message}");

define("GOOGLEKEY","AIzaSyDWTQYvROWZm9ixPMG5C2MXgXGx_U0wq5A");




if(isset($_GET)  || isset($_POST)){

    $location= "";
    $keyword = "";
    $returnFiles = [] ;
    $table;
    $details;
    $id;
    $type;




    if(isset($_GET["type"])){
        $type = $_GET["type"];

    }
    else {
        $returnFiles ["Error"] = "The request you made has an error pleas make sure that keys {key, loc , det , tab , id , type}  are set";

        echo json_encode($returnFiles);

    }





        if (isset($_GET["loc"])){
            $location = $_GET["loc"];
        }
        if (isset($_GET["key"])){
            $keyword = $_GET["key"];
        }
        if (isset($_GET["tab"])){
            $table = $_GET["tab"];

        }

        if (isset($_GET["det"])){
            $details = $_GET["det"];
        }

        if (isset($_GET["id"])){
            $id = $_GET["id"];
        }


        if($table =="true"){
            if (isset($type)) {


                $trimedKey = trim($keyword);
                $keyword = "";
                $KeyWordArray = explode(" ", $trimedKey);
                for ($i = 0; $i < count($KeyWordArray); $i++) {
                    $keyword .= $KeyWordArray[$i];
                    if ($i != (count($KeyWordArray) - 1)) {
                        $keyword .= "+";
                    }
                }

                if ($type == "users") {
                    $returnFiles["users"] = searchUsers($keyword);
                    error_log("users was called");
                } else if ($type == "events") {

                    $returnFiles["events"] = searchEvents($keyword);

                    error_log("events was called");
                } else if ($type == "place") {

                    $returnFiles["place"] = searchPlace($keyword, $location);

                    error_log("place was called");
                } else if ($type == "group") {
                    $returnFiles["group"] = searchGroup($keyword);
                    error_log("group was called");
                } else if ($type == "pages") {
                    $returnFiles["pages"] = searchPage($keyword);
                    error_log("pages was called");
                } else {
                    $returnFiles["error"] = "Wrong type is set";

                }


                echo json_encode($returnFiles);
            }
            else {
                $returnFiles ["Error"] = "The request you made has an error pleas make sure that keys {key, loc , det , tab , id , type}  are set";

                echo json_encode($returnFiles);
            }
        }
        else if ($details == "true"){

            $returnFiles = getDetails($id);

            echo json_encode($returnFiles);
        }
        else{
            $returnFiles ["Error"] = "The request you made has an error pleas make sure that keys {key, loc , det , tab , id , type}  are set";

            echo json_encode($returnFiles);
        }






}


function searchUsers($key){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=user&fields=".MYFEILDS."&access_token=".MYACCESSTOKEN."&limit=10";
    $userJson = file_get_contents($searchURL);
    if ($userJson === false ){
        return "didnt get anything";
    }
    $decoded = json_decode($userJson,true);
    return $decoded;
}


function searchEvents($key){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=event&fields=".MYFEILDS."&access_token=".MYACCESSTOKEN."&limit=10";
    $eventjson = file_get_contents($searchURL);
    if ($eventjson === false ){
        return "didnt get anything";
    }
    $decoded = json_decode($eventjson,true);
    return $decoded;
}

function searchPlace($key,$loc){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=place&fields=".MYFEILDS."&center=".$loc."&access_token=".MYACCESSTOKEN."&limit=10";
    $placeJson = file_get_contents($searchURL);
    if ($placeJson === false ){
        return "didnt get anything";
    }
    $decoded = json_decode($placeJson,true);
    return $decoded;
}

function searchGroup($key){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=group&fields=".MYFEILDS."&access_token=".MYACCESSTOKEN."&limit=10";
    $groupjson = file_get_contents($searchURL);
    if ($groupjson === false ){
        return "didnt get anything";
    }
    $decoded = json_decode($groupjson,true);
    return $decoded;
}

function searchPage($key){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=page&fields=".MYFEILDS."&access_token=".MYACCESSTOKEN."&limit=10";
    $pagejson = file_get_contents($searchURL);

    $decoded = json_decode($pagejson,true);
    return $decoded;
}


function getDetails($id){
   // error_log("getting the details");
    $urlDetail = "https://graph.facebook.com/v2.8/".$id."?fields=".DETAIL_FEILDS."&access_token=".MYACCESSTOKEN;


        $detailJson = file_get_contents($urlDetail);


        if ($detailJson === false){

            error_log(var_dump($detailJson));
            echo json_encode('');
        }

        $decoded = json_decode($detailJson,true);

        if ( isset($decoded["albums"])){


            for ($i = 0 ; $i < count($decoded["albums"]["data"]);$i++){



                if (isset($decoded["albums"]["data"][$i]["photos"])){

                    for ($j = 0; $j < count($decoded["albums"]["data"][$i]["photos"]["data"]);$j++){


                        $picId =$decoded["albums"]["data"][$i]["photos"]["data"][$j]["id"] ;
                        $picURl= "https://graph.facebook.com/v2.8/".$picId."/picture?redirect=false"."&access_token=".MYACCESSTOKEN;
                        $picJson = file_get_contents($picURl);
                        $picjsondecoded = json_decode($picJson,true);

                        $decoded["albums"]["data"][$i]["photos"]["data"][$j]["picture"] = $picjsondecoded["data"]["url"];
                    }

                }


            }

        }
        return $decoded;


}

?>


