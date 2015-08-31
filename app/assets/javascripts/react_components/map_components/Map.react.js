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
      center: new LatLng(32.7828923, -79.9390598)
    }
  },

  render: function() {
    return (
        <Map
          initialZoom={12}
          initialCenter={this.state.center}
          width={500}
          height={500}
          >
          { this.renderMarkers() }
        </Map>
      );
  },

  renderMarkers: function() {
    return this.props.colonies.map(function(colony) {
      console.log(colony);
      return <Marker position={ new LatLng(colony.lat, colony.lng) } /> 
    });
  }

});

module.exports = GoogleMap;
