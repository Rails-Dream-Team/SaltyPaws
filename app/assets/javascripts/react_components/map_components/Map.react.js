"use strict";

var React                = require('react');
var ReactGoogleMaps      = require('react-googlemaps');
var ExecutionEnvironment = require('react/lib/ExecutionEnvironment')
var GoogleMapsAPI        = window.google.maps;
var Map                  = ReactGoogleMaps.Map;
var OverlayView          = ReactGoogleMaps.OverlayView;
var LatLng               = GoogleMapsAPI.LatLng;
var StickyDiv            = require('react-stickydiv');

var GoogleMap = React.createClass({
  getInitialState: function() {
    return {
      center: new LatLng(32.7828923, -79.9390598),
      count: 0
    };
  },

  render: function() {
    return (
        <Map
          initialZoom={13}
          initialCenter={this.state.center}
          width={500}
          height={500}>
        </Map>
      );
  },

  _handleButtonClick: function() {
    this.setState({
      count: this.state.count + 1
    });
  }
});

module.exports = GoogleMap;
