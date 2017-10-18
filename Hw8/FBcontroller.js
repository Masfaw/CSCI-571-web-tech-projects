
var app = angular.module('myApp', ['ngAnimate']);
//$(function () {
//     $("input[name=key]").on("invalid", function () {
//         this.setCustomValidity("");
//         //this.setCustomValidity("Please type a keyword");
//
//     });
//
// });
//
// $('#form input[type=text]').on('change invalid', function() {
//     var textfield = $(this).get(0);
//
//     textfield.setCustomValidity('');
//
//     if (!textfield.validity.valid) {
//         textfield.setCustomValidity("Please type a keyword");
//     }
// });

$(document).ready(function(){
    $("#key").tooltip({trigger : 'manual'});




});

app.controller('myCtrl', function($scope, $http) {
    $scope.myLocation = "";
    $scope.keyword = "";
    $scope.files;
    $scope.details;
    $scope.thumbnail = "";
    $scope.showBar = false;
    $scope.showDetails = false;
    $scope.showDetailsContainer = false;
    $scope.showDetailsBar = true;


    $scope.users;
    $scope.pages;
    $scope.events;
    $scope.groups;
    $scope.places;
    $scope.detailObject = {};

     $scope.favs =[];
    // console.log(localStorage);


    if (typeof (Storage) !== "undefined"){
        keys = Object.keys(localStorage);
       // console.log(keys);

        for (var i=0;i<keys.length;i++){
          //  $scope.favs[keys[i]] = JSON.parse(localStorage.getItem(keys[i]));
            $scope.favs.push(JSON.parse(localStorage.getItem(keys[i])));
        }

      //  console.log($scope.favs);
    };



    $scope.hasData = false;
    $scope.albums;
    $scope.posts;

    $scope.NoPostsFound = false;
    $scope.NoAlbumsFound = false;
    $scope.showAlbums = false;
    $scope.showPosts = false;


    $scope.showUsers = false;
    $scope.showPages = false;
    $scope.showEvents = false;
    $scope.showPlaces = false;
    $scope.showGroups = false;
    $scope.showFavs = false;
    $scope.showFavsContainer = false;
    if ($scope.favs.length > 0 ){
        $scope.showFavs = true;
        $scope.showFavsContainer = true;
       // $scope.Nofavs = true;
    }



    $scope.NoUsers = false;
    $scope.NoPages = false;
    $scope.NoEvents = false;
    $scope.NoPlaces = false;
    $scope.NoGroups = false;
    $scope.Nofavs = false;

    // users
    $scope.hasPreviousUsers = false;
    $scope.hasNextUsers = false;
    $scope.previousUsersLink;
    $scope.nextUsersLink;

    //Pages
    $scope.hasPreviousPages = false;
    $scope.hasNextPages = false;
    $scope.previousPagesLink;
    $scope.nextPagesLink;

    //Events
    $scope.previousEventsLink;
    $scope.nextEventsLink;
    $scope.hasPreviousEvents = false;
    $scope.hasNexEvents = false;

    //Places
    $scope.hasPreviousPlaces = false;
    $scope.hasNextPlaces = false;
    $scope.previousPlacesLink;
    $scope.nextPlacesLink;

    //groups
    $scope.hasPreviousGroups = false;
    $scope.hasNextGroups = false;
    $scope.previousGroupsLink;
    $scope.nextGroupsLink;



    $scope.getLocation = function (){
       // console.log("getting location");
        if($scope.myLocation == ""){

            if(navigator.geolocation){
                navigator.geolocation.getCurrentPosition(function (position){
                    $scope.$apply(function(){
                        $scope.myLocation = position.coords.latitude + "," + position.coords.longitude ;
                    });
                });
            }

        }
   // console.log("have location");



    };



    $scope.getTableData = function(){


        if($scope.keyword!= ""){


            $("#key").tooltip('hide');
            $scope.turnAllOff();
            $scope.showDetailsContainer = false;

            $scope.clearAll();
           // console.log("fbsearch.php?key=" + $scope.keyword+"&loc="+$scope.myLocation+"&det=false&tab=true");


            // console.log($scope.myLocation);
            //console.log("looking for data ");
            $scope.showTables = true

            console.log("show tables = " + $scope.showTables);
            console.log("show bar = " + $scope.showBar);
            $scope.showBar = true;
            //$scope.toggleBar();
            $http.get("fbsearch.php?key=" + $scope.keyword+"&loc="+$scope.myLocation+"&det=false&tab=true")
                .then(function mySucces(response){
                    $scope.files = response.data;

                    //$scope.toggleBar();

                    $scope.showBar = false;
                    $scope.users = $scope.files.users.data;
                    $scope.pages = $scope.files.pages.data;
                    $scope.events = $scope.files.events.data;
                    $scope.groups = $scope.files.group.data;
                    $scope.places = $scope.files.place.data;
                    $scope.hasData = true;



                    if ($scope.favs.length > 0 ){
                        $scope.showFavs = true;
                        $scope.showFavsContainer = true;

                    }

                    // paging for users
                    if($scope.files.users.hasOwnProperty("paging")){
                        if($scope.files.users.paging.hasOwnProperty("previous")){
                            $scope.previousUsersLink = $scope.files.users.paging.previous;
                            $scope.hasPreviousUsers = true;

                        }
                        if ($scope.files.users.paging.hasOwnProperty("next")){
                            $scope.nextUsersLink =$scope.files.users.paging.next;
                            $scope.hasNextUsers = true;
                        }

                    }


                    // paging for pages
                    if($scope.files.pages.hasOwnProperty("paging")){

                        if($scope.files.pages.paging.hasOwnProperty("previous")){
                            $scope.previousPagesLink = $scope.files.pages.paging.previous;
                            $scope.hasPreviousPages = true;
                        }
                        if ($scope.files.pages.paging.hasOwnProperty("next")){
                            $scope.nextPagesLink = $scope.files.pages.paging.next;
                            $scope.hasNextPages = true;
                        }
                    }


                    //Paging for Events
                    if ($scope.files.events.hasOwnProperty("paging")){
                        if($scope.files.events.paging.hasOwnProperty("previous")){
                            $scope.previousEventsLink = $scope.files.events.paging.previous;
                            $scope.hasPreviousEvents = true;
                        }
                        if ($scope.files.events.paging.hasOwnProperty("next")){
                            $scope.nextEventsLink = $scope.files.events.paging.next;
                            $scope.hasNextEvents= true;
                        }
                    }


                    //Paging for places
                    if($scope.files.place.hasOwnProperty("paging")){
                        if($scope.files.place.paging.hasOwnProperty("previous")){
                            $scope.previousPlacesLink = $scope.files.place.paging.previous;
                            $scope.hasPreviousPlaces = true;
                        }
                        if ($scope.files.place.paging.hasOwnProperty("next")){
                            $scope.nextPlacesLink = $scope.files.place.paging.next;
                            $scope.hasNextPlaces= true;
                        }
                    }


                    //groups

                    if ($scope.files.group.hasOwnProperty("paging")){
                        if($scope.files.group.paging.hasOwnProperty("previous")){
                            $scope.previousGroupsLink = $scope.files.group.paging.previous;
                            $scope.hasPreviousGroups = true;
                        }
                        if ($scope.files.group.paging.hasOwnProperty("next")){
                            $scope.nextGroupsLink = $scope.files.group.paging.next;
                            $scope.hasNextGroups= true;
                        }
                    }



                    $scope.unhideTables();
                    // console.log($scope.users.length);

                    if ($scope.users.length > 0 ){
                        // console.log("There are users");
                        $scope.showUsers = true;
                        $scope.NoUsers = false;
                    }else {
                        // console.log("There are  No users");
                        $scope.NoUsers = true;
                        $scope.showUsers = false;
                    }


                    if ($scope.events.length >0 ){
                        //  console.log("There are events");
                        $scope.showEvents = true;
                        $scope.NoEvents = false;
                    }else {
                        //  console.log("there are no events ")
                        $scope.NoEvents = true;
                        $scope.showEvents = false;
                    }

                    if ($scope.pages.length>0 ){
                        $scope.showPages = true;
                        $scope.NoPages = false;
                    }else {
                        //  console.log("there are no Pages");
                        $scope.NoPages = true;
                        $scope.showPages = false;
                    }

                    if ($scope.groups.length >0 ){
                        $scope.showGroups = true;
                        $scope.NoGroups = false;
                    }else {
                        //   console.log("there are no groups")
                        $scope.NoGroups = true;
                        $scope.showGroups = false;
                    }

                    if ($scope.places.length > 0 ){
                        $scope.showPlaces = true;
                        $scope.NoPlaces = false;
                    }else {
                        //  console.log("there are no places");
                        $scope.showPlaces = false;
                        $scope.NoPlaces = true;
                    }

                    if ($scope.favs.length > 0 ){
                        $scope.showFavs = true;
                        $scope.Nofavs = false;
                    }else {
                        //  console.log("there are no Favs ")
                        $scope.Nofavs = true;
                    }


                    //  console.log($scope.files);
                },function myError(response){
                    console.log("I have failed to get Table Data ")

                    // $scope.files = response.data;
                });



        }
        else{
            $("#key").tooltip('show');
        }

    };


    $scope.getDetails = function(item,ty){

        $scope.showFavs = false;
        //$scope.showFavsContainer = false;
        $scope.detailObject = item;
        $scope.detailObject.type = ty;
        var idNum = item.id;

        $scope.showTables = false;




        // $scope.showUsers = false;
        // $scope.showPages = false;
        // $scope.showEvents = false;
        // $scope.showPlaces = false;
        // $scope.showGroups = false;
        // $scope.showFavs = false;


        //$scope.turnAllOff();
        $scope.showDetailsContainer = true;
        $scope.showDetails = true;


       // console.log("in details " + idNum);
       // $scope.toggleTable();
       // $scope.toggleDetails();

        $scope.showDetailsBar = true;
        $scope.showAlbums = false;
        $scope.showPosts = false;
        $scope.NoAlbumsFound = false;
        $scope.NoPostsFound = false;



        $http.get("fbsearch.php?key=" + $scope.keyword+"&loc="+$scope.myLocation+"&det=true&tab=false&id=" + idNum)
            .then(function mySucces(response){
                $scope.details = response.data;
               // console.log($scope.details);

                if ($scope.details.hasOwnProperty("picture")){
                    $scope.thumbnail = $scope.details.picture.data.url;
                }

                if ($scope.details.hasOwnProperty("albums")){
                    $scope.albums = $scope.details.albums.data ;
                }else{
                    $scope.albums = {};
                }

                if ($scope.details.hasOwnProperty("posts")){
                    $scope.posts = $scope.details.posts.data
                }else {
                    $scope.posts ={};
                }

                // console.log("Details");
                // console.log($scope.details);
                // console.log("Albums");
                // console.log($scope.albums);
                // console.log("Posts");
                // console.log($scope.posts);

                $scope.showDetailsBar = false;
                $scope.checkDetails();

            }, function myError(response) {
                //console.log("I have failed to get details");

               // $scope.details = response.data;


                $scope.showDetailsBar = false;
                $scope.showAlbums = false;
                $scope.showPosts = false;
                $scope.NoAlbumsFound = true;
                $scope.NoPostsFound = true;

            });





        // $http({
        //     method : "GET",
        //     url : "fbsearch.php",
        //     data: {"table" : false,
        //         "details" : true,
        //         "id" : idNum,
        //         "location" : $scope.myLocation,
        //     },
        //     headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        // }).then(function mySucces(response){
        //     $scope.details = response.data;
        //
        //     $scope.thumbnail = $scope.details.picture.data.url;
        //
        //     if ($scope.details.hasOwnProperty("albums")){
        //         $scope.albums = $scope.details.albums.data ;
        //     }
        //
        //     if ($scope.details.hasOwnProperty("posts")){
        //         $scope.posts = $scope.details.posts.data
        //     }
        //     console.log("Albums");
        //     console.log($scope.albums);
        //     console.log("Posts");
        //     console.log($scope.posts);
        //     console.log("Details");
        //     console.log($scope.details);
        //
        //
        //
        //     $scope.showDetailsBar = false;
        //     $scope.checkDetails();
        //
        //
        // }, function myError(response) {
        //     $scope.details = response.data;
        //
        // });


    };

    $scope.storeLocally = function(item,ty){


        item.type = ty;
        var id = JSON.stringify(item.id);
        var obj = JSON.stringify(item);
       // console.log(obj);

        if (typeof (Storage) !== "undefined"){


           // console.log(localStorage);
            if (localStorage.getItem(id) == null ){

                localStorage.setItem(id,obj);
                $scope.favs.push(item);
               // console.log("item =>" + id + " added to Local storage");
            }else{

                localStorage.removeItem(id);
                //console.log("Item removed from local storage");
                var idNum = item.id;

                for (var i =0; i <$scope.favs.length;i++){
                    if (idNum == $scope.favs[i].id){
                        delete $scope.favs.splice(i,1);
                    }
                }
            }
        }
        else{
            alert ("Sorry! No Web Storage support.. ");
        }
    };

    $scope.removeFromLocal = function(idNum){

        var id = JSON.stringify(idNum);

        if (typeof (Storage) !== "undefined"){


                localStorage.removeItem(id);

            for (var i =0; i <$scope.favs.length;i++){
                if (idNum == $scope.favs[i].id){
                    delete $scope.favs.splice(i,1);
                   // console.log("deleted from the favs ")
                }
            }

        }

        if ($scope.favs.length <= 0 ){
            $scope.showFavs = false;
            $scope.Nofavs = true;
        }



    };

    $scope.getStar = function (item){

        //console.log("Get Star called on " + item.id);

        var id = JSON.stringify(item.id);

        var obj = JSON.stringify(item);
        //
        // console.log(id);
        // console.log(obj);
        // console.log(localStorage.getItem(id));

        if (localStorage.getItem(id) != null ){
           // console.log(item.name + " is in the favs list");
           // console.log("**************************************************************");
            return"glyphicon glyphicon-star";
        }
        else{
           // console.log(item.name + " is not in the favs list");
           // console.log("**************************************************************");
            return "glyphicon glyphicon-star-empty";
        }


    };

    $scope.getColor = function (item) {

        var id = JSON.stringify(item.id);
        var obj = JSON.stringify(item);
        if (localStorage.getItem(id) != null ){
            return"gold";
        }
        else{
            return "";
        }

    }



    $scope.getUsersPage = function (link){




        $http.get(link).then(function mySucces(response){
            $scope.requestedFiles = response.data;



            $scope.users = $scope.requestedFiles.data;

            if ($scope.requestedFiles.hasOwnProperty("paging")){
                if($scope.requestedFiles.paging.hasOwnProperty("previous")){
                    $scope.previousUsersLink = $scope.requestedFiles.paging.previous;
                    $scope.hasPreviousUsers = true;

                }else {
                    $scope.hasPreviousUsers = false;
                }
                if ($scope.requestedFiles.paging.hasOwnProperty("next")){
                    $scope.nextUsersLink =$scope.requestedFiles.paging.next;

                    $scope.hasNextUsers = true;
                }else{
                    $scope.hasNextUsers = false;
                }
            }else{
                $scope.hasNextUsers = false;
            }






        })


    };

    $scope.getPagesTab = function (link){




        $http.get(link).then(function mySucces(response){
            $scope.requestedFiles = response.data;

            $scope.pages = $scope.requestedFiles.data;

            if($scope.requestedFiles.hasOwnProperty("paging")){
                if($scope.requestedFiles.paging.hasOwnProperty("previous")){
                    $scope.previousPagesLink = $scope.requestedFiles.paging.previous;
                    $scope.hasPreviousPages = true;

                }else {
                    $scope.hasPreviousPages = false;
                }
                if ($scope.requestedFiles.paging.hasOwnProperty("next")){
                    $scope.nextPagesLink =$scope.requestedFiles.paging.next;
                    $scope.hasNextPages = true;
                }else{
                    $scope.hasNextPages = false;
                }
            }else{
                $scope.hasNextPages = false;
            }


        })


    };

    //Events Pagging

    $scope.getEventsTab = function (link){




        $http.get(link).then(function mySucces(response){
            $scope.requestedFiles = response.data;

            $scope.events = $scope.requestedFiles.data;

            if ($scope.requestedFiles.hasOwnProperty("paging")){

                if($scope.requestedFiles.paging.hasOwnProperty("previous")){
                    $scope.previousEventsLink = $scope.requestedFiles.paging.previous;
                    $scope.hasPreviousEvents = true;

                }else {
                    $scope.hasPreviousEvents = false;
                }
                if ($scope.requestedFiles.paging.hasOwnProperty("next")){
                    $scope.nextEventsLink =$scope.requestedFiles.paging.next;
                    $scope.hasNextEvents = true;
                }else{
                    $scope.hasNextEvents = false;
                }
            }
            else{
                $scope.hasNextEvents = false;
            }


        })


    };


    $scope.getPlacesTab = function (link){




        $http.get(link).then(function mySucces(response){
            $scope.requestedFiles = response.data;

            $scope.places = $scope.requestedFiles.data;

            if ($scope.requestedFiles.hasOwnProperty("paging")){

                if($scope.requestedFiles.paging.hasOwnProperty("previous")){
                    $scope.previousPlacesLink = $scope.requestedFiles.paging.previous;
                    $scope.hasPreviousPlaces = true;

                }else {
                    $scope.hasPreviousEvents = false;
                }
                if ($scope.requestedFiles.paging.hasOwnProperty("next")){
                    $scope.nextPlacesLink =$scope.requestedFiles.paging.next;
                    $scope.hasNextPlaces = true;
                }else{
                    $scope.hasNextPlaces = false;
                }
            }else{
                $scope.hasNextPlaces = false;
            }


        })


    };




    $scope.getGroupsTab = function (link){

        $http.get(link).then(function mySucces(response){
            $scope.requestedFiles = response.data;

            $scope.groups = $scope.requestedFiles.data;

            if ($scope.requestedFiles.hasOwnProperty("paging")){
                if($scope.requestedFiles.paging.hasOwnProperty("previous")){
                    $scope.previousGroupsLink = $scope.requestedFiles.paging.previous;
                    $scope.hasPreviousGroups = true;

                }else {
                    $scope.hasPreviousGroups = false;
                }
                if ($scope.requestedFiles.paging.hasOwnProperty("next")){
                    $scope.nextGroupsLink =$scope.requestedFiles.paging.next;
                    $scope.hasNextGroups = true;
                }else{
                    $scope.hasNextGroups = false;
                }
            }
            else{
                $scope.hasNextGroups = false;
            }


        })

    };


    $scope.turnAllOff = function (){
       // $scope.showTables = false;

         $scope.showUsers = false;
        $scope.showPages = false;
        $scope.showEvents = false;
        $scope.showPlaces = false;
        $scope.showGroups = false;



        $scope.NoUsers = false;
        $scope.NoPages = false;
        $scope.NoEvents = false;
        $scope.NoPlaces = false;
        $scope.NoGroups = false;



        $scope.hasNextUsers = false;
        $scope.hasPreviousUsers = false;
        $scope.hasNextPages = false;
        $scope.hasPreviousPages = false;
        $scope.hasNextEvents = false;
        $scope.hasPreviousEvents = false
        $scope.hasPreviousPlaces = false;
        $scope.hasNextPlaces = false;
        $scope.hasNextGroups = false;
        $scope.hasPreviousGroups = false;

    };


    $scope.clearAll = function (){
        $scope.showTables = false;
        $scope.showDetailsContainer = false;

        $scope.showUsers = false;
        $scope.showPages = false;
        $scope.showEvents = false;
        $scope.showPlaces = false;
        $scope.showGroups = false;



        $scope.NoUsers = false;
        $scope.NoPages = false;
        $scope.NoEvents = false;
        $scope.NoPlaces = false;
        $scope.NoGroups = false;



        if ($scope.favs.length <= 0 ){
            $scope.showFavsContainer = true;
            $scope.Nofavs = true;

        }
        console.log("clearAll() -- has been called");

        $scope.hasData = false;
        $scope.files = [];
        $scope.details= [];
        $scope.users = [];
        $scope.pages = [];
        $scope.events = [];
        $scope.groups = [];
        $scope.places= [];
        $scope.albums = [];
        $scope.posts = [];

    };

    $scope.clearKeyword = function (){
        $scope.keyword = "";
    };




    $scope.unhideTables = function (){
        //console.log("unhideTables() -- has been called");

        $scope.showDetailsContainer = false;
        $scope.showFavsContainer = true;

        if ($scope.hasData){
            $scope.showTables = true;



            if ($scope.users.length > 0 ){
               // console.log("There are users");
                $scope.showUsers = true;
                $scope.NoUsers = false;
            }else {
                //console.log("There are  No users");
                $scope.NoUsers = true;
                $scope.showUsers = false;
            }


            if ($scope.events.length >0 ){
               // console.log("There are events");
                $scope.showEvents = true;
                $scope.NoEvents = false;
            }else {
               // console.log("there are no events ")
                $scope.NoEvents = true;
                $scope.showEvents = false;
            }

            if ($scope.pages.length>0 ){
                $scope.showPages = true;
                $scope.NoPages = false;
            }else {
              //  console.log("there are no Pages");
                $scope.NoPages = true;
                $scope.showPages = false;
            }

            if ($scope.groups.length >0 ){
                $scope.showGroups = true;
                $scope.NoGroups = false;
            }else {
              //  console.log("there are no groups")
                $scope.NoGroups = true;
                $scope.showGroups = false;
            }

            if ($scope.places.length > 0 ){
                $scope.showPlaces = true;
                $scope.NoPlaces = false;
            }else {
              //  console.log("there are no places");
                $scope.showPlaces = false;
                $scope.NoPlaces = true;
            }

            if ($scope.favs.length > 0 ){
                $scope.showFavs = true;
                $scope.Nofavs = false;
            }else {
                console.log("there are no Favs ")
                $scope.Nofavs = true;
            }
            // $scope.showUsers = true;
            // $scope.showPages = true;
            // $scope.showEvents = true;
            // $scope.showPlaces = true;
            // $scope.showGroups = true;
            // $scope.showFavs = true;
            //
            // $scope.NoUsers = false;
            // $scope.NoPages = false;
            // $scope.NoEvents = false;
            // $scope.NoPlaces = false;
            // $scope.NoGroups = false;
            // $scope.Nofavs = false;


        }

        if ($scope.favs.length > 0 ){
            $scope.showFavs = true;
            $scope.showFavsContainer = true;

        }
        $scope.showDetails = false;

    }





    $scope.toggleBar = function(){

        $scope.showBar = !$scope.showBar
    };


    $scope.toggleTable = function (){
        $scope.showTables = !$scope.showTables;
    }

    $scope.toggleDetails = function (){
        $scope.showDetails = !$scope.showDetails;
    }


    $scope.checkDetails = function(){

        if( !$scope.details.hasOwnProperty("albums")){
           // console.log("Doesnt have Albums");
            $scope.NoAlbumsFound = true;
            $scope.showAlbums = false;

        }else{
            $scope.NoAlbumsFound = false;
            $scope.showAlbums = true;


        }


        if (!$scope.details.hasOwnProperty("posts")){
           // console.log("Doesnt have posts");

            $scope.showPosts = false;
            $scope.NoPostsFound= true;

        }
        else {
            $scope.showPosts = true;
            $scope.NoPostsFound = false;
        }


    }



    $scope.postonFB = function (){

        FB.ui({
            app_id: 1921302374783601,
            method: 'feed',
            link: window.location.href,
            picture: $scope.thumbnail,
            name: $scope.details.name,
            caption: "FB SEARCH FROM USC CSCI571",
        }, function(response){
            if (response && !response.error_message)
                alert("Posted Succesfully");
            else
                alert("Not Posted");
        });
    };




});





