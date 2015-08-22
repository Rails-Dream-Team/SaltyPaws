var React = require('react');
var request = require('superagent')

var Users = React.createClass ({
  getInitialState: function(){
    return {
      user: []
    };
  },

  componentWillMount: function(){
    this._fetchUser();
  },

  render: function(){
    return (
      <div>
        <h1>It worked</h1>
      </div>
    )
  },

  _fetchUser: function(){
    request
      .get('/user')
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
