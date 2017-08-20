var markers = [];
var markerLayer = L.layerGroup();
var map = L.map('mapid');

L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
    maxZoom: 18,
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
    '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="http://mapbox.com">Mapbox</a>',
    id: 'mapbox.streets'
}).addTo(map);


//Find user's location
map.locate({setView: true, maxZoom: 16});



/**
    Listen event
*/

map.on('locationfound', onLocationFound);
map.on('locationerror', onLocationError);

map.on('click', getLatLng);


/**
    Function Definition
*/

function onLocationFound(e) {
    var radius = e.accuracy / 2;

    L.marker(e.latlng).addTo(map)
        .bindPopup("You are within " + radius + " meters from this point")
        .openPopup();

    L.circle(e.latlng, radius).addTo(map);
}


function onLocationError(e) {
    alert(e.message);
}


function loginToInstagram()
{
    $.get( "/oauth/connect", function( data ) {

        alert( "Load was performed." );
    });
}


function getLatLng(e){
    console.log("find latlng: "+e.latlng);
    var lat = e.latlng['lat'];
    var long = e.latlng['lng'];

    $.getJSON("/locations", {lat,long}, function(data){
        console.log(data);

        var locations = data; //change from var locations = data.data
        
        //clear current markers
        markerLayer.clearLayers();
        markers = []
        
        $.each(locations, function(key, val){
            console.log(val)
            var marker = addMarkers(val.location.latitude,val.location.longitude);
            addPopup(marker, val.location.name, val.location.frequency);     
            markers.push(marker); 
        });
        markerLayer.addLayer(markers);
    })

    .fail(function(err){
        console.log("Error from getLatLng() function in JS.");
        // console.log("getLatLng() func error: ", err);
    });
}


function addMarkers(lat,long){
    console.log(lat+" "+long)
    var marker = L.marker([lat, long]).addTo(map)
    
    marker.on('click', getImages);
    return marker;
}


function addPopup(marker, name,frequency){
    marker.bindPopup("<strong>"+name+"</strong><br/>" + "<strong>Rank: "+frequency+"</strong>");
}


function getImages(){

    $.getJSON('/locations/images', function (data) {
        $('.thumbs').empty();
        var images = data.data;
        $.each(images, function(key,val){
            insertImage(val.images.thumbnail.url)
        });
    })
}


function insertImage(url){
    var img = $('<img />').attr({
            'src': url+"?rand=" + Math.random().toString(),
            'alt': "loading...",
        }).appendTo('.thumbs');
}
