var React = require('react')
var Timestamp = require('react-time');

var Show = React.createClass ({
  render: function(){
    if (this.props.user.avatar) {
      var url = this.props.user.avatar.url
    } else {
      var url = null
    }
    return (
      <div className="user__pageWrapper">
        <div className="user__profileWrapper">
          <div className="user__name">
            <h3>{ this.props.user.first_name } { this.props.user.last_name }</h3>
          </div>
          <div className="user__left">
            <div className="user__picture">
              <img src={ url } />
            </div>
            <div className="user__membersince">
              <h4>Member since: <Timestamp value={ this.props.user.created_at } format="MM/DD/YYYY" /></h4>
            </div>
            <div className="user__work">
              <div className="user__workHeader">
                <h4>Organizations</h4>
              </div>
              <div className="user__workContent">
                <ul>{this.props.organizations}</ul>
              </div>
            </div>
          </div>
          <div className="user__right">
            <div className="user__info">
              <div className="user__infoHeader"><h4>About me</h4></div>
              <div className="user__infoContent">
                <div className="user_infoRow"><span className="user_infoLabel">Location:  </span>{ this.props.user.city } { this.props.user.state } </div>
                <div className="user_infoRow"><span className="user_infoLabel">Age:  </span> { this.props.user.age }</div>
                <div className="user_infoRow"><span className="user_infoLabel">Pets:  </span>{ this.props.user.pets }</div>
                <div className="user_infoRow"><span className="user_infoLabel">Volunteer Work:  </span> { this.props.user.volunteer_work }</div>
                <div className="user_infoRow"><span className="user_infoLabel">About:  </span>{ this.props.user.about_me }</div>
                {this.props.editButton}
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
});

module.exports = Show;
