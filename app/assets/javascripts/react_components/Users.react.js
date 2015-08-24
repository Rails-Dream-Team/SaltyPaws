var React = require('react');
var request = require('superagent')

var Users = React.createClass ({
  getInitialState: function(){
    return {
      isEditing: false,
      user: []
    };
  },

  componentWillMount: function(){
    this._fetchUser();
  },

  render: function(){
    if (this.state.isEditing) {
      return (
        <div className="user_wrapper">
          <div className="user_picture">
            <h1>
              <div><h1><input ref="first_name" type="text" defaultValue={ this.state.user.first_name } /> <input ref="last_name" type="text" defaultValue={ this.state.user.last_name  } /></h1></div>
            </h1>
              <img src="http://38.media.tumblr.com/avatar_c44e2933aa8f_128.png" />
          </div>
          <div className="user_info">
              <div className="user_infoRow"><span className="user_infoLabel">Location: </span>
                <input ref="city" type="text" defaultValue={ this.state.user.city } />
                <input ref="state" type="text" defaultValue={ this.state.user.state } />
              </div>
              <div className="user_infoRow"><span className="user_infoLabel">Age: </span>
                <input ref="age" type="text" defaultValue={ this.state.user.age } />
              </div>
              <div className="user_infoRow"><span className="user_infoLabel">Pets:  </span>
                <input ref="pets" type="text" defaultValue={ this.state.user.pets } />
              </div>
              <div className="user_infoRow"><span className="user_infoLabel">Volunteer Work:  </span>
                <input ref="volunteer_work" type="text" defaultValue={ this.state.user.volunteer_work } />
              </div>
              <div className="user_infoRow"><span className="user_infoLabel">About me: </span></div>
              <textarea ref="about_me" type="text" cols="60" rows="5" placeholder="Type here" defaultValue={ this.state.user.about_me} />
              <div className="user_infoSubmit"><button onClick={this._handleSave}>Save</button></div>
          </div>

        </div>
      )
      } else {
        return (
          <div>
            <div className="user_wrapper">
              <div className="user_picture">
                <h1> { this.state.user.first_name } { this.state.user.last_name } </h1>
                <img src="http://38.media.tumblr.com/avatar_c44e2933aa8f_128.png" />
              </div>
              <div className="user_info">
                <div className="user_infoRow"><span className="user_infoLabel">Location:  </span>{ this.state.user.city } { this.state.user.state } </div>
                <div className="user_infoRow"><span className="user_infoLabel">Age:  </span> { this.state.user.age }</div>
                <div className="user_infoRow"><span className="user_infoLabel">Pets:  </span>{ this.state.user.pets }</div>
                <div className="user_infoRow"><span className="user_infoLabel">Volunteer Work:  </span> { this.state.user.volunteer_work }</div>
                <div className="user_infoRow"><span className="user_infoLabel">About:  </span></div>{ this.state.user.about_me }
                <div className="user_infoSubmit"><button onClick={ this._handleEdit }>Edit</button></div>
              </div>
            </div>
          </div>
        )
      }
  },
  _handleEdit: function(e){
    e.preventDefault();
    this.setState({ isEditing: true })
  },

  _handleSave: function(e){
    e.preventDefault();
    var data = {
      id: this.state.user.id,
      first_name: this.refs.first_name.getDOMNode().value.trim(),
      last_name: this.refs.last_name.getDOMNode().value.trim(),
      city: this.refs.city.getDOMNode().value.trim(),
      state: this.refs.state.getDOMNode().value.trim(),
      age: this.refs.age.getDOMNode().value.trim(),
      pets: this.refs.pets.getDOMNode().value.trim(),
      volunteer_work: this.refs.volunteer_work.getDOMNode().value.trim(),
      about_me: this.refs.about_me.getDOMNode().value.trim(),
    };
    this.setState({isEditing: false})
    this._updateUser(data);
  },

  _updateUser: function(data) {
    request
      .patch('/users/' + data.id)
      .send(data)
      .set('Accept', 'application/json')
      .set('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
      .end(this._handleChange);
  },

  _handleChange: function(err, res) {
    if (err) { console.log(err.response); return; }
    this._fetchUser();
  },

  _fetchUser: function(){
    request
      .get('/users.json')
      .set('Accept', 'application/json')
      .end(this._handleFetch);
    },

  _handleFetch: function(err, res){
    if (err) {
      console.log(err.response);
      return;
    }
    this.setState({ user: res.body })
  }

});
module.exports = Users;
