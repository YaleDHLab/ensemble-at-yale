React         = require("react")
{Navigation}  = require 'react-router'

AboutPage = React.createClass
  displayName : "AboutPage"
  mixins: [Navigation]

  render:->
    <div className="about-page">
      <div id="about-page"> 
        <h2 className="about-the-archive">About the Archive</h2>
        <div className="about-page-container">
          <div className="about-left-container">
            <div className="about-left">
              <h2>Ensemble at Yale</h2>
              <p>
                Ensemble@Yale, inspired by the original <a href="http://ensemble.nypl.org">Ensemble</a> project from NYPL Labs, is an experiment that aims to transform historic programs from Yale’s archives into searchable text through crowdsourced transcription. Rather than reproducing all of the words in a digitized document, as with optical character recognition (OCR), crowdsourced transcription relies on human judgment to pull out features of interest to scholars and create structured data.
              </p>
              <p>
                Ensemble@Yale is based on the <a href="http://scribeproject.github.io/">Scribe Project</a> from <a href="labs.nypl.org">NYPL Labs</a> and <a href="https://www.zooniverse.org/">Zooniverse</a>. The tool asks its users to mark important parts of digitized performance programs, transcribe the text, identify important relationships or characteristics, and verify the work of other users to make the collected data more robust. 
              </p>

              <p>
                The <a href="http://drama.yale.edu/">Yale School of Drama</a> is internationally recognized as a leading training program, and its professional company, <a href="yalerep.org">Yale Repertory Theatre</a>, has premiered numerous plays that have gone on to successful productions in New York and elsewhere. The long list of renowned alumni attests to high research interest in records of their careers at Yale. Yale University Library’s archives of theatrical productions on campus, dating back to 1925, are housed in several separate special collections units. The vast majority of these records exist solely in print and often lack intuitive access points for researchers.
              </p>

              <h2 className="contact-us">Contact Us</h2>
              <p>
                Questions about Ensemble@Yale? Contact the DHLab: dhlab@yale.edu.
                Questions about theater history at Yale? Start with an <a href="http://guides.library.yale.edu/c.php?g=296165&p=1975017">introductory research guide</a> or contact the Arts librarian for theater and drama: lindsay.king@yale.edu.
              </p>
            </div>
          </div>

          <div className="about-right-container">
            <div className="about-page-image haas-art-library"></div>

            <div className="about-page-right-text">
              <h2>Sponsors</h2>
              <p>
              Ensemble@Yale is a project of the <a href="http://web.library.yale.edu/dhlab">Digital Humanities Laboratory</a> at Yale University Library, with support from the <a href="http://web.library.yale.edu/arts">Robert B. Haas Family Arts Library</a> and the <a href="http://yalerep.org">Yale Repertory Theatre</a>.
              </p>
            </div>
            <div className="about-page-image yale-repertory-theatre"></div>
          </div>
          <div className="clear-both"/>
        </div>
      </div>
    </div>

module.exports = AboutPage