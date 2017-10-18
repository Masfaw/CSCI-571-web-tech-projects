<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
/**
 * Matheos Asfaw
 * CSCI 571 Home Work 8
 */


//
//$postdata = file_get_contents("php://input");
//$request = json_decode($postdata,true);


//if(isset($_GET)){
//    error_log("Get is set ");
//    error_log($_GET["key"]);
//    error_log($_GET["loc"]);
//    error_log($_GET["det"]);
//    error_log($_GET["tab"]);
//}
//else {
//    error_log("get is not set");
//}

//constant Variables
//define("MYACCESSTOKEN", "EAAbTahGOGnEBAL6XlJr9ZATHlIqbg1PkLg0h3ZAynVb6gXNYw3wuU4TNnlr10rxG6GHNEWYCg38ZAEWUeh8SZBlpytauWYLhYHZAL5vb75Wn0M6M2mx3UALQTnUK680DaJIXbqKZCInpL6wLbTHim7");
define("MYACCESSTOKEN", "EAAbTahGOGnEBAL8cqFQEKXK0w9o9jODsiPPMeOFAztyo4mZB9QPMrNgbSQOdRmQcGUXcNlTY7XEwRufBtUnlFat0xTMpPHZCbWZB9MJAlLFAfexKlwUiuvVMslRT2IZCMYj66PnRvhYVyjrxICLoHYZBSBm0pVEoTAnbOjWgTNHb2QCWAh8Jn7ZCrfBcEZBZBgEZD");
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

   // error_log("I am in the Php code");
    //error_log($_GET["keyWord"]);

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


        $trimedKey = trim($keyword);
        $keyword="";
        $KeyWordArray = explode(" ",$trimedKey);
        for ($i= 0; $i < count($KeyWordArray);$i++){
            $keyword .=$KeyWordArray[$i];
            if ($i != (count($KeyWordArray) -1)){
                $keyword .="+";
            }
        }

        $returnFiles["users"] = searchUsers($keyword);
        $returnFiles["events"] = searchEvents($keyword);
       $returnFiles["place"] = searchPlace($keyword,$location);
        $returnFiles["group"] = searchGroup($keyword);
        $returnFiles["pages"] = searchPage($keyword);

        echo json_encode($returnFiles);
    }
    else if ($details == "true"){
//        $location = $request["location"];
//        $id = $request["id"];
        $returnFiles = getDetails($id);

        echo json_encode($returnFiles);
    }
    else{
        $returnFiles ["Error"] = "The request you made has an error pleas make sure that keys {key, loc , det , tab , id }  are set";

        echo json_encode($returnFiles);
    }

}


function searchUsers($key){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=user&fields=".MYFEILDS."&access_token=".MYACCESSTOKEN;
    $userJson = file_get_contents($searchURL);
    if ($userJson === false ){
        return "didnt get anything";
    }
    $decoded = json_decode($userJson,true);
    return $decoded;
}


function searchEvents($key){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=event&fields=".MYFEILDS."&access_token=".MYACCESSTOKEN;
    $eventjson = file_get_contents($searchURL);
    if ($eventjson === false ){
        return "didnt get anything";
    }
    $decoded = json_decode($eventjson,true);
    return $decoded;
}

function searchPlace($key,$loc){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=event&fields=".MYFEILDS."&center=".$loc."&access_token=".MYACCESSTOKEN;
    $placeJson = file_get_contents($searchURL);
    if ($placeJson === false ){
        return "didnt get anything";
    }
    $decoded = json_decode($placeJson,true);
    return $decoded;
}

function searchGroup($key){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=group&fields=".MYFEILDS."&access_token=".MYACCESSTOKEN;
    $groupjson = file_get_contents($searchURL);
    if ($groupjson === false ){
        return "didnt get anything";
    }
    $decoded = json_decode($groupjson,true);
    return $decoded;
}

function searchPage($key){

    $searchURL = "https://graph.facebook.com/v2.8/search?q=".$key."&type=page&fields=".MYFEILDS."&access_token=".MYACCESSTOKEN;
    $pagejson = file_get_contents($searchURL);

    $decoded = json_decode($pagejson,true);
    return $decoded;
}


function getDetails($id){
   // error_log("getting the details");
    $urlDetail = "https://graph.facebook.com/v2.8/".$id."?fields=".DETAIL_FEILDS."&access_token=".MYACCESSTOKEN;;


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






//    if ($detailJson === false){
//
//        error_log("I have failed to get details");
//
//        $decoded = [];
//        return $decoded;
//    }else{
//        $decoded = json_decode($detailJson,true);
//
//
//
//        if ( isset($decoded["albums"])){
//
//
//            for ($i = 0 ; $i < count($decoded["albums"]["data"]);$i++){
//
//
//
//                if (isset($decoded["albums"]["data"][$i]["photos"])){
//
//                    for ($j = 0; $j < count($decoded["albums"]["data"][$i]["photos"]["data"]);$j++){
//
//
//                        $picId =$decoded["albums"]["data"][$i]["photos"]["data"][$j]["id"] ;
//                        $picURl= "https://graph.facebook.com/v2.8/".$picId."/picture?redirect=false"."&access_token=".MYACCESSTOKEN;
//                        $picJson = file_get_contents($picURl);
//                        $picjsondecoded = json_decode($picJson,true);
//
//                        $decoded["albums"]["data"][$i]["photos"]["data"][$j]["picture"] = $picjsondecoded["data"]["url"];
//                    }
//
//                }
//
//
//            }
////       foreach ($decoded["albums"]["data"] as $albumKey => $albumValue){
////            //error_log("in a new Album");
////
////           foreach ($albumValue["photos"]["data"] as $key=>$value){
////
////
////              // error_log("getting new picture". $value["picture"]);
////               $picId = $value["id"];
////               //error_log("Picture id = ". $picId);
////               $picURl= "https://graph.facebook.com/v2.8/".$picId."/picture?redirect=false"."&access_token=".MYACCESSTOKEN;
////              $picJson = file_get_contents($picURl);
////               $picjsondecoded = json_decode($picJson,true);
////
////                   // error_log("BEFORE ".$value["picture"]);
////
////                  // $value ["picture"] = $picjsondecoded["data"]["url"];
////                   $value ["picture"] = "";
////              // error_log("AFTER ".$value["picture"]);
////
////
////           }
////       }
//
//
//        }
//        return $decoded;
//    }



}

?>


