var React = require('react');
var Colony = require('./Colony.react.js');

var ColonyList = React.createClass({
  render: function(){
    return (
      <div>
        <h1>Colonies</h1>
        <div>
        <ul>
          <li>
            <div>
              <p>{this.props.name}</p>
              <p>{this.props.streetAddress}</p>
              <p>{this.props.city}</p>
              <p>{this.props.state}</p>
              <p>{this.props.zipCode}</p>
              <p>{this.props.environment}</p>
              <p>{this.props.pop}</p>
              <p>{this.props.vet}</p>
            </div>
          </li>
        </ul>
      </div>
      </div>
    );
  },

  _listColony: function() {
     return this.props.colonies.map(function(colony) {
      return <Colony data={colony} updateColony={this.props.updateColony} removeColony={this.props.removeColony} key={colony.name + colony.id} />
    }.bind(this));
  }
});

module.exports = ColonyList;
