var React = require('react');

var Colony = React.createClass({
  getInitialState: function() {
    return {
      isEditing: false
    };
  },

  render: function() {
    return this._buildCells();
  },

  _buildCells: function() {
    if (this.state.isEditing) {
      return (
        <div>
          <h3><input ref="name" type="text" defaultValue={this.props.data.name} /></h3>
          <div><input ref="photo" type="text" defaultValue={this.props.data.photo} /></div>
          <div>Street: <input ref="street_address" type="text" defaultValue={this.props.data.street_address} /></div>
          <div>City: <input ref="city" type="text" defaultValue={this.props.data.city} /></div>
          <div>State: <input ref="state" type="text" defaultValue={this.props.data.state} /></div>
          <div>Zip: <input ref="zip_code" type="text" defaultValue={this.props.data.zip_code} /></div>
          <div>Environment: <input ref="enviroment" type="text" defaultValue={this.props.data.enviroment} /></div>
          <div>Population: <input ref="pop" type="text" defaultValue={this.props.data.pop} /></div>
          <div>Veterinarian: <input ref="vet" type="text" defaultValue={this.props.data.vet} /></div>
          <div>
            <button onClick={this._handleSave}>Save</button>
          </div>
        </div>
      );
    } else {
      return (
        <div>
          <h3>{this.props.data.name}</h3>
          <div>{this.props.data.photo}</div>
          <div>Street: {this.props.data.street_address}</div>
          <div>City: {this.props.data.city}</div>
          <div>State: {this.props.data.state}</div>
          <div>Zip: {this.props.data.zip_code}</div>
          <div>Environment: {this.props.data.enviroment}</div>
          <div>Population: {this.props.data.pop}</div>
          <div>Veterinarian: {this.props.data.vet}</div>
          <div>
            <button onClick={this._handleEdit}>Edit</button>
            <button onClick={this._handleRemove}>Remove</button>
          </div>
        </div>
      );
    }
  },

  _handleEdit: function(event) {
    event.preventDefault();
    this.setState({ isEditing: true })
  },

  _handleRemove: function(event) {
    event.preventDefault();
    this.props.removeColony(this.props.data.id);
  },

  _handleSave: function(event) {
    event.preventDefault();
    var self = this
    var data = {
      colony: {
      id: self.props.data.id,
      name: self.refs.name.getDOMNode().value.trim(),
      photo: self.refs.photo.getDOMNode().value.trim(),
      street_address: self.refs.street_address.getDOMNode().value.trim(),
      city: self.refs.city.getDOMNode().value.trim(),
      state: self.refs.state.getDOMNode().value.trim(),
      zip_code: self.refs.zip_code.getDOMNode().value.trim(),
      enviroment: self.refs.enviroment.getDOMNode().value.trim(),
      pop: self.refs.pop.getDOMNode().value.trim(),
      vet: self.refs.vet.getDOMNode().value.trim()
      }
    };
    this.props.updateColony(data);
    // console.log(data);
  }
});

module.exports = Colony;
