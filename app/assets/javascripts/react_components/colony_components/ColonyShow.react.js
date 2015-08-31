var React = require('react');
var request = require('superagent');
var GoogleMap = require('../map_components/Map.react.js');


var ColonyShow = React.createClass({
  getInitialState: function(){
    return {
      colony: []
    };
  },

  componentWillMount: function(){
    this._fetchColony();
  },

  render: function(){
    console.log(this.state.colony)
    if (this.state.colony.length > 0) {
      return (
        <div>
          <p>{this.state.colony.name}</p>
          <p>{this.state.colony.street_address}</p>
          <p>{this.state.colony.city}</p>
          <p>{this.state.colony.state}</p>
          <p>{this.state.colony.zip_code}</p>
          <p>{this.state.colony.environment}</p>
          <p>{this.state.colony.pop}</p>
          <p>{this.state.colony.vet}</p>
            <GoogleMap colony={this.state.colony} />
        </div>
      );
    } else {
      return null;
    }
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
