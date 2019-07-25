React         = require 'react'
{Navigation}  = require 'react-router'

AboutPage = React.createClass
  displayName : 'FaqPage'
  mixins: [Navigation]

  render:->
    <div className='static-page-container'>
      <h1>About Ensemble@Yale</h1>
      <div className='static-page-content'>
        <div className='static-page-right'>
          <div style={{backgroundImage:'url("/assets/cover-8.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-0.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-9.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-5.jpg")'}}/>
          <div style={{backgroundImage:'url("/assets/cover-7.jpg")'}}/>
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

          <h2>The Project</h2>
          <p>What is the most-produced play at Yale? Who starred with Lupita Nyong'o, Meryl Streep, and Paul Giamatti when they were students? Ensemble@Yale is an experiment that aims to answer these questions and more by transforming historical theater programs from Yale’s archives into searchable text through crowdsourced transcription. Rather than reproducing all of the words in a digitized document, as with optical character recognition (OCR), crowdsourced transcription relies on human judgment to create structured data and identify features of interest to scholars and theater enthusiasts.</p>
          <p>Inspired by the original <a href='http://ensemble.nypl.org/'>Ensemble</a> project from NYPL Labs, Ensemble@Yale was initially based on the <a href='http://scribeproject.github.io/'>Scribe Project</a> from <a href='https://www.nypl.org/collections/labs'>NYPL Labs</a> and <a href='https://www.zooniverse.org/'>Zooniverse</a>. Ensemble@Yale switched platforms in summer 2019 from Scribe to Zooniverse’s <a href='https://www.zooniverse.org/projects'>Project Builder</a>, streamlining workflows to focus on  cast and staff and give volunteers a way to track their contributions. This site provides the opportunity to browse programs from throughout Yale’s theater history, and links out to our <a href='https://www.zooniverse.org/projects/haasarts/ensemble-at-yale'>Zooniverse project</a> where you and other volunteers can help transcribe the era we are working on.</p>

          <h2>The Programs</h2>
          <p>Internationally recognized as a leading training program, the <a href='http://drama.yale.edu/'>Yale School of Drama</a> is and its professional company, <a href='https://www.yalerep.org/'>Yale Repertory Theatre</a>, has premiered numerous plays that have gone on to successful productions in New York and elsewhere. The long list of renowned alumni has garnered  significant research interest in the archival records of their careers at Yale; however the materiality of these records makes them difficult to comprehensively search. Yale University Library’s archives of productions on campus, dating back to 1925, are housed in several separate special collections units. The vast majority of these records exist solely in print and often lack intuitive access for researchers. Ensemble@Yale will provide new entry points into the collection emphasizing the people behind the productions.</p>
          <p>To facilitate quick browsing, the programs on this site are organized into six historical eras that are important to Yale’s theater history  (for more details, see the FAQ). On Zooniverse, only one era of programs is available for transcribing at a time. Once that era is complete, we will move to the next chronologically.</p>

          <h2>How You Can Get Involved</h2>
          <p>We can’t unlock Yale’s theater history without your help! Transcribing for this project entails identifying people involved in a production (cast or staff members depending on the task) and then typing exactly what you see. Anyone can pitch in from anywhere by clicking transcribe on our site, which leads to our Zooniverse project. Once there, you will see a tutorial teaching you how to <a href='https://www.zooniverse.org/projects/haasarts/ensemble-at-yale/classify'>transcribe</a> from our digitized historical programs.</p>
          <p>We have a talk board if you find anything you want to share or have program-specific questions for us! If you’re local to New Haven, we also have a series of events that are free and open to the public. More information is available on the <a href='http://dhlab.yale.edu/events.html'>DHLab events calendar</a> and <a href='https://www.facebook.com/YaleHaasArtsLib/'>Haas Arts Library Facebook</a>, or you can <a href='mailto:arts.library@yale.edu?subject=Subscribe%20for%20Ensemble@Yale%20updates!'>sign up for our mailing list</a> to receive updates.</p>

          <h2>Sponsors</h2>
          <p>Ensemble@Yale is a project of the <a href='http://dhlab.yale.edu/'>Digital Humanities Laboratory</a> and the <a href='https://web.library.yale.edu/arts'>Robert B. Haas Family Arts Library</a> at Yale University Library, with support from the <a href='https://www.yalerep.org/'>Yale Repertory Theatre</a>.</p>

          <h2>Questions</h2>
          <p>Do you have questions about Ensemble@Yale? Check out our FAQ page, message us on the <a href='https://www.zooniverse.org/projects/haasarts/ensemble-at-yale/talk'>Talk board</a>, or contact the <a href='mailto:dhlab@yale.edu?subject=Ensemble%20questions'>Digital Humanities Laboratory</a> at Yale University Library.</p>

          <p>Questions about theater history at Yale? See <a href='https://guides.library.yale.edu/c.php?g=296165&p=1975017'>this guide</a> or contact the <a href='https://web.library.yale.edu/arts'>Robert B. Haas Family Arts Library</a>.</p>

        </div>
      </div>
    </div>

module.exports = AboutPage