import React from "react"

class Search extends React.Component {
  constructor(props){
    super(props)
    this.state = {contributors: []}
  }

  onChangeName(event) {
    this.setState({name : event.target.value})
  }

  searchNameurl() {
    location.href='/contributors/search?name='+this.state.name
  }

  render() {
    return (
      <div className="search-contributor">
        <form className="search-contributor__inner">
          <div className="search-contributor__field">
            <label className="search-contributor__label">
              Search<br />Contributer
            </label>
            <input
              className="search-contributor__input-text"
              type="text"
              value={this.state.name}
              name="name"
              onChange={e => this.onChangeName(e)}
              onKeyPress={e =>
                {
                  if (e.key === 'Enter') {
                    e.preventDefault()
                    this.searchNameurl()
                  }
                }
              }
              placeholder="rosh-1228"
            />
          </div>
          <div className='search-contributor__action'>
            <button
              className='search-contributor__action-submit'
              type="button"
              onClick={() => this.searchNameurl()}
            >
              <i class="fa-sharp fa-solid fa-magnifying-glass"></i>
            </button>
          </div>
        </form>
      </div>
    )
  }
}

export default Search
