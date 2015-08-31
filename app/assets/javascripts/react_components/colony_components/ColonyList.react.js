var React = require('react');
var Colony = require('./Colony.react.js');

var ColonyList = React.createClass({
  render: function(){
    return (
      <div className="colonies__list">

          {this._listColony()}
        
      </div>
    );
  },

  _listColony: function() {
     return this.props.colonies.map(function(colony) {
      return <ul className="colonies__listUL"><Colony data={colony} /></ul>
    });
  }
});

module.exports = ColonyList;
