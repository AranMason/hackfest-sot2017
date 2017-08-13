$('document').ready(function(){
    console.log("Document ready");
});

var map = L.map('mapid').setView([-41.28, 174.77], 12);

L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
    maxZoom: 18,
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
    '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="http://mapbox.com">Mapbox</a>',
    id: 'mapbox.streets'
}).addTo(map);

map.locate({setView: true, maxZoom: 16});

function onLocationFound(e) {
    var radius = e.accuracy / 2;

    L.marker(e.latlng).addTo(map)
        .bindPopup("You are within " + radius + " meters from this point").openPopup();

    L.circle(e.latlng, radius).addTo(map);
}

map.on('locationfound', onLocationFound);

function loginToInstagram()
{
    $.get( "/oauth/connect", function( data ) {

        alert( "Load was performed." );
    });
}
function onLocationError(e) {
    alert(e.message);
}

map.on('locationerror', onLocationError);

// var userLocationIcon = L.icon({
//     iconUrl: 'images/userlocationIcon.png',
//     shadowUrl: 'leaf-shadow.png',

//     iconSize:     [38, 95], // size of the icon
//     shadowSize:   [50, 64], // size of the shadow
//     iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
//     shadowAnchor: [4, 62],  // the same for the shadow
//     popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
// });
// L.marker([51.5, -0.09], {icon: userLocationIcon}).addTo(map);

//getDummy();



function getLatLng(e){
    console.log("find latlng: "+e.latlng);
    var latLng = e.latlng;
    var lat = e.latlng['lat'];
    var long = e.latlng['lng'];

    $.getJSON("/locations", {lat,long}, function(data){
        console.log(data);
        
        var locations = data.data;
        $.each(locations, function(key, val){
            console.log(val)
            showMarkers(val.location.latitude,val.location.longitude,val.location.name, val.location.frequency)
            
        });

    });

}

/**
    Listen event
*/
map.on('click', getLatLng);




/**
    Function Definition
*/

function showMarkers(lat,long, name, frequency){
    console.log(lat+" "+long)
    var marker = L.marker([lat, long]).addTo(map).bindPopup("<strong>"+name+"</strong><br/>" + "<strong>Rank: "+frequency+"</strong>");
    marker.on('click', getImages);
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













// function getDummy(){
// 	$.getJSON("data/dummy.json", function(data){
// 			console.log("Get ajax!")
// 			var locations = data.data;
// 			$.each(locations, function(key, val){
// 				showMarkers(val.location.latitude,val.location.longitude);
// 			});
// 		}
// 	)

// 	.fail(function(err){
// 		console.log("oops ",err)
// 	})
// }
