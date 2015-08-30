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
      return <Colony onClick={this._codeAddress} data={colony} key={'colony' + colony.id}/>
    });
  },

  _codeAddress: function(e) {
    var address = this.props.data.street_address + ', ' + this.props.data.city
    geocoder.geocode({'address': address}, function(results, status) {
      if (status === google.maps.GeocoderStatus.OK) {
        var marker = results[0].geometry.location;
        console.log(marker);
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }
});

module.exports = ColonyList;
