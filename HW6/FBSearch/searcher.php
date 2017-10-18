
<html>

<!--
    Matheos Asfaw
    CSCI 571
    Home Work 6
    Facebook Search

 -->

<head>
    <style>
        #Form{
            margin: auto;
            background-color: #dddddd;
            width : 40%;
            border: 1px solid darkgray;
        }
        #table{
            margin: auto;
            background-color: #dddddd;
            width : 60%;
            border: 1px solid darkgray;
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

        }
    </style>

    <script>

        function changeVisiblity(selectObject, reset) {
            var list = document.getElementsByClassName("loc");
            var selection = selectObject.options[selectObject.selectedIndex].value;
            if (reset){
                for (var i =0; i< list.length;i++ ){
                    list[i].style.visibility = "hidden";
                    list[i].disabled = true;
                    selectObject.selectedIndex = 0;

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

        function changeDropdown() {


            console.log("changed the selected index");
        }


    </script>
</head>

<body>
    <div id="Form">
        <p id="title">Facebook Search</p>
        <hr style="width: 90%" >
        <form id="input" method="post" action="searcher.php" >
            <table>
                <tr>
                    <td>KeyWord</td>
                    <td><input type="text" required name="keyWord"
                               value="<?php echo isset($_POST["keyWord"])? $_POST["keyWord"]:"" ?>" ></td>
                </tr>
                <tr>
                    <td>Type</td>
                    <td>
                        <select name="type" size="1" onchange="changeVisiblity(this.form.type, false)"
                                onload="changeVisiblity(this.form.type,false)"

                                >
                            <option <?php if(isset($_POST["type"])&& $_POST["type"] == "user"){?>  selected = "true" <?php }; ?>   value="user">Users</option>
                            <option <?php if(isset($_POST["type"])&& $_POST["type"] == "page"){?>  selected = "true" <?php }; ?>    value="page">Pages</option>
                            <option <?php if(isset($_POST["type"])&& $_POST["type"] == "event"){?>  selected = "true" <?php }; ?>   value="event">Events</option>
                            <option <?php if(isset($_POST["type"])&& $_POST["type"] == "place"){?>  selected = "true"
                                         <?php  }; ?>   value="place">Places</option>
                            <option <?php if(isset($_POST["type"])&& $_POST["type"] == "group"){?>  selected = "true" <?php }; ?>   value="group">Groups</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="loc"  >Location</td>
                    <td class="loc" ><input type="text  " name="location"
                                            value="<?php echo isset($_POST["location"])? $_POST["location"]:"" ?>"  ></td>

                    <td class="loc" >Distance(meters)</td>
                    <td class="loc"><input type="text  " name="dist"
                                           value="<?php echo isset($_POST["dist"])? $_POST["dist"]:"" ?>"      ></td>
                </tr>
                <tr>
                    <td></td>
                    <td><INPUT type=submit name="submit" value="search" onclick="changeDropdown()" >
                        <input type="reset" value="clear" onclick="changeVisiblity(this.form.type,true)"></td>

                </tr>
            </table>
        </form>
    </div>

    <br/>
    <br/>
</body>
</html>
<?php
//<?php  $_POST["type"] ="user"; $_POST["type"] =""; //

//making sure the autoload.php is included
require_once __DIR__ . '/php-graph-sdk-5/src/Facebook/autoload.php';


//constant Variables
define("MYACCESSTOKEN", "EAAacisUphtMBALFbLe0XcZA8jnM04REv4c6Xj8g95HD4HoQZCu8gfT6c6Kj7ZBJLdXWtMEEdZBCQOYb9H3IZAFBPoRZA50VqzEIwB295DCZBZAyiTZAhfpARmv0ENu76vPahkaIlsdKwAXlcJS20eeoadZAyvL78HO05YZD");
define("MYFEILDS", "id,name,picture.width(700).height(700),albums.limit(5),posts.limit(5)");





//POST Handler
if(isset($_POST['submit'])) {

    echo " <script>var t = document.getElementsByTagName(\"SELECT\");        
            changeVisiblity(t[0],false);
        </script>";

    foreach ($_POST as $key => $value) {
        echo $key . " = " . $value . "<br/>";
    }
    search();


}

//Facebook Search
function search(){


    $keyWord = $_POST["keyWord"];
    $type = $_POST["type"];
    $location = "";
    $distance = "";
    if(isset($_POST["location"])){
        $location = $_POST["location"];
    }
    if(isset($_POST["dist"])){
        $distance = $_POST["dist"];
    }

    if ($type =="place"){
        $urlSearch = "/search?q=".$keyWord."&type=".$type."&fields=".MYFEILDS;
    }else{
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




    $number = 0;
    $number1 = 1;

//accessing the json file
    echo $jsonArray["data"]["$number"]["id"];
    echo "      ".$jsonArray["data"]["$number"]["name"];
    echo "<br/>";
    echo $jsonArray["data"]["$number1"]["id"];
    echo "      ".$jsonArray["data"]["$number1"]["name"];

    echo "<br/>";
    echo "<br/>";
    $formated =json_encode($jsonArray, JSON_FORCE_OBJECT|JSON_PRETTY_PRINT);
    echo  "<pre>".$formated."</pre>";




}







?>




