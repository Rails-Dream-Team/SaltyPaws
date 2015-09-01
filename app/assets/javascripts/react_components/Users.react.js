var React = require('react');
var request = require('superagent');
var Timestamp = require('react-time');
var Show = require('./user_components/Show.react.js')
var Form = require('./user_components/Form.react.js')

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
    var editButton
    if (this.state.user.edit === true) {
      editButton = (<div className="user_infoSubmit"><button onClick={ this._handleEdit }>Edit</button></div>);
    }
    var organizations
    if (this.state.user.organizations != undefined) {
      organizations = this._listOrganizations();
    }
    if (this.state.user.avatar) {
      var url = this.state.user.avatar.url
    } else {
      var url = null
    }
    if (this.state.isEditing) {
      return (
        <Form user={ this.state.user } organizations={ organizations } handleSave={ this._handleSave } />
      )
      } else {
        return (
          <Show user={ this.state.user } editButton={ editButton } organizations={ organizations } />
        )
      }
  },

  _listOrganizations: function() {
    console.log(this.state.user.organizations)
    if (this.state.user.organizations.length === 0 ) {
      return <li><a href="/organizations">Join organizations right meow</a></li>
    } else {
      return this.state.user.organizations.map(function(org){
        return <li><a href={"/organizations/" + org.id}>{org.name}</a></li>
      });
    }
  },

  _handleEdit: function(e) {
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
    var path = window.location.pathname.split('/');
    var id = path[2];
    request
      .get('/users/' + id)
      .set('Accept', 'application/json')
      .end(this._handleFetch);
    },

  _handleFetch: function(err, res){
    if (err) {
      console.log(err.response);
      window.location.href = "/404"
      return;
    }
    this.setState({ user: res.body })
  }

});

module.exports = Users;
