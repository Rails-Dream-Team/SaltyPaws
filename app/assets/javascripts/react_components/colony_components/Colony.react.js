var React = require('react');
var ColonyForm  = require('./ColonyForm.react.js');

var Colony = React.createClass({
  render: function() {
    return this._buildColony();
  },

  _buildColony: function() {
    return (
      <div>
        <a href={"/colonies/" + this.props.data.id}>{ this.props.data.name }</a>
      </div>
    );
  }

});

module.exports = Colony;
