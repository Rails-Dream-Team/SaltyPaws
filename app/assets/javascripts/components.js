var React         = require('react');
var Colonies      = require('./react_components/Colonies.react.js');
var Organizations = require('./react_components/Organizations.react.js');
var Users         = require('./react_components/Users.react.js');
var GoogleMapOverlayViewSimple        = require('./react_components/map_components/Map.react.js');

var components = function() {
  var colony = document.querySelector('[data-js="colony"]');
  var map = document.querySelector('[data-js="map"]');
  var organization = document.querySelector('[data-js="organization"]');
  var user = document.querySelector('[data-js="user"]');

  if (colony) {
    React.render(<Colonies />, colony);
  } else if (map) {
    React.render(<GoogleMapOverlayViewSimple />, map);
  } else if (organization) {
    React.render(<Organizations />, organization);
  } else if (user) {
    React.render(<Users />, user);
  }
};


module.exports = components;
