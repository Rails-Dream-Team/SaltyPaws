var React = require('react');
var request = require('superagent');
var ColonyForm = require('./ColonyForm.react.js');
var Colony = require('./Colony.react.js');
var ColonyList = require('./ColonyList.react.js')
var GoogleMap = require('../map_components/Map.react.js');

var Colonies = React.createClass({
  getInitialState: function() {
    return {
      colonies: []
    }
  },

  render: function() {
    if (this.state.colonies.length > 0) {
      return (
        <div>
          <ColonyList colonies={this.state.colonies} />
          <GoogleMap colonies={this.state.colonies} />
        </div>
      );
    } else {
      return null;
    }
  },

  componentDidMount: function() {
    this._retrieveColonies();
  },

  _retrieveColonies: function() {
    request
      .get('/colonies')
      .set('Accept', 'application/json')
      .end(this._handleRetrieve)
  },

  _createColony: function(data) {
    request
      .post('/colonies')
      .send(data)
      .set('Accept', 'application/json')
      .set('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
      .end(this._handleChange)
  },

  _updateColony: function(data) {
    request
      .patch('/colonies/' + data.id)
      .send(data)
      .set('Accept', 'application/json')
      .set('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
      .end(this._handleChange);
  },

  _removeColony: function(id) {
    request
      .del('/colonies/' + id)
      .set('Accept', 'application/json')
      .set('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
      .end(this._handleChange);
  },

  _handleRetrieve: function(err, res) {
    if (err) {
      window.alert('No Data Retrieved');
      return;
    } 
    this.setState({ colonies: res.body });
  },

  _handleChange: function(err, res) {
    if (err) {
      window.alert('No Data Saved');
      return;
    }
    this._retrieveColonies();
  }

});

module.exports = Colonies;
