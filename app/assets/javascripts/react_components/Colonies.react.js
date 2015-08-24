var React = require('react');
var request = require('superagent');
var Form = require('./colonies/Form.react.js');
var List = require('./colonies/List.react.js');

var Colonies = React.createClass({
  getInitialState: function() {
    return {
      colonies: []
    };
  },

  componentWillMount: function() {
    this._fetchColonies();
  },

  render: function() {
    return (
      <div>
        <List colonies={this.state.colonies} updateColony={this._updateColony} removeColony={this._removeColony} />
      </div>
    );
  },

  _fetchColonies: function() {
    request
      .get('/colonies')
      .set('Accept', 'application/json')
      .end(this._handleFetch);
  },

  _createColony: function(data) {
    request
      .post('/colonies')
      .send(data)
      .set('Accept', 'application/json')
      .set('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
      .end(this._handleChange);
  },

  _updateColony: function(data) {
    request
      .patch('/colonies/' + data.colony.id)
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

  _handleFetch: function(err, res) {
    if (err) { console.log(err.response); return; }
    this.setState({ colonies: res.body });
  },

  _handleChange: function(err, res) {
    if (err) { console.log(err.response); return; }
    this._fetchColonies();
  }
});

module.exports = Colonies;
