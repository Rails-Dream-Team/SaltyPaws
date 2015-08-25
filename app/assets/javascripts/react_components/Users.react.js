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
    if (this.state.user.avatar) {
      var url = this.state.user.avatar.url
    } else {
      var url = null
    }
    if (this.state.isEditing) {
      return (
        <div className="user_wrapper">
          <form onSubmit={ this._handleSave }>
            <div className="user_name">
              <h1> { this.state.user.first_name } { this.state.user.last_name } </h1>
            </div>
            <div className="user_picture">
                <img src={ url } />
                <input type="file" id="avatar" name="user[avatar]" />
            </div>
            <div className="user_info">
              <div className="user_infoRow"><span className="user_infoLabel">Location: </span>
                <input type="text" placeholder="city" name="user[city]" id="city" defaultValue={ this.state.user.city } />
                <input type="text" placeholder="state" name="user[state]" id="state" defaultValue={ this.state.user.state } />
              </div>
              <div className="user_infoRow"><span className="user_infoLabel">Age: </span>
                <input type="text" placeholder="age" name="user[age]" id="age" defaultValue={ this.state.user.age } />
              </div>
              <div className="user_infoRow"><span className="user_infoLabel">Pets:  </span>
                <input type="text" placeholder="pets" name="user[pets]" id="pets" defaultValue={ this.state.user.pets } />
              </div>
              <div className="user_infoRow"><span className="user_infoLabel">Volunteer Work:  </span>
                <input type="text" placeholder="volunteer work" name="user[volunteer_work]" id="volunteer_work" defaultValue={ this.state.user.volunteer_work } />
              </div>
              <div className="user_infoRow"><span className="user_infoLabel">About me: </span></div>
              <textarea type="text" cols="60" rows="5" placeholder="Type here" name="user[about_me]" id="about_me" defaultValue={ this.state.user.about_me} />
            </div>
            <div className="user_infoSubmit"><button>Save</button></div>
          </form>
        </div>
      )
      } else {
        if (this.state.user.avatar) {
          var url = this.state.user.avatar.url
        } else {
          var url = null
        }
        return (
          <div>
            <div className="user_wrapper">
              <div className="user_name">
                <h1> { this.state.user.first_name } { this.state.user.last_name } </h1>
              </div>
              <div className="user_picture">
                <img src={ url } />
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
    this.setState({ isEditing: true });
  },

  _handleSave: function(e){
    e.preventDefault();
    var fd = new FormData(e.target);
    console.log(fd);
    request
      .patch('/users/' + this.state.user.id)
      .send(fd)
      .set('Accept', 'application/json')
      .set('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
      .end(this._handleChange);
  },

  _handleChange: function(err, res) {
    if (err) { console.log(err.response); return; }
    this.setState({ isEditing: false });
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
