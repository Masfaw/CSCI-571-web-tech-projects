<?php

// echo $url;
// echo "<br />";
// echo "<br />";
//
// $string = file_get_contents($url);
//
// $json = json_decode($string);
//
// $formated =json_encode($json, JSON_FORCE_OBJECT|JSON_PRETTY_PRINT);
// echo  "<pre>".$formated."</pre>";
//
//
// echo "<br />";
// echo "<br />";
// var_dump($json);


//echo $json;
//echo "<pre>".$result."</pre>";





//$json = json_decode($response->getBody());

//$formated =json_encode($json, JSON_FORCE_OBJECT|JSON_PRETTY_PRINT);
$formated = $response->decodeBody();

// echo  "<br /> Bellow is the FB Graph API response <bre />";
echo "This is from decoded body function";
echo  "<pre>".$formated."</pre>";
echo "This is id 0 ".$formated["data"]["0"]["id"];




$string = file_get_contents($url);

$json = json_decode($string,true);
$number = 0;
$number1 = 1;
echo "<br/>";
echo $json["data"]["$number"]["id"];// this is how tou access the files
echo "<br/>";
echo $json["data"]["$number1"]["id"];
echo "<br/>";
echo "<br/>";
echo "<br / > Below is from the php call <br/ >";
$formated =json_encode($json, JSON_FORCE_OBJECT|JSON_PRETTY_PRINT);
echo  "<pre>".$formated."</pre>";




{
    /*

      //new Graph Api
      $fb = new Facebook\Facebook([
        'app_id' => '1860969687516883',
        'app_secret' => 'c4e155986594879d46e7903cd06eb7e4',
        'default_graph_version' => 'v2.8',
      ]);

      $fb->setDefaultAccessToken(MYACCESSTOKEN);



      //echo var_dump($fb->getApp()->getId(), $fb->getApp()->getSecret());


      echo "<br />";

      try{

        $response = $fb->get($urlSearch);
        $result = $response->getGraphEdge();
      //  $userNode = $response->getGraphUser();
      }
      catch(Facebook\Exceptions\FacebookResponseException $e){
        echo 'Graph returned an error: ' . $e->getMessage();
        exit;
      }
      catch(Facebook\Exceptions\FacebookSDKException $e) {
        // When validation fails or other local issues
        echo 'Facebook SDK returned an error: ' . $e->getMessage();
        exit;
      }

      //$album = $response->getGraphALbum();
      //echo $album;

      $array = $result->asArray();
      echo  "<pre>".$array."</pre>";;
      // echo "logged in as ". $userNode->getName();
    */
}



?>
