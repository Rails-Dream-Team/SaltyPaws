"use strict";

var React                = require('react');
var ReactGoogleMaps      = require('react-googlemaps');
var ExecutionEnvironment = require('react/lib/ExecutionEnvironment')
var GoogleMapsAPI        = window.google.maps;
var Map                  = ReactGoogleMaps.Map;
var OverlayView          = ReactGoogleMaps.OverlayView;
var Marker               = ReactGoogleMaps.Marker;
var LatLng               = GoogleMapsAPI.LatLng;
var StickyDiv            = require('react-stickydiv');
var Colony               = require('../colony_components/Colony.react.js');
var geocoder             = new google.maps.Geocoder();
var request              = require('superagent'); 

var GoogleMap = React.createClass({
  getInitialState: function() {
    return {
      center: new LatLng(32.7828923, -79.9390598),
      colonies: this.props.data
    }
  },

  render: function() {
    return (
        <Map
          initialZoom={13}
          initialCenter={this.state.center}
          width={500}
          height={500}
          >
          <Marker position={this._codeAddress()}></Marker>
        </Map>
      );
  },

  _codeAddress: function() {
    var addresses = [];
    this.props.colonies.forEach(function(col) {
      addresses.push(col.street_address + ', ' + col.city);
    });
    console.log(addresses);
    for (var i = 0; i < addresses.length; i ++) {
      var address = addresses[i];
      geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          var marker = new google.maps.Marker({
              setMap: GoogleMap,
              position: results[0].geometry.location
          });
        } else {
          alert("Geocode was not successful for the following reason: " + status);
        }
      });
    }
  }

});

module.exports = GoogleMap;
