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
              <p>{this.props.data.name}</p>
              <p>{this.props.data.streetAddress}</p>
              <p>{this.props.data.city}</p>
              <p>{this.props.data.state}</p>
              <p>{this.props.data.zipCode}</p>
              <p>{this.props.data.environment}</p>
              <p>{this.props.data.pop}</p>
              <p>{this.props.data.vet}</p>
            </div>
          </li>
        </ul>
      </div>
    );
  }

});

module.exports = Colony;