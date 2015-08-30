var React = require('react');
var Colony = require('./Colony.react.js');
var ReactGoogleMaps      = require('react-googlemaps');
var GoogleMapsAPI        = window.google.maps;
var Map                  = ReactGoogleMaps.Map;
var geocoder             = new google.maps.Geocoder();

var ColonyList = React.createClass({
  render: function(){
    return (
      <div>
        {this._listColony()}
      </div>
    );
  },

  _listColony: function() {
     return this.props.colonies.map(function(colony) {
      return <Colony data={colony} />
    });
  }
});

module.exports = ColonyList;
