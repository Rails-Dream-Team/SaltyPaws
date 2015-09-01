var React                = require('react');
var ReactGoogleMaps      = require('react-googlemaps');
var GoogleMapsAPI        = window.google.maps;
var Map                  = ReactGoogleMaps.Map;
var Marker               = ReactGoogleMaps.Marker;
var LatLng               = GoogleMapsAPI.LatLng;
var StickyDiv            = require('react-stickydiv');
var Colony               = require('../colony_components/Colony.react.js');
var geocoder             = new google.maps.Geocoder();
var request              = require('superagent');

var MapShow = React.createClass({

  render: function() {
    return (
      <Map
        initialZoom={17}
        initialCenter={ new LatLng(this.props.colony.lat, this.props.colony.lng) }
        width={600}
        height={600}
        >
        { this.renderMarkers() }
      </Map>
    );
  },

  renderMarkers: function() {
    return <Marker 
              position={ new LatLng(this.props.colony.lat, this.props.colony.lng) } 
              icon="/assets/cat30.png" />
  }

});

module.exports = MapShow;
