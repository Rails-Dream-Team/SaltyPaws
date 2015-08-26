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
      <StickyDiv offsetTop={40}>
        <Map
          initialZoom={13}
          initialCenter={this.state.center}
          width={500}
          height={500}>

          <OverlayView
            mapPane="floatPane"
            style={{padding: 15, backgroundColor: '#fff', border: '1px solid #000'}}
            position={this.state.center}>
            <h1>Simple overlay!</h1>
            <button
              onClick={this._handleButtonClick}>
              I have been clicked {this.state.count} time{this.state.count === 1 ? '' : 's'}
            </button>
          </OverlayView>
        </Map>
      </StickyDiv>
      );
  },

  _handleButtonClick: function() {
    this.setState({
      count: this.state.count + 1
    });
  }
});

module.exports = GoogleMap;
