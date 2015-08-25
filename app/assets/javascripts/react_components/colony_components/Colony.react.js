var React = require('react');

var Colony = React.createClass({
  render: function() {
    return this._buildColony();
  },

  _buildColony: function() {
    return (
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
    );
  }

});

module.exports = Colony;