var React = require('react')
var Timestamp = require('react-time');

var Form = React.createClass ({
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
            <h3> { this.props.user.first_name } { this.props.user.last_name } </h3>
          </div>
          <form onSubmit={ this.props.handleSave }>
            <div className="user__left">
              <div className="user__picture">
                <img src={ url } />
                <input type="file" id="avatar" name="user[avatar]" />
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
                  <div className="user_infoRow"><span className="user_infoLabel">City: </span>
                    <input type="text" placeholder="city" name="user[city]" id="city" defaultValue={ this.props.user.city } />
                  </div>
                  <div className="user_infoRow"><span className="user_infoLabel">State: </span>
                    <input type="text" placeholder="state" name="user[state]" id="state" defaultValue={ this.props.user.state } />
                  </div>
                  <div className="user_infoRow"><span className="user_infoLabel">Age: </span>
                    <input type="text" placeholder="age" name="user[age]" id="age" defaultValue={ this.props.user.age } />
                  </div>
                  <div className="user_infoRow"><span className="user_infoLabel">Pets:  </span>
                    <input type="text" placeholder="pets" name="user[pets]" id="pets" defaultValue={ this.props.user.pets } />
                  </div>
                  <div className="user_infoRow"><span className="user_infoLabel">Volunteer Work:  </span>
                    <input type="text" placeholder="volunteer work" name="user[volunteer_work]" id="volunteer_work" defaultValue={ this.props.user.volunteer_work } />
                  </div>
                  <div className="user_infoRow"><span className="user_infoLabel">About: </span></div>
                  <textarea type="text" cols="60" rows="5" placeholder="Type here" name="user[about_me]" id="about_me" defaultValue={ this.props.user.about_me} />
                  <div className="user_infoSubmit"><button>Save</button></div>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    )
  }
});

module.exports = Form;
