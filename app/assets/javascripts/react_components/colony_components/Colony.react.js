var React = require('react');
var ColonyForm  = require('./ColonyForm.react.js');

var Colony = React.createClass({
  render: function() {
    return this._buildColony();
  },

  _buildColony: function() {
    return (
      <span className="colony__span">
        <div className="colonies__listName">
          <a href={"/colonies/" + this.props.data.id}>{ this.props.data.name }</a>
        </div>
        <div className="colonies__listLocation">
        {this.props.data.city}, {this.props.data.state}
        </div>
        <div className="colonies__listPopulation">
        Population: {this.props.data.pop}
        </div>
      </span>
    );
  }

});

module.exports = Colony;
