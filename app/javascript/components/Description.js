import React from 'react'
import Modal from 'react-modal'

const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : 'auto',
    transform             : 'translate(-50%, -50%)'
  }
}

class Description extends React.Component {
  constructor() {
    super();
    this.state = {
      modalIsOpen: false
    }

    this.openModal = this.openModal.bind(this)
    this.closeModal = this.closeModal.bind(this)
  }

  openModal() {
    this.setState({modalIsOpen: true})
  }

  closeModal() {
    this.setState({modalIsOpen: false})
  }

  render() {
    return (
      <div>
        <button onClick={this.openModal} className='level-item_button'>About</button>
        <Modal
          isOpen={this.state.modalIsOpen}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Example Modal"
        >
          <button onClick={this.closeModal}>×</button>
          <h2 ref={subtitle => this.subtitle = subtitle}>フィヨルドブートキャンプ生のコミットランキングサイト</h2>
          <p>fjord boot camp contributorは、フィヨルドブートキャンプで行うチーム開発プラクティス(正式には、開発に参加してPRを送りマージする)にて、<a href='https://github.com/fjordllc/bootcamp'>リポジトリ</a>に所属するContributorのcommit数を集計し、ランキングを表示するサイトです。</p>
          <h3>このサイトの使い方</h3>
          <ul>
            <li>就職活動にて、企業様に自身がフィヨルドブートキャンプのチーム開発で書いたコード一覧を提出できます。</li>
            <li>フィヨルドブートキャンプ内で他の人がどのようなコミットを行ったか、どのくらいのコミット(貢献)を行ったがわかります。</li>
          </ul>
          <h3>ランキング更新タイミング</h3>
          <p>毎日 0時 6時 12時 18時 の4回、ランキングを更新します。</p>
          <h3>操作について</h3>
          <p>各Contributorのnameをクリックすると、そのContributorが実施したコミット一覧を表示します。</p>
          <p>検索ボックスにContributorのnameを入力することで、Contirbutorの検索もできます。</p>
          <h3>作者について</h3>
          <ul>
            <li>rosh-1228</li>
            <li><a href='https://github.com/rosh-1228/fjord-boot-camp-contributors'><img src='/assets/GitHub-Mark-120px-plus.png' width="30" height="30" /></a></li>
            <li><a href='https://twitter.com/rosh_1228'><img src='/assets/Twittersocialicons.png' width="30" height="30" /></a></li>
            <li><a href='https://rosh-1228.hatenablog.com/'><img src='/assets/hatenablog-logo.svg' width="30" height="30" /></a></li>
          </ul>
        </Modal>
      </div>
    )
  }
}

export default Description
