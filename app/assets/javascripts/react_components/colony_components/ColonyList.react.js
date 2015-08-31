var React = require('react');
var Colony = require('./Colony.react.js');

var ColonyList = React.createClass({
  render: function(){
    return (
      <div>
        <ul>
          {this._listColony()}
        </ul>
      </div>
    );
  },

  _listColony: function() {
     return this.props.colonies.map(function(colony) {
      return <li><Colony data={colony} /></li>
    });
  }
});

module.exports = ColonyList;
