var React = require('react');
var Colony = require('./Colony.react.js');

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
    }.bind(this));
  }

});

module.exports = ColonyList;
