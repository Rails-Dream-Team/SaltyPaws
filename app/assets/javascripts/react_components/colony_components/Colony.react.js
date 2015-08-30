var React = require('react');
var ColonyForm  = require('./ColonyForm.react.js');

var Colony = React.createClass({
  render: function() {
    return this._buildColony();
  },

  _buildColony: function() {
    return (
      <div>
        <p>{this.props.data.name}</p>
        <p>{this.props.data.street_address}</p>
        <p>{this.props.data.city}</p>
        <p>{this.props.data.state}</p>
        <p>{this.props.data.zip_code}</p>
        <p>{this.props.data.environment}</p>
        <p>{this.props.data.pop}</p>
        <p>{this.props.data.vet}</p>
      </div>
    );
  }

});

module.exports = Colony;