var React         = require('react');
var Colonies      = require('./react_components/Colonies.react.js');
var Organizations = require('./react_components/Organizations.react.js');
var Users         = require('./react_components/Users.react.js');
var GoogleMapOverlayViewSimple        = require('./react_components/map_components/Map.react.js');

var components = function() {
  React.render(<GoogleMapOverlayViewSimple />, document.querySelector('[data-js="map"]'));
};


module.exports = components;