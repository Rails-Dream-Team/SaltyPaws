var React         = require('react');
var Colonies      = require('./react_components/Colonies.react.js');
var Organizations = require('./react_components/Organizations.react.js');
var Users         = require('./react_components/Users.react.js');

var components = function() {
  var coloniesSelector = document.querySelector('[data-js]="colonies"');
  var organizationsSelector = document.querySelector('[data-js]="organizations"');
  var usersSelector = document.querySelector('[data-js]="users"');

  if (coloniesSelector) {
    React.render(<Colones />, coloniesSelector)
  }
  if (organizationsSelector) {
    React.render(<Organizations />, organizationsSelector)
  }
  if (usersSelector) {
    React.render(<Users />, usersSelector)
  }
};


module.exports = components;