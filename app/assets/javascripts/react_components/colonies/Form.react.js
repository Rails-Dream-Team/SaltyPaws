var React = require('react');

var Form = React.createClass({
  componentWillUpdate: function() {
    this._clearInputs();
  },

  render: function() {
    return (
      <form onSubmit={this._handleSubmit}>
        <div>
          <label htmlFor="name"> Name: </label>
          <input ref="name" id="name" />
        </div>
        <div>
          <label htmlFor="photo"> Photo: </label>
          <input ref="photo" id="photo" />
        </div>
        <div>
          <label htmlFor="street_address"> Street Address: </label>
          <input ref="street_address" id="street_address" />
        </div>
        <div>
          <label htmlFor="city"> City: </label>
          <input ref="city" id="city" />
        </div>
        <div>
          <label htmlFor="state"> State: </label>
          <input ref="state" id="state" />
        </div>
        <div>
          <label htmlFor="zip_code"> Zip Code: </label>
          <input ref="zip_code" id="zip_code" />
        </div>
        <div>
          <label htmlFor="enviroment"> Environment: </label>
          <input ref="enviroment" id="enviroment" />
        </div>
        <div>
          <label htmlFor="pop"> Population: </label>
          <input ref="pop" id="pop" />
        </div>
        <div>
          <label htmlFor="vet"> Veterinarian: </label>
          <input ref="vet" id="vet" />
        </div>
        <div>
          <button>Submit</button>
        </div>
      </form>
    );
  },

  _handleSubmit: function(e) {
    e.preventDefault();
    var data = {
      id: this.props.data.id,
      name: this.refs.name.getDOMNode().value.trim(),
      photo: this.refs.photo.getDOMNode().value.trim(),
      street_address: this.refs.street_address.getDOMNode().value.trim(),
      city: this.refs.city.getDOMNode().value.trim(),
      state: this.refs.state.getDOMNode().value.trim(),
      zip_code: this.refs.zip_code.getDOMNode().value.trim(),
      enviroment: this.refs.enviroment.getDOMNode().value.trim(),
      pop: this.refs.pop.getDOMNode().value.trim(),
      vet: this.refs.vet.getDOMNode().value.trim()
    };

    this.props.createColony(data);
  },

  _clearInputs: function() {
    var self = this;
    ['name', 'photo', 'street_address', 'city', 'state', 'zip_code', 'enviroment', 'pop', 'vet'].forEach(function(item) {
      self.refs[item].getDOMNode().value = '';
    });
  }
});

module.exports = Form;
