var React         = require('react');
var Colonies      = require('./react_components/colony_components/Colonies.react.js');
var ColonyForm    = require('./react_components/colony_components/ColonyForm.react.js');
var Organizations = require('./react_components/Organizations.react.js');
var Users         = require('./react_components/Users.react.js');
var GoogleMap     = require('./react_components/map_components/Map.react.js');
var ColonyShow    = require('./react_components/colony_components/ColonyShow.react.js');
var components = function() {
  var colony = document.querySelector('[data-js="colony"]');
  var map = document.querySelector('[data-js="map"]');
  var organization = document.querySelector('[data-js="organization"]');
  var user = document.querySelector('[data-js="user"]');
  var colonyForm = document.querySelector('[data-js="colonyForm"]');
  var colonyShow = document.querySelector('[data-js="colonyShow"]');

  if (colony) {
    React.render(<Colonies />, colony);
  } else if (map) {
    React.render(<GoogleMap />, map);
  } else if (organization) {
    React.render(<Organizations />, organization);
  } else if (user) {
    React.render(<Users />, user);
  } else if (colonyForm) {
    React.render(<ColonyForm />, colonyForm);
  } else if (colonyShow) {
    React.render(<ColonyShow  />, colonyShow);
  }
};


module.exports = components;
