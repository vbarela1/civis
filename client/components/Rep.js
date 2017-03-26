import React from 'react';
import { connect } from 'react-redux';

// Components
import RepContact from './RepContact';
import RepInfo from './RepInfo';
import RepHeader from './RepHeader';
import Articles from './Articles';

// TODO: Redirect to home on refresh if no current session
class Rep extends React.Component {
  state = { loading: true }

  componentDidMount = () => {
    if (this.props.rep)
      this.setState({ loading: false });
  }

  componentDidUpdate = () => {
    if (this.state.loading && this.props.rep)
      this.setState({ loading: false });
  }

  displayRep = () => {
    let { rep } = this.props;
    return (
      <div>
        <RepHeader
          profile_large_url={rep.profile_large_url}
          first_name={rep.first_name}
          last_name={rep.last_name}
        />
        <div className="row">
          <div className="col s12 l4">
            <RepInfo
              party={rep.party}
              title={rep.title}
              state={rep.state}
              next_election={rep.next_election}
            />
            <RepContact
              phone={rep.phone}
              twitter_account={rep.twitter_account}
              url={rep.url}
            />
          </div>
          <div className="col s12 l8">
            <Articles
              fullName={rep.full_name}
              articles={rep.articles}
            />
          </div>
        </div>
      </div>
    );
  }

  render = () => {
    if ( this.state.loading )
      return( <p>Loading</p> );
    else
      return ( this.displayRep() );
  }
}

const mapStateToProps = (state, props) => {
  return { rep: state.reps.find( r => r.id == props.params.id ) }
}

export default connect(mapStateToProps)(Rep);
