React         = require 'react'
{Navigation}  = require 'react-router'

FaqPage = React.createClass
  displayName : 'FaqPage'
  mixins: [Navigation]

  render:->
    <div className='static-page-container'>
      <h1>About Ensemble@Yale</h1>
      <div className='static-page-content'>
        <div className='static-page-right'>
          <div style={{backgroundImage:'url("/assets/cover-7.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-3.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-6.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-4.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-3.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-0.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-2.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-3.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-4.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-5.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-6.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-7.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-8.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-9.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-0.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-2.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-3.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-4.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-5.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-6.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-7.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-8.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-9.jpg")'}}/>
        </div>
        <div className='static-page-left'>
          <div className='large-italic'>We need your help to create a searchable database of Yale theater history by transcribing cast and staff members in historical programs!</div>

          <h2>FAQ</h2>

          <h3>What do you mean by transcribe?</h3>
          <p>For this project, transcription entails 1) identifying people who were involved in a production (cast and staff members) on digitized programs, then 2) typing their name and role exactly as they appear.</p>

          <h3>Who can participate? Do they need an account?</h3>
          <p>Anyone, anytime, from anywhere! Volunteers do not have to create an account to participate, but may choose to do so on Zooniverse. If you sign up for a free account, you’ll be able to see a record of all of your contributions to this and other Zooniverse projects.</p>

          <h3>Why are things organized in six groups on the homepage?</h3>
          <p>Our project has over 900 digitized programs divided into six historical eras to facilitate quick browsing. The Department of Drama era begins when Drama degrees were conferred by the School of Fine Arts, until the School of Drama became a separate professional school in 1955 (starting the Founding Era). Since1966, the Artistic Director of Yale Repertory Theatre and Dean of the School of Drama have been the same person, so the subsequent eras are named for them: Robert Brustein, Lloyd Richards, Stan Wojewodski, and James Bundy. Of course, there are many more theatrical happenings at Yale besides the School of Drama and Yale Repertory Theatre, but this chronological organization fits the programs on the platform. For more on the history of the Yale School of Drama, see <a href='https://www.drama.yale.edu/about-us/'>https://www.drama.yale.edu/about-us/</a>.</p>

          <h3>Where are the original programs?</h3>
          <p>The project currently includes digitized programs from the <a href='https://archives.yale.edu/repositories/5/resources/447'>Yale Repertory Theatre and Yale School of Drama Ephemera Collection</a> housed in Yale’s <a href='https://web.library.yale.edu/arts/special-collections'>Arts Library Special Collections</a>.</p>

          <h3>Is there a way to know how much I’ve transcribed for Ensemble@Yale?</h3>
          <p>While you can’t find the exact number of transcriptions you’ve completed, you can see the total number of programs you’ve worked on! To do this, you must register for a free account on <a href='https://www.zooniverse.org/'>Zooniverse</a> and transcribe for our project while logged in. Afterward, to see your contributions, go to <a href='https://www.zooniverse.org/projects/haasarts/ensemble-at-yale/recents'>Ensemble@Yale’s Recents</a> page.</p>

          <h3>Where is the finished data?</h3>
          <p>Data created by our volunteer transcribers is being collected and processed by the Ensemble@Yale team. It is currently not available to the public, but we plan to make it accessible once all transcriptions are complete.</p>

          <h3>What do you plan to do with the data?</h3>
          <p>The Ensemble@Yale team will add programs to Yale Library’s Digital Collections, where they will be searchable using the metadata created from this project. We also hope to make the Ensemble@Yale data available to interested researchers.</p>

          <h3>What will happen to these sites after all programs are transcribed?</h3>
          <p>Once the Zooniverse transcription project is complete, it will be retired. Ensemble.yale.edu will become an access point for the data generated from the project for theater enthusiasts to explore.</p>

          <h2>Other Questions?</h2>
          <p>Do you have more questions about Ensemble@Yale? Message us on the <a href='https://www.zooniverse.org/projects/haasarts/ensemble-at-yale/talk'>Talk board</a> or contact the <a href='mailto:dhlab@yale.edu?subject=Ensemble%20questions'>Digital Humanities Laboratory</a> at Yale University Library.</p>

          <p>Questions about theater history at Yale? See <a href='https://guides.library.yale.edu/c.php?g=296165&p=1975017'>this guide</a> or contact the <a href='https://web.library.yale.edu/arts'>Robert B. Haas Family Arts Library</a>.</p>

        </div>
      </div>
    </div>

module.exports = FaqPage