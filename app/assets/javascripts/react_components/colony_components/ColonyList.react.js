var React = require('react');
var Colony = require('./Colony.react.js');

var ColonyList = React.createClass({
  render: function(){
    return (
      <ul className="colonies__listUL">

          {this._listColony()}

      </ul>
    );
  },

  _listColony: function() {
     return this.props.colonies.map(function(colony) {
      return <li className="colonies__listLI"><Colony data={colony} /></li>
    });
  }
});

module.exports = ColonyList;
