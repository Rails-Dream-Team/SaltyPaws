var React = require('react');
var superagent = require('superagent')


var Show = React.createClass ({
  render: function(){
    return (
      <div>
        <div class="user_wrapper">
          <div class="user_picture">
            <h1> { this.props.user.data.first_name } { this.props.user.last_name } </h1>
            <img src="http://38.media.tumblr.com/avatar_c44e2933aa8f_128.png" />
          </div>
          <div class="user_info">
              <div><h4>Location:</h4> { this.props.user.city } { this.props.user.state }</div>
          </div>
        </div>
      </div>
    )
  }
});

module.export = Show;
