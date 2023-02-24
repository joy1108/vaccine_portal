function initMap() {
  const myLatLng = { lat: parseFloat(lat), lng: parseFloat(lng)};
  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 15,
    center: myLatLng,
  });

  new google.maps.Marker({
    position: myLatLng,
    map,
    title: "test",
  });
}

window.initMap = initMap;