import React from 'react'
import Modal from 'react-modal'

const customStyles = {
  content : {
    top                   : '40%',
    left                  : '40%',
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
      <div className='content'>
        <button onClick={this.openModal} className='level-item_button'>About</button>
        <Modal
          isOpen={this.state.modalIsOpen}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel='Modal'
        >
          <div className='modal_description-about-site'>
            <button className='delete' onClick={this.closeModal}></button>
            <h2 className='modal_this_site_title' ref={subtitle => this.subtitle = subtitle}>フィヨルドブートキャンプ生のコミットランキングサイト</h2>
            <p className='modal_sentence'>fjord boot camp contributorは、フィヨルドブートキャンプで行うチーム開発プラクティス(正式には、開発に参加してPRを送りマージする)にて、<a href='https://github.com/fjordllc/bootcamp'>リポジトリ</a>に所属するContributorのcommit数を集計し、ランキングを表示するサイトです。</p>
            <h3 className='modal_sub-title'>このサイトの使い方</h3>
            <ul>
              <li className='modal_sentence'>就職活動にて、企業様に自身がフィヨルドブートキャンプのチーム開発で書いたコード一覧を提出できます。</li>
              <li className='modal_sentence'>フィヨルドブートキャンプ内で他の人がどのようなコミットを行ったか、どのくらいのコミット(貢献)を行ったがわかります。</li>
            </ul>
            <h3 className='modal_sub-title'>ランキング更新タイミング</h3>
            <p className='modal_sentence'>毎日 0時 6時 12時 18時 の4回、ランキングを更新します。</p>
            <h3 className='modal_sub-title'>操作について</h3>
            <p className='modal_sentence'>各Contributorのnameをクリックすると、そのContributorが実施したコミット一覧を表示します。</p>
            <p className='modal_sentence'>検索ボックスにContributorのnameを入力することで、Contirbutorの検索もできます。</p>
            <h3 className='modal_sub-title'>作者について</h3>
            <p className='modal_author-name'>rosh-1228</p>
            <ul className='modal_outer_links'>
              <li className='modal_outer_link'><a href='https://github.com/rosh-1228/fjord-boot-camp-contributors'><img src='/assets/GitHub-Mark-120px-plus.png' width="30" height="30" /></a></li>
              <li className='modal_outer_link'><a href='https://twitter.com/rosh_1228'><img src='/assets/Twittersocialicons.png' width="30" height="30" /></a></li>
              <li className='modal_outer_link'><a href='https://rosh-1228.hatenablog.com/'><img src='/assets/hatenablog-logo.svg' width="30" height="30" /></a></li>
            </ul>
          </div>
        </Modal>
      </div>
    )
  }
}

export default Description
