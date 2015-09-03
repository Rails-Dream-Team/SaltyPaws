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
      <div className="colony__main">
        <div className="colony__info">
          <div className="colony__infoHeader"><h4>More About { this.state.colony.name }</h4></div>
          <div className="colony__infoContent">
            <div className="colony__infoRow">
            <span className="colony__infoLabel">Street Address: </span>{this.state.colony.street_address}
            </div>
            <div className="colony__infoRow">
            <span className="colony__infoLabel">City/State: </span>{ this.state.colony.city } { this.state.colony.state } 
            </div>
            <div className="colony__infoRow">
            <span className="colony__infoLabel">Environment: </span>{ this.state.colony.environment }
            </div>
            <div className="colony__infoRow">
            <span className="colony__infoLabel">Population: </span>{ this.state.colony.pop}
            </div>
            <div className="colony__infoRow">
            <span className="colony__infoLabel">Veterinarian: </span>{ this.state.colony.vet}
            </div>
          </div>
        </div>
        <div className="colony__map">{map}</div>
      </div>
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
