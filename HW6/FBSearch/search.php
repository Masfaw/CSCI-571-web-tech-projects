<?php
$formKeyWord ="";
$formType ="";
$formLocation ="";
$formDistance ="";
$formId ="";

//when a post request is sent
if(isset($_POST['submit'])) {
    $formKeyWord= $_POST["keyWord"];
    $formType = $_POST["type"];
    $formLocation = $_POST["location"];
    $formDistance = $_POST["dist"];
}
if(isset($_GET['id'])){
    $formId = $_GET['id'];
    $formKeyWord= $_GET["keyWord"];
    $formType = $_GET["type"];
    $formLocation = $_GET["location"];
    $formDistance = $_GET["dist"];

}
?>
<html>

<!--
    Matheos Asfaw
    CSCI 571
    Home Work 6
    Facebook Search

 -->

<head>
    <meta charset="utf-8">
    <style>

        #table th,#table td ,#albumsTable tr, #postsTable tr, #postsTable th{
            border: 1px solid darkgray;
            border-collapse: collapse;
            text-align: left;
        }
        #albumsTable tr, #postsTable tr {
            margin: auto;
            width: 100%;
        }
        #Form{
            margin: auto;
            background-color: #f3f3f3;
            width : 40%;
            border: 1px solid darkgray;

            border-collapse:separate;
        }
        #table {
            margin: auto;
            background-color: #f3f3f3;
            width : 45%;
            border: 1px solid darkgray;
            border-collapse: collapse;
        }
        .detailTable{
            margin: auto;
            text-align: left;
            border: 1px solid darkgray;
            background-color: #f3f3f3;
            width : 45%;
            border-collapse: collapse;
        }
        #albumsTable, #postsTable{
            margin: auto;
            text-align: left;
            width : 45%;
            border: 1px solid darkgray;
            border-collapse: collapse;
        }

        #input{
            padding-left: 10px;
        }
        #title  {
            text-align: center;
            font-style: italic;
            font-size: x-large;
        }
        .loc{
            visibility: hidden;
            margin: auto;
        }
        .detailLink{
            background: none;
            boarder:none;
            padding: 0;
            font:inherit;
            cursor: pointer;
        }
    </style>
    <script>
        function toggleDetailsTab(elmt){
            console.log(elmt);
            if (elmt.style.display === 'none') {
                elmt.style.display = 'table';
            } else {
                elmt.style.display = 'none';

                var divelemnt = elmt.getElementsByTagName("div");

                for (var i= 0; i<divelemnt.length;i++){
                    divelemnt[i].style.display = 'none';
                }
            }
        }
        function colapseAlbums(){
            var albm = document.getElementById("albumsTable");
            if(albm != null){
                albm.style.display = 'none';
                var divelemnt = albm.getElementsByTagName("div");

                for (var i= 0; i<divelemnt.length;i++){
                    divelemnt[i].style.display = 'none';
                }
            }

        }
        function colapsePosts(){
            var pst = document.getElementById("postsTable");
            if(pst != null){
                pst.style.display = 'none';
                var divelemnt = pst.getElementsByTagName("div");

                for (var i= 0; i<divelemnt.length;i++){
                    divelemnt[i].style.display = 'none';
                }
            }

        }
        function changeVisiblity(selectObject, reset) {
            var list = document.getElementsByClassName("loc");
            var selection = selectObject.options[selectObject.selectedIndex].value;
            if (reset){
                for (var i =0; i< list.length;i++ ){

                    list[i].style.visibility = "hidden";
                    list[i].disabled = true;
                    console.log("In the reset func")
                    selectObject.selectedIndex = 0;
                    selectObject.value = "user";
                    var keyWord = document.getElementsByName("keyWord");
                    var location = document.getElementsByName("location");
                    var dist = document.getElementsByName("dist");
                    keyWord.value = "";
                    location.value = "";
                    dist.value = "";

                    }
                var inputs = document.getElementsByTagName("input");
                for (var i =0; i< inputs.length;i++ ) {
                    inputs[i].innerHTML = "";
                }
            }
            else{
                if (selection == "place"){
                    for (var i =0; i< list.length;i++ ){
                        list[i].style.visibility = "visible";
                        list[i].disabled = false;
                    }
                }
                else{
                    for (var i =0; i< list.length;i++ ){
                        list[i].style.visibility = "hidden";
                        list[i].disabled = true;
                    }
                }
            }
        }

    </script>
</head>

<body>
    <div id="Form">
        <p id="title">Facebook Search</p>
        <hr style="width: 98%" >
        <form id="input" method="post" action="search.php" >
            <table>
                <tr>
                    <td>KeyWord</td>
                    <td><input type="text" required name="keyWord"
                               value="<?php echo isset($formKeyWord)? $formKeyWord:"" ?>" ></td>
                </tr>
                <tr>
                    <td>Type</td>
                    <td>
                        <select name="type" size="1" onchange="changeVisiblity(this.form.type, false)"
                                onload="changeVisiblity(this.form.type,false)">
                            <option <?php if($formType == "user" || $formType == "" ){?>  selected = "true" <?php }; ?>   value="user">Users</option>
                            <option <?php if($formType == "page"){?>  selected = "true" <?php }; ?>    value="page">Pages</option>
                            <option <?php if($formType == "event"){?>  selected = "true" <?php }; ?>   value="event">Events</option>
                            <option <?php if($formType == "place"){?>  selected = "true" <?php  }; ?>   value="place">Places</option>
                            <option <?php if($formType == "group"){?>  selected = "true" <?php }; ?>   value="group">Groups</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="loc"  >Location</td>
                    <td class="loc" ><input type="text  " name="location"
                                            value="<?php echo isset($formLocation)? $formLocation:"" ?>"  ></td>

                    <td class="loc" >Distance(meters)</td>
                    <td class="loc"><input type="text  " name="dist" pattern="\d*"
                                           value="<?php echo isset($formDistance)? $formDistance:"" ?>"   ></td>
                </tr>
                <tr>
                    <td></td>
                    <td><INPUT type=submit name="submit" value="search"  >
                        <input type="submit" name="clear" value="clear" onclick="changeVisiblity(this.form.type,true)"  ></td>
                </tr>
            </table>
        </form>
    </div>
    <br/>

</body>
</html>
<?php

//making sure the autoload.php is included
require_once __DIR__ . '/php-graph-sdk-5/src/Facebook/autoload.php';


//constant Variables
define("MYACCESSTOKEN", "EAAacisUphtMBAHrGt9EwMyJysy0DXpyW4tFR5tT6lE0fLrNbPLbHV82fVXPfefsvgF525HZAzo2RO6OvYZA5QfA6gJfPgIxvqGhZBKK85NZCrDJJkjS8kAd8Tl58UUI8cGcqfP2dr8ZASVxPTWHwu");
define("MYFEILDS", "id,name,picture.width(700).height(700)");
define("DETAIL_FEILDS", "id,name,picture.width(700).height(700),albums.limit(5){name,photos.limit(2){name,picture}},posts.limit(5)");
define("GOOGLEKEY","AIzaSyDWTQYvROWZm9ixPMG5C2MXgXGx_U0wq5A");

//get Handler
if(isset($_GET['id'])){
    echo " <script>var t = document.getElementsByTagName(\"SELECT\");
            changeVisiblity(t[0],false);
        </script>";
    getDetail();
}

//POST Handler
else if(isset($_POST['submit'])) {


    echo " <script>var t = document.getElementsByTagName(\"SELECT\");
            changeVisiblity(t[0],false);
        </script>";


    search();

}
else if(isset($_POST["clear"])){
    unset($_POST);
    unset($_GET);
}
//Facebook Search
function search(){
    $keyWord = $_POST["keyWord"];
    $type = $_POST["type"];
    $location = "";
    $distance = "";
    $locString ="";
    $trimedKey = trim($_POST["keyWord"]);
    $keyWordString="";
    $KeyWordArray = explode(" ",$trimedKey);
    for ($i= 0; $i < count($KeyWordArray);$i++){
        $keyWordString .=$KeyWordArray[$i];
        if ($i != (count($KeyWordArray) -1)){
            $keyWordString .="+";
        }
    }
    if(isset($_POST["location"])){
        $location = $_POST["location"];
    }
    if(isset($_POST["dist"])){
        $distance = $_POST["dist"];


    }


    if ($type =="place"){




        if ($distance!= "" && $location==""){
            echo '<table id="table">';
            echo "<tr >";
            echo "<td style='text-align: center'> ";
            echo "Distance specified without location or address";
            echo "</td> ";
            echo "</tr>";
            echo "</table>";
            exit;

        }


        $urlSearch = "/search?q=".$keyWord."&type=".$type."&fields=".MYFEILDS;
        $locArray = explode(" ",trim($location));

        for ($i= 0; $i < count($locArray);$i++){
            $locString .=$locArray[$i];
            if ($i != (count($locArray) -1)){
                $locString .="+";
            }
        }
        $urlGoogle = "https://maps.googleapis.com/maps/api/geocode/json?address=".$locString."&key=".GOOGLEKEY;
        if ($location!=""){
            $addressJson = json_decode(file_get_contents($urlGoogle),true);
            $lat = $addressJson["results"]["0"]["geometry"]["location"]["lat"];
            $lng = $addressJson["results"]["0"]["geometry"]["location"]["lng"];
            $urlSearch ="/search?q=".$keyWord."&type=".$type."&center=".$lat.",".$lng."&distance=".$distance."&fields=".MYFEILDS;
        }

    }
    else if ($type =="event"){
        $urlSearch = "/search?q=".$keyWord."&type=".$type."&fields=".MYFEILDS.",place";
    }
    else{
        $urlSearch = "/search?q=".$keyWord."&type=".$type."&fields=".MYFEILDS;

    }
    //FaceBook Graph API
    $fb = new Facebook\Facebook([
        'app_id' => '1860969687516883',
        'app_secret' => 'c4e155986594879d46e7903cd06eb7e4',
        'default_graph_version' => 'v2.8',
    ]);
    $fb->setDefaultAccessToken(MYACCESSTOKEN);

    try{
        $response = $fb->get($urlSearch);
        //getting the json file
        $jsonArray = json_decode($response->getBody(), true);
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

    echo '<table id="table">';

    if (sizeof($jsonArray["data"]) == 0){
        echo "<tr >";
        echo "<td style='text-align: center'> ";
        echo "NO Records has been found";
        echo "</td> ";
        echo "</tr>";
    }

    else{
        //Creating the table
        echo '<tr style="background-color: #cbcbcb">';
        echo "<th>Profile Photo</th>";
        echo "<th>Name</th>";
        echo "<th>Details</th>";
        echo"</tr>";

        $hrefDist="";
        if(isset($_POST['dist'])){
            $hrefDist = $_POST['dist'];
        }
        foreach ($jsonArray["data"] as $key=>$value){

            $imgSrc =$value["picture"]["data"]["url"];
            $tdName = $value["name"];
            $tdId = $value["id"];

            $href = "http://cs-server.usc.edu:21571/HW6/search.php?keyWord="
                .$keyWordString."&type=".$_POST["type"]."&id=".$tdId."&location=".$locString."&dist=".$hrefDist;

            echo "<tr>";
            echo "<td> ";
            echo "<a href=".$imgSrc.' target ="_blank" >';
            echo '<img src='.$imgSrc.' alt="profilePic" height = 25 >';
            echo "</a>";
            echo "</td> ";
            echo "<td> ";
            echo  $tdName;
            echo "</td> ";
            echo "<td> ";
            if ($type=="event"){

                if (isset($value["place"])){
                    echo $value["place"]["name"];
                }
                else {
                    echo "Uknown";
                }
            }
            else {
                echo '<a href='.$href.' >';
                echo 'Details';
                echo "</a>";
            }

            echo "</td> ";
            echo "</tr>";
        }
    }
    echo "</table> ";
}

function getDetail(){

    //FaceBook Graph API
    $fb = new Facebook\Facebook([
        'app_id' => '1860969687516883',
        'app_secret' => 'c4e155986594879d46e7903cd06eb7e4',
        'default_graph_version' => 'v2.8',
    ]);
    $fb->setDefaultAccessToken(MYACCESSTOKEN);
    $urlDetail = $_GET["id"]."?fields=".DETAIL_FEILDS;

    try{
        $response = $fb->get($urlDetail);
        $jsonArray = json_decode($response->getBody(), true);
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






    echo '<table class="detailTable">';


    if ( !isset($jsonArray["albums"])  || count($jsonArray["albums"]["data"])==0){
        echo "<tr >";
        echo "<td style='text-align: center'> ";
        echo "NO Albums has been found";
        echo "</td> ";
        echo "</tr>";
        echo "</table>";
        echo "<br/>";
    }else if ( isset($jsonArray["albums"]["data"])&& count($jsonArray["albums"]["data"])>0){
        echo "<tr >";
        echo "<td style='text-align: center'> ";
        $albm ="albumsTable";
        echo '<a href="#" onclick="colapsePosts();toggleDetailsTab('.$albm.');">';
        echo 'Albums';
        echo "</a>";
        echo "</td> ";
        echo "</tr>";
        echo "</table>";




        echo '<table id="albumsTable" style="display: none">';
        echo "<br/>";
        $albRowNum = 0;
        foreach($jsonArray["albums"]["data"] as $key=> $value){
            $rowId = "albmRow".$albRowNum;

            if (isset($value["name"])){
                $name = trim($value["name"]);
                echo "<tr >";
                echo "<td>";

                if ( isset($value["photos"]) && count($value["photos"])>0){
                    echo '<a href="#" onclick="toggleDetailsTab('.$rowId.');">';
                    echo $name;
                    echo "</a>";
                    //echo "<br/>";
                    echo '<div style="display: none" id='.$rowId.'>';
                    echo"<pre>";
                    foreach($value["photos"]["data"] as $KeyPic=>$valPic){
                        $pic = $valPic["picture"];

                        $picId = $valPic["id"];

                        $imgSrc = "/".$picId."/picture?redirect=false";

                        try{
                            $response = $fb->get($imgSrc);
                            $imgJson = json_decode($response->getBody(), true);
                            //$imgJson = $response->getDecodedBody();;
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



                        $imgHref = $imgJson["data"]["url"];

                        echo "<a href=".$imgHref.' target ="_blank" >';
                        echo '<img src='.$pic.' alt="pic1" height= 80 >';
                        echo "</a>";
                        echo "   ";
                    }
                    echo"</pre>";
                    echo "</div>";
                }else{
                    echo $name;
                }
                echo "</td>";

                echo "</tr >";
            }

            $albRowNum++;
        }

        echo "</table>";
        echo "<br/>";
    }


    $messageArray = [];
  if (isset($jsonArray["posts"]["data"])){
      foreach($jsonArray["posts"]["data"] as $key =>$value){

          if (isset($value["message"])){
              array_push($messageArray,$value["message"]);
          }
      }
  }
    //
    echo '<table class="detailTable">';
    if ( count($messageArray) == 0){
        echo "<tr >";
        echo "<td style='text-align: center'> ";
        echo "NO Posts has been found";
        echo "</td> ";
        echo "</tr>";
        echo "</table>";
    }else {
        echo "<tr >";
        echo "<td style='text-align: center'> ";
        $postsTble ="postsTable";
        echo '<a href="#" onclick="colapseAlbums(); toggleDetailsTab('.$postsTble.');">';
        echo 'Posts';
        echo "</a>";
        echo "</td> ";
        echo "</tr>";

        echo "</table>";

        echo " <br/>";

        echo '<table id="postsTable" style="display: none">';
        echo "<th style='text-align: left; background-color: #f3f3f3'>";
        echo "Message";
        echo "</th>";

        foreach ($messageArray as $key=>$value){
            echo "<tr>";
            echo"<td>";
            echo $value;
            echo"</td>";
            echo "</tr>";
        }

        echo "</table>";
    }



}





?>




