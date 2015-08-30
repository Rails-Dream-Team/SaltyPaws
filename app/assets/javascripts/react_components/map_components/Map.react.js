"use strict";

var React                = require('react');
var ReactGoogleMaps      = require('react-googlemaps');
var ExecutionEnvironment = require('react/lib/ExecutionEnvironment')
var GoogleMapsAPI        = window.google.maps;
var Map                  = ReactGoogleMaps.Map;
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
    }
  },

  render: function() {
    return (
        <Map ref="map" initialZoom={13} initialCenter={this.state.center} width={500} height={500} >
      
        </Map>
      );
  }

});

module.exports = GoogleMap;
