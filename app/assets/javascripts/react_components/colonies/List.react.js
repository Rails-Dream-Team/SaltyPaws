var React = require('react');
var Colony = require('./Colony.react.js');

var List = React.createClass({
  render: function() {
    return (
      <div>
        <div class="colony_header">
          <h1>Colonies</h1>
          <a href="/reports/new">Report a New Colony</a>
        </div>
        <div className="colonies_list">
        {this._buildItems()}
        </div>
      </div>
    );
  },

  _buildItems: function() {
    return this.props.colonies.map(function(item) {
      return <Colony data={item} updateColony={this.props.updateColony} removeColony={this.props.removeColony} key={item.name + item.id} />
    }.bind(this));
  }
});

module.exports = List;
