var React                = require('react/addons');
var ReactGoogleMaps      = require('react-googlemaps');
var GoogleMapsAPI        = window.google.maps;
var Map                  = ReactGoogleMaps.Map;
var Marker               = ReactGoogleMaps.Marker;
var LatLng               = GoogleMapsAPI.LatLng;
var StickyDiv            = require('react-stickydiv');
var geocoder             = new google.maps.Geocoder();
var request              = require('superagent');
var infoWindow           = new google.maps.InfoWindow();

var GoogleMap = React.createClass({
  getInitialState: function() {
    return {
      center: new LatLng(32.7828923, -79.9390598)
    }
  },

  render: function() {
    return (
        <Map
          initialZoom={12}
          initialCenter={this.state.center}
          width={600}
          height={600}
          >
          { this.renderMarkers() }
        </Map>
      );
  },

  renderMarkers: function() {
    return this.props.colonies.map(function(colony) {
      return <Marker 
                position={ new LatLng(colony.lat, colony.lng) } 
                icon="/assets/cat30.png" />
    });
  },

  renderInfoWindow: function(e) {
    e.preventDefault();

    google.maps.event.addListener(Marker, 'click', function() {

      infoWindow.open(Map, Marker);
      infoWindow.setContent({
        content: "<h4>" + colony.name + "</h4>"
      });

    });
  }


});

module.exports = GoogleMap;
