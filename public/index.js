var mymap = L.map('mapid').setView([-41.28, 174.77], 12);

// var mymap = L.map('mapid').setView([51.505, -0.09], 13);

L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
    maxZoom: 18,
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
    '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="http://mapbox.com">Mapbox</a>',
    id: 'mapbox.streets'
}).addTo(mymap);

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

var greenIcon = L.icon({
    iconUrl: 'leaf-green.png',
    shadowUrl: 'leaf-shadow.png',

    iconSize:     [38, 95], // size of the icon
    shadowSize:   [50, 64], // size of the shadow
    iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
    shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
});
L.marker([51.5, -0.09], {icon: greenIcon}).addTo(map);


getDummy();

function getDummy(){
	$.getJSON("http://localhost:8080/public/data/dummy.json", function(data){
			console.log("Get ajax!")
			var locations = data.data;
			$.each(locations, function(key, val){
				showMarkers(val.location.latitude,val.location.longitude);
			});
		}
	)

	.fail(function(err){
		console.log(err)
	})
}


function showMarkers(lat,long){
	console.log(lat+" "+long)
	var marker = L.marker([lat, long]).addTo(mymap);
}
