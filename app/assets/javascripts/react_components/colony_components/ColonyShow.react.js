var React     = require('react');
var request   = require('superagent');
var MapShow   = require('../map_components/MapShow.react.js');
var StickyDiv = require('react-stickydiv');


var ColonyShow = React.createClass({
  getInitialState: function(){
    return {
      colony: null
    };
  },

  componentWillMount: function(){
    this._fetchColony();
  },

  render: function(){
    var map
    if (this.state.colony) {
      map = <MapShow colony={this.state.colony} />
    } else {
      return null;
    }
    return (
      <ul>
        <li className="colony">
          <p><h3>Street: </h3>{this.state.colony.street_address}</p>
          <p><h3>City: </h3>{this.state.colony.city}</p>
          <p><h3>State: </h3>{this.state.colony.state}</p>
          <p><h3>Zip Code: </h3>{this.state.colony.zip_code}</p>
          <p><h3>Environment: </h3>{this.state.colony.environment}</p>
          <p><h3>Population: </h3>{this.state.colony.pop}</p>
          <p><h3>Vet: </h3>{this.state.colony.vet}</p>
        </li>
        <li className="colony">{map}</li>
      </ul>
    );
  },

  _fetchColony: function(){
    var path = window.location.pathname.split('/');
    var id = path[2];
    request
      .get('/colonies/' + id)
      .set('Accept', 'application/json')
      .end(this._handleFetch);
    },

    _handleFetch: function(err, res){
      if (err) {
        console.log(err.response);
        return;
      }
      this.setState({ colony: res.body })
    }


})

module.exports = ColonyShow
