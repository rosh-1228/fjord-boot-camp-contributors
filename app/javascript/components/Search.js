import React, { Component }  from "react"
import PropTypes from "prop-types"
class Search extends React.Component {
  constructor(props){
    super(props)
    this.state = {initialContributors: this.props.ranks, ranks:[]}
  }

  //ブラウザロード時の処理。
  //最初はタスク全部を表示しておく
  componentDidMount() { 
    this.setState({ranks: this.state.initialContributors})
  }

  //検索のメソッドをここで用意しておく
  searchByName(name) { 
    const result = this.state.initialContributors.filter((contributor) => {
      return contributor.name.toLowerCase().search( name.toLowerCase()) !== -1;
    })
    this.setState({ranks: result})
  }

  /* 
    ページ全体のrenderメソッド。
    大事なのは、FilterFormのprops（search）に、上記で定義したsearchByNameを定義しておくこと。
    これにより、Taskコンポーネントのstateにあるtasksを変更することができる。
    そして、変更したtasksを、ContributorListコンポーネントにpropsで渡してあげることで、
    絞り込み後のタスク一覧を表示することができる。
  */
  render() {
    return (
      <div>
        <FilterForm search={(name) => this.searchByName(name)} />
        <ContributorList ranks={this.state.ranks} />
      </div>
    )
  }
}

//検索フォームのコンポーネント
class FilterForm extends Component{

  //コンストラクタ。ここでは、検索値nameをstateとして持っておく
  constructor(props){
    super(props)
    this.state = {name: ''}
  }

  //検索のテキストボックスの中身が変更された時の処理。
  //stateに検索値を挿入しておく
  onChangeName(event) {
    this.setState({name : event.target.value})
  }

  //検索ボタンをクリックされた時の処理。
  //上記で書いた通り、 Taskのコンポーネントで渡されたsearchメソッドを実行することにより、
  //Taskコンポーネントのstateに、絞り込み後のタスク一覧を表示することができる
  onClickSearch() {
    this.props.search(this.state.name)
  }

  //検索フォームのrenderメソッド。
  render() {
    return (
      <div className="entry">
        <fieldset>
          <div> <input type="text" value={this.state.name} name="name" onChange={(e) => this.onChangeName(e)} placeholder="ユーザー名を入力して検索" /> </div>
          <div> <input type="submit" value="検索" onClick={(e) => this.onClickSearch(e)} /> </div>
        </fieldset>
      </div>
    )
  }
}

//タスク一覧についてのコンポーネント。
//こちらは上2つのクラスコンポーネントとは違い、関数コンポーネントになっている。
//クラスコンポーネントとは違い、できることが限られているため、シンプルな表示だけしたいときに使う。
const ContributorList = (props) => { 
  //タスク一覧を表示する。
  //繰り返し処理にはmap関数を使用。
  return (
    <div>
      <table className="contributor">
        <thead  data-type="ok">
          <tr><th>  </th><th>Avatar</th><th>Name</th><th>Commits</th></tr>
        </thead>
        <tbody>
          {props.ranks.map((contributor) =>
            < ContributorInfo contributor={contributor} key={contributor.id} /> )}
        </tbody>
      </table>
    </div>
  )
}
//ContributorListコンポーネントが受け取るpropsを定義。
//ここではタスク一覧を受け取ることができるように定義しておく。
ContributorList.propTypes = {
  ranks: PropTypes.array.isRequired
}

//タスクの1つの行を表すコンポーネント。
//上と同様関数コンポーネント。
const  ContributorInfo = (props) => {
  //受け取ったタスクのオブジェクトの値を、それぞれ行のセルに挿入
  const {rank, avatar_url, path, name, commits} = props.contributor
  return (
    <tr>
      <td>#{rank}</td>
      <td><img src={avatar_url} width="30" height="30" /></td>
      <td><a href={path}>  {name}  </a></td>
      <td>{commits}</td>
    </tr>
  )
}
// ContributorInfoコンポーネントが受け取るpropsを定義。
//ここではタスクオブジェクト。
 ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default Search
