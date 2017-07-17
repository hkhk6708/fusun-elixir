var GoogleMap = {
  run: function(address_input_id, coordinate_input_id, map_div_id){
    var coordinate_element = document.getElementById(coordinate_input_id);
    var address_element = document.getElementById(address_input_id);
    var center_map = {lat: -33.8688, lng: 151.2195};
    if (coordinate_element.value != "" && address_element.value != ""){
      var lat = parseFloat(coordinate_element.value.split(",")[0]);
      var lng = parseFloat(coordinate_element.value.split(",")[1]);
      center_map = {lat: lat, lng: lng};
    }
    var map = new google.maps.Map(document.getElementById(map_div_id), {
      center: center_map,
      zoom: 20,
      mapTypeId: 'roadmap'
    });

    if(coordinate_element.value != "" && address_element.value != "") {
      new google.maps.Marker({
        map: map,
        title: address_element.value,
        position: center_map
      })
    }

    // Create the search box and link it to the UI element.
    var searchBox = new google.maps.places.SearchBox(address_element);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
      searchBox.setBounds(map.getBounds());
    });

    var markers = [];
    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBox.addListener('places_changed', function() {
      var places = searchBox.getPlaces();
      
      if (places.length == 0) {
        return;
      }
      
      // Clear out the old markers.
      markers.forEach(function(marker) {
        marker.setMap(null);
      });
      markers = [];

      // For each place, get the icon, name and location.
      var bounds = new google.maps.LatLngBounds();
      places.forEach(function(place) {
        if (!place.geometry) {
          console.log("Returned place contains no geometry");
          return;
        }
        var icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };
        
        // Create a marker for each place.
        markers.push(new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));

        // Set coordinate value
        coordinate_element.value = place.geometry.location.lat() + "," + place.geometry.location.lng();
        
        if (place.geometry.viewport) {
          // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
        }
      });
      map.fitBounds(bounds);
    });
  }
};
export {GoogleMap};
