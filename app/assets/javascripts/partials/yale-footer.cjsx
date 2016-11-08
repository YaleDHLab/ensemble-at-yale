React                   = require 'react'

Footer = React.createClass
  displayName: 'Footer'

  render: ->
    <div>
    { if @props.display == 1
        <div className="footer-container">
          <div className="footer-left">
            <img src={'/assets/dh-wordmark-white.png'} />
          </div>

          <div className="footer-right-container">
            <div className="footer-right">
              <svg viewBox="-384 -54.707 230.51 78.907" className="scribe-logo">
                <g id="group-188" transform="translate(-384.01 -54.71)">
                  <rect id="rectangle" className="cls-1" width="100" height="40" transform="translate(70.08 7.52)" />
                  <rect id="rectangle-2" dataName="rectangle" className="cls-2" width="100.75" height="39" transform="translate(63.7 9.83)" />
                  <path id="path" d="M432.27,209.38a14.17,14.17,0,0,1,8.41,2.62v2.48h-.09a13.33,13.33,0,0,0-8.41-3c-3.72,0-6.89,2.34-6.89,5.93,0,3.35,2.71,5,7.85,7.44,5.47,2.57,8.77,4.92,8.77,9.37,0,5.14-4.59,8.45-9.65,8.45a14.81,14.81,0,0,1-9.74-3.68l-.64-3.17h.09a14.78,14.78,0,0,0,10.38,4.82c3.67,0,7.35-2.34,7.35-6.2,0-3.4-2.76-5.28-7.95-7.67s-8.68-4.59-8.68-9.14C423.09,212.64,427.17,209.38,432.27,209.38Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-2" dataName="path" d="M446.6,226.05A16.5,16.5,0,0,1,463,209.38,16,16,0,0,1,474.34,214v2.71h-.09a15.64,15.64,0,0,0-11.39-5.28c-7.39,0-14,6.43-14,14.51,0,8.82,6.8,14.61,13.73,14.61a16.48,16.48,0,0,0,12.08-5.6h.09l-.41,2.8a16.79,16.79,0,0,1-11.9,4.82C454.27,242.64,446.6,236.11,446.6,226.05Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-3" dataName="path" d="M489.91,228.31h-5.37v13.78h-2.2V209.93h8.31c5.65,0,10.15,3.08,10.15,9,0,4.78-3.72,8.22-8.41,9l12.86,14.06H502.4Zm-5.42-2h5.83c4.32,0,8.27-2.89,8.27-7.3s-3.45-7-8-7h-6.06Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-4" dataName="path" className="cls-1" d="M350,212.73v9.54h-1.44V211.19h2.26l4.27,8.51,4.25-8.51h2.31v11.07h-1.49v-9.62l-5,9.79h-.24Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-5" dataName="path" className="cls-1" d="M372.33,219.42h-5.79l-1.28,2.85h-1.58l5.16-11.13h1.41l5,11.13h-1.64Zm-2.85-6.55-2.34,5.2h4.6Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-6" dataName="path" className="cls-1" d="M377.29,211.19h3.65c3.8,0,6.26,2.1,6.26,5.5s-2.67,5.57-6.26,5.57h-3.65Zm1.53,1.39v8.29H381c2.63,0,4.67-1.57,4.67-4.14s-1.95-4.14-4.73-4.14Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-7" dataName="path" className="cls-1" d="M389.68,211.19h6.23l.46,1.38h-5.16V216h4.32v1.36h-4.32v3.58h5.2l-.46,1.38h-6.28Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-8" dataName="path" className="cls-1" d="M347.53,230.18h1.66l3,9.14,4-9.27h.27l3.86,9.27,3.1-9.14H365l-4,11.13h-1.49l-3.29-8.05-3.42,8.05h-1.47Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-9" dataName="path" className="cls-1" d="M368,230.18h1.53v11.07H368Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-10" dataName="path" className="cls-1" d="M378.4,231.56v9.69h-1.52v-9.69h-4.33v-1.38h10.2v1.38Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-11" dataName="path" className="cls-1" d="M393.89,236.31h-6.67v5h-1.53V230.18h1.53v4.71h6.67v-4.71h1.52v11.07h-1.52Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-12" dataName="path" className="cls-3" d="M531.38,242.3V210.15h8.68c5.65,0,9.42,3.08,9.42,8.18a7.68,7.68,0,0,1-5.33,7.3c4.27,1,7,4,7,7.9,0,5.28-4.32,8.77-10.61,8.77Zm2.16-17.36h6.2c4.27,0,7.53-2.57,7.53-6.48s-2.89-6.34-7.35-6.34h-6.38Zm7,15.39c5.14,0,8.36-2.8,8.36-6.8s-3.77-6.66-8.22-6.66h-7.17v13.46Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-13" dataName="path" className="cls-3" d="M558.43,210.15h17.18l.83,2h-15.8v12.77h13.55v2H560.63v13.32h15.94l-.83,2H558.43Z" transform="translate(-346.05 -198.67)" />
                  <line id="line" className="cls-4" y2="42" transform="translate(170.95 6.33)" />
                  <line id="line-2" dataName="line" className="cls-4" x2="10" transform="translate(165.95 28.33)" />
                  <line id="line-3" dataName="line" className="cls-4" y1="6.12" x2="6.12" transform="translate(170.89 0.71)" />
                  <line id="line-4" dataName="line" className="cls-4" x1="6.12" y1="6.12" transform="translate(164.89 0.71)" />
                  <line id="line-5" dataName="line" className="cls-4" x2="6.12" y2="6.12" transform="translate(170.89 47.71)" />
                  <line id="line-6" dataName="line" className="cls-4" x1="6.12" y2="6.12" transform="translate(164.89 47.71)" />
                  <path id="path-14" dataName="path" className="cls-1" d="M351.32,273.54h-5.26l.06-.37a2.27,2.27,0,0,0,1.59-.56l1.75-8.25c-.08-.32-.91-.54-1.62-.57l.08-.35c1.88-.08,3.15-.18,4.55-.18,3.26,0,5,1.67,5,4.21a6,6,0,0,1-6.15,6.07Zm.37-9.76H351l-1.86,8.75a4.23,4.23,0,0,0,2,.49c3.2,0,4.71-2.37,4.71-5.28.01-2.57-1.51-3.97-4.17-3.97Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-15" dataName="path" className="cls-1" d="M362.81,271.85a4.39,4.39,0,0,1-2.8,1.84c-.87,0-1.81-1-1.81-2.77a4.16,4.16,0,0,1,1-2.56,4.63,4.63,0,0,1,2.8-1.83c.91,0,1.81,1,1.81,2.77a4.09,4.09,0,0,1-1,2.55Zm-1.48-4.64c-.67,0-1.89,1.4-1.89,3.58,0,1.53.57,2.26,1.22,2.26s1.88-1.43,1.88-3.66C362.54,268,362,267.21,361.33,267.21Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-16" dataName="path" className="cls-1" d="M369,268.24a2.25,2.25,0,0,0-1.64-.92,4.49,4.49,0,0,0-1.37,3.37c0,1.62.51,2.18,1.13,2.18s1.18-.52,1.92-1.34l.25.25a4.51,4.51,0,0,1-2.91,1.89c-1,0-1.67-1-1.67-2.46a5.13,5.13,0,0,1,1.3-3.28,3.45,3.45,0,0,1,2.5-1.37c.86,0,1.29.48,1.29.81S369.28,268.1,369,268.24Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-17" dataName="path" className="cls-1" d="M377.7,271.72c-.92,1.11-1.77,1.92-2.59,1.92-.35,0-.48-.49-.48-1a20.521,20.521,0,0,1,.51-2.27c-1.4,1.8-2.88,3.32-3.74,3.32-.27,0-.68-.6-.68-1.08a5.851,5.851,0,0,1,.24-1.22l.76-2.91c.08-.29.22-.87.22-.94v-.21a5.871,5.871,0,0,0-1.3,1.35l-.3-.21c.89-1.27,1.57-1.89,2.31-1.89.35,0,.49.45.49,1a2.468,2.468,0,0,1-.06.48c-.43,1.69-.91,3.5-1,4.15,0,.43.1.6.27.6.33,0,1.69-1.43,2.94-3l.64-3h1.19l-1.11,5.1a2.912,2.912,0,0,0-.08.56c0,.24,0,.41.21.41s.75-.57,1.35-1.29Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-18" dataName="path" className="cls-1" d="M389.42,271.72c-.92,1.11-1.77,1.92-2.59,1.92-.35,0-.46-.49-.46-1a7.941,7.941,0,0,1,.25-1.26s.67-2.61.78-3.26c0-.48-.1-.59-.27-.59a17.466,17.466,0,0,0-2.86,2.94l-.72,3.09h-1.16s1.08-4.79,1.19-5.44c0-.49-.1-.59-.27-.59-.33,0-1.62,1.42-2.88,2.94l-.6,3.09h-1.18l1-5.14a6.937,6.937,0,0,1,.21-.94v-.16a5.871,5.871,0,0,0-1.3,1.35l-.3-.21c.89-1.27,1.56-1.89,2.29-1.89.35,0,.51.45.51.94a2.231,2.231,0,0,1-.08.54l-.4,1.72c1.4-1.7,2.75-3.2,3.61-3.2.27,0,.68.6.68,1.08a5.861,5.861,0,0,1-.24,1.22l-.22.89c1.4-1.7,2.72-3.2,3.58-3.2.27,0,.68.6.68,1.08a4.748,4.748,0,0,1-.22,1.22l-.78,2.91a4.462,4.462,0,0,0-.1.59c0,.3,0,.43.21.43s.75-.57,1.35-1.29Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-19" dataName="path" className="cls-1" d="M391.42,270.37v.64c0,1.13.43,1.84,1.16,1.84.52,0,1.18-.51,1.94-1.32l.25.25a4.49,4.49,0,0,1-2.94,1.89c-1,0-1.64-1-1.64-2.45a5.19,5.19,0,0,1,1.32-3.32,3.36,3.36,0,0,1,2.37-1.37,1.2,1.2,0,0,1,1.32,1.24C395.17,268.69,393.93,269.69,391.42,270.37Zm1.46-3.2a4.39,4.39,0,0,0-1.43,2.8,5.73,5.73,0,0,0,2.51-1.3.941.941,0,0,0,.06-.29c-.02-.65-.12-1.2-1.14-1.2Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-20" dataName="path" className="cls-1" d="M403.2,271.72c-.92,1.11-1.76,1.92-2.59,1.92-.35,0-.45-.51-.45-1.07a7.557,7.557,0,0,1,.24-1.26s.68-2.69.8-3.34c0-.41,0-.51-.27-.51a14.783,14.783,0,0,0-3,3l-.59,3h-1.18l1-5.14a6.937,6.937,0,0,1,.21-.94v-.16c-.21,0-.67.46-1.3,1.35l-.3-.21c.89-1.27,1.56-1.89,2.29-1.89.35,0,.51.45.51.94a2.231,2.231,0,0,1-.08.54l-.41,1.76c1.4-1.7,2.86-3.24,3.72-3.24.27,0,.65.6.65,1.08a4.748,4.748,0,0,1-.22,1.22l-.78,2.91a3.65,3.65,0,0,0-.1.64c0,.25,0,.38.21.38s.75-.57,1.35-1.29Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-21" dataName="path" className="cls-1" d="M408.22,266.75l-.19.67h-1.67l-.8,4.23a5,5,0,0,0-.06.64c0,.3.1.51.27.51a4.62,4.62,0,0,0,1.56-1.43l.29.24c-1,1.29-1.94,2.05-2.77,2.05-.35,0-.57-.49-.57-1a7.517,7.517,0,0,1,.17-1.26l.75-3.94h-1l.08-.33a4.7,4.7,0,0,0,2.35-2.07H407l-.49,1.72Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-22" dataName="path" className="cls-1" d="M416.41,266.75l-.19.67h-1.67l-.8,4.23a5,5,0,0,0-.06.64c0,.3.1.51.27.51a4.61,4.61,0,0,0,1.56-1.43l.29.24c-1,1.29-1.94,2.05-2.77,2.05-.35,0-.57-.49-.57-1a7.532,7.532,0,0,1,.18-1.26l.75-3.94h-1l.08-.33a4.69,4.69,0,0,0,2.35-2.07h.35l-.49,1.72Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-23" dataName="path" className="cls-1" d="M421.54,268.16h-.16a1.45,1.45,0,0,0-1-.35c-.41,0-1.43,1.72-1.53,2.21l-.68,3.5H417l1-5.14c0-.27.11-.87.11-.94s0-.16-.06-.16c-.21,0-.65.46-1.29,1.35l-.3-.21c.89-1.27,1.54-1.89,2.27-1.89.35,0,.49.46.49,1a3.286,3.286,0,0,1-.06.54l-.13.84a5,5,0,0,1,2.29-2.34,2.43,2.43,0,0,1,1.1.37Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-24" dataName="path" className="cls-1" d="M428.76,271.72c-.92,1.11-1.76,1.92-2.59,1.92-.35,0-.49-.49-.49-1l.43-1.84c-1.3,1.59-2.61,2.89-3.47,2.89-.27,0-.76-.46-.76-1.7a4.92,4.92,0,0,1,1.42-3.5,6,6,0,0,1,4.34-1.88h.48L427,271.8a4.145,4.145,0,0,0-.06.57c0,.21,0,.37.17.37a4.5,4.5,0,0,0,1.37-1.26Zm-2.05-4.09a2.71,2.71,0,0,0-.6-.06,3.2,3.2,0,0,0-1.57.32,4.41,4.41,0,0,0-1.42,3.61c0,1,.24,1.22.41,1.22a10.41,10.41,0,0,0,2.66-2.62Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-25" dataName="path" className="cls-1" d="M436.68,271.72c-.92,1.11-1.76,1.92-2.59,1.92-.35,0-.45-.51-.45-1.07a7.557,7.557,0,0,1,.24-1.26s.68-2.69.8-3.34c0-.41,0-.51-.27-.51a14.783,14.783,0,0,0-3,3l-.59,3h-1.18l1-5.14a6.937,6.937,0,0,1,.21-.94v-.16c-.21,0-.67.46-1.3,1.35l-.3-.21c.89-1.27,1.56-1.89,2.29-1.89.35,0,.51.45.51.94a2.229,2.229,0,0,1-.08.54l-.41,1.76c1.4-1.7,2.86-3.24,3.72-3.24.27,0,.65.6.65,1.08a4.748,4.748,0,0,1-.22,1.22l-.78,2.91a3.654,3.654,0,0,0-.1.64c0,.25,0,.38.21.38s.75-.57,1.35-1.29Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-26" dataName="path" className="cls-1" d="M441.13,268.19a2.06,2.06,0,0,0-1.54-.92.44.44,0,0,0-.14,0,1.42,1.42,0,0,0-.4.91,1.4,1.4,0,0,0,.29.81c.37.46.8.84,1.14,1.21a1.88,1.88,0,0,1,.6,1.19,2.61,2.61,0,0,1-2.69,2.29,1.5,1.5,0,0,1-1.59-1.07c0-.25.49-.65.76-.78a2.26,2.26,0,0,0,1.86,1.16,1.2,1.2,0,0,0,.32,0,1.14,1.14,0,0,0,.48-.84c0-.51-.62-1-1.21-1.61s-1-1-1-1.64a2.86,2.86,0,0,1,2.51-2.34c.86,0,1.37.49,1.37.86S441.41,268,441.13,268.19Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-27" dataName="path" className="cls-1" d="M446.71,268.24a2.25,2.25,0,0,0-1.64-.92,4.49,4.49,0,0,0-1.37,3.37c0,1.62.51,2.18,1.13,2.18s1.18-.52,1.92-1.34l.25.25a4.51,4.51,0,0,1-2.91,1.89c-1,0-1.67-1-1.67-2.46a5.13,5.13,0,0,1,1.3-3.28,3.45,3.45,0,0,1,2.5-1.37c.86,0,1.29.48,1.29.81S447,268.1,446.71,268.24Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-28" dataName="path" className="cls-1" d="M452.87,268.16h-.16a1.45,1.45,0,0,0-1-.35c-.41,0-1.43,1.72-1.53,2.21l-.68,3.5h-1.18l1-5.14c0-.27.11-.87.11-.94s0-.16-.06-.16c-.21,0-.65.46-1.29,1.35l-.3-.21c.89-1.27,1.54-1.89,2.27-1.89.35,0,.49.46.49,1a3.289,3.289,0,0,1-.06.54l-.13.84a5,5,0,0,1,2.29-2.34,2.43,2.43,0,0,1,1.1.37Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-29" dataName="path" className="cls-1" d="M457.21,271.72c-.92,1.11-1.77,1.92-2.59,1.92-.35,0-.48-.49-.48-1a6.6,6.6,0,0,1,.22-1.34l.72-2.88c.08-.35.19-.87.19-.94v-.16a5.871,5.871,0,0,0-1.3,1.35l-.3-.21c.89-1.27,1.59-1.89,2.32-1.89.35,0,.48.45.48.94a2.119,2.119,0,0,1,0,.54l-.92,3.69a3.212,3.212,0,0,0-.08.52c0,.24.08.49.25.49a4.571,4.571,0,0,0,1.3-1.24Zm-.75-7.33a.783.783,0,1,1,.8-.76.79.79,0,0,1-.79.76Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-30" dataName="path" className="cls-1" d="M463.46,271.9a3.81,3.81,0,0,1-2.89,1.75,2.66,2.66,0,0,1-1-.35L459,276a3.682,3.682,0,0,0-.08.67c0,.35.67.54,1.19.54h.08v.37h-4v-.33c1.1-.13,1.46-.3,1.64-1.21l1.51-7.62a8.55,8.55,0,0,1,.14-.86v-.21a10.994,10.994,0,0,0-1.3,1.16l-.27-.24c.86-1,1.77-1.81,2.54-1.81.18,0,.22.24.22.56a11.585,11.585,0,0,1-.25,2c1.45-1.65,2.66-2.51,3.09-2.51s1.08,1.08,1.08,2.53a4.6,4.6,0,0,1-1.13,2.86Zm-.78-4.39a8.32,8.32,0,0,0-2.42,2.23l-.54,2.61a3,3,0,0,0,2,.64,5.14,5.14,0,0,0,1.56-4c.02-.99-.28-1.48-.6-1.48Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-31" dataName="path" className="cls-1" d="M469.71,266.75l-.19.67h-1.67l-.8,4.23a5,5,0,0,0-.06.64c0,.3.1.51.27.51a4.62,4.62,0,0,0,1.56-1.43l.29.24c-1,1.29-1.94,2.05-2.77,2.05-.35,0-.57-.49-.57-1a7.517,7.517,0,0,1,.17-1.26l.75-3.94h-1l.08-.33a4.7,4.7,0,0,0,2.35-2.07h.35l-.49,1.72Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-32" dataName="path" className="cls-1" d="M473.47,271.72c-.92,1.11-1.77,1.92-2.59,1.92-.35,0-.48-.49-.48-1a6.6,6.6,0,0,1,.22-1.34l.72-2.88c.08-.35.19-.87.19-.94v-.16a5.871,5.871,0,0,0-1.3,1.35l-.3-.21c.89-1.27,1.59-1.89,2.32-1.89.35,0,.48.45.48.94a2.118,2.118,0,0,1,0,.54l-.92,3.69a3.215,3.215,0,0,0-.08.52c0,.24.08.49.25.49a4.57,4.57,0,0,0,1.3-1.24Zm-.75-7.33a.783.783,0,1,1,.8-.76.79.79,0,0,1-.79.76Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-33" dataName="path" className="cls-1" d="M478.82,271.85a4.39,4.39,0,0,1-2.8,1.84c-.87,0-1.81-1-1.81-2.77a4.16,4.16,0,0,1,1-2.56,4.63,4.63,0,0,1,2.8-1.83c.91,0,1.81,1,1.81,2.77a4.09,4.09,0,0,1-1,2.55Zm-1.48-4.64c-.67,0-1.89,1.4-1.89,3.58,0,1.53.57,2.26,1.22,2.26s1.88-1.43,1.88-3.66C478.55,268,478,267.21,477.34,267.21Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-34" dataName="path" className="cls-1" d="M488.1,271.72c-.92,1.11-1.76,1.92-2.59,1.92-.35,0-.45-.51-.45-1.07a7.639,7.639,0,0,1,.24-1.26s.68-2.69.8-3.34c0-.41,0-.51-.27-.51a14.783,14.783,0,0,0-3,3l-.59,3h-1.18l1-5.14a6.937,6.937,0,0,1,.21-.94v-.16c-.21,0-.67.46-1.3,1.35l-.3-.21c.89-1.27,1.56-1.89,2.29-1.89.35,0,.51.45.51.94a2.231,2.231,0,0,1-.08.54l-.41,1.76c1.4-1.7,2.86-3.24,3.72-3.24.27,0,.65.6.65,1.08a4.76,4.76,0,0,1-.22,1.22l-.78,2.91a3.648,3.648,0,0,0-.1.64c0,.25,0,.38.21.38s.75-.57,1.35-1.29Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-35" dataName="path" className="cls-1" d="M488.51,276l-.13-.3a2.91,2.91,0,0,0,2-2.31,1.329,1.329,0,0,1-.33,0c-.56,0-1-.16-1-.68a.9.9,0,0,1,.94-.94,1.14,1.14,0,0,1,1.16,1.22,3.35,3.35,0,0,1-2.64,3.01Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-36" dataName="path" className="cls-1" d="M501.1,268.24a2.25,2.25,0,0,0-1.64-.92,4.49,4.49,0,0,0-1.37,3.37c0,1.62.51,2.18,1.13,2.18s1.18-.52,1.92-1.34l.25.25a4.51,4.51,0,0,1-2.91,1.89c-1,0-1.67-1-1.67-2.46a5.13,5.13,0,0,1,1.3-3.28,3.45,3.45,0,0,1,2.5-1.37c.86,0,1.29.48,1.29.81S501.4,268.1,501.1,268.24Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-37" dataName="path" className="cls-1" d="M507.27,268.16h-.16a1.45,1.45,0,0,0-1-.35c-.41,0-1.43,1.72-1.53,2.21l-.68,3.5h-1.18l1-5.14c0-.27.11-.87.11-.94s0-.16-.06-.16c-.21,0-.65.46-1.29,1.35l-.3-.21c.89-1.27,1.54-1.89,2.27-1.89.35,0,.49.46.49,1a3.4,3.4,0,0,1-.06.54l-.13.84a5,5,0,0,1,2.29-2.34,2.43,2.43,0,0,1,1.1.37Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-38" dataName="path" className="cls-1" d="M512.51,271.85a4.39,4.39,0,0,1-2.8,1.84c-.88,0-1.81-1-1.81-2.77a4.16,4.16,0,0,1,1-2.56,4.63,4.63,0,0,1,2.8-1.83c.91,0,1.81,1,1.81,2.77a4.09,4.09,0,0,1-1,2.55ZM511,267.21c-.67,0-1.89,1.4-1.89,3.58,0,1.53.57,2.26,1.22,2.26s1.88-1.43,1.88-3.66C512.25,268,511.67,267.21,511,267.21Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-39" dataName="path" className="cls-1" d="M524.23,268.35c-.89,2.8-3.47,5.26-4.91,5.26-.29,0-.52-.6-.52-1.1a12.136,12.136,0,0,1,.21-1.72c-1.19,1.62-2.56,2.83-3.32,2.83-.27,0-.52-.6-.52-1.08a6,6,0,0,1,.13-1.24l.59-2.88c.06-.29.16-.86.16-.94v-.11c-.21,0-.65.37-1.22,1.26l-.32-.21c.8-1.27,1.45-1.89,2.18-1.89.35,0,.52.49.54,1a2,2,0,0,1,0,.45c-.32,1.7-.7,3.4-.75,4.13,0,.38,0,.57.22.57a7.559,7.559,0,0,0,2.56-2.54l.32-1.7c.06-.33.21-1.24.29-1.69h1.14c-.27,1.7-.84,4.66-.91,5.31,0,.49,0,.72.27.72.89,0,3-2.81,3-4.31a2.31,2.31,0,0,0-.59-1.35,2.06,2.06,0,0,1,1-.59c.32,0,.64.45.64,1.18a2.478,2.478,0,0,1-.19.64Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-40" dataName="path" className="cls-1" d="M531.8,262.26l-2,9.54a4.377,4.377,0,0,0-.06.56c0,.19,0,.43.17.43a5.66,5.66,0,0,0,1.37-1.3l.29.24c-.92,1.11-1.77,1.92-2.59,1.92-.35,0-.48-.49-.48-1l.4-1.77c-1.3,1.56-2.66,2.81-3.51,2.81-.27,0-.76-.46-.76-1.7a5.37,5.37,0,0,1,1.42-3.69,7,7,0,0,1,3.74-1.83l.41-2.19a4.437,4.437,0,0,0,.1-.64c0-.32-.16-.43-.6-.43a4.738,4.738,0,0,0-.68.1l.08-.37,2.43-.64Zm-2.19,5.25a3,3,0,0,0-.64-.06,3.74,3.74,0,0,0-1.65.32,4.71,4.71,0,0,0-1.41,3.74c0,.94.24,1.22.41,1.22a10.371,10.371,0,0,0,2.7-2.54Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-41" dataName="path" className="cls-1" d="M535.88,268.19a2.06,2.06,0,0,0-1.54-.92.439.439,0,0,0-.14,0,1.42,1.42,0,0,0-.4.91,1.4,1.4,0,0,0,.29.81c.37.46.8.84,1.15,1.21a1.88,1.88,0,0,1,.6,1.19,2.61,2.61,0,0,1-2.69,2.29,1.5,1.5,0,0,1-1.59-1.07c0-.25.49-.65.76-.78a2.27,2.27,0,0,0,1.86,1.16,1.2,1.2,0,0,0,.32,0,1.14,1.14,0,0,0,.48-.84c0-.51-.62-1-1.21-1.61s-1-1-1-1.64a2.86,2.86,0,0,1,2.51-2.34c.86,0,1.37.49,1.37.86S536.17,268,535.88,268.19Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-42" dataName="path" className="cls-1" d="M541.78,271.85a4.39,4.39,0,0,1-2.8,1.84c-.88,0-1.81-1-1.81-2.77a4.161,4.161,0,0,1,1-2.56,4.63,4.63,0,0,1,2.8-1.83c.91,0,1.81,1,1.81,2.77a4.09,4.09,0,0,1-1,2.55Zm-1.48-4.64c-.67,0-1.89,1.4-1.89,3.58,0,1.53.57,2.26,1.22,2.26s1.88-1.43,1.88-3.66c0-1.39-.57-2.18-1.21-2.18Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-43" dataName="path" className="cls-1" d="M551.19,271.72c-.92,1.11-1.76,1.92-2.59,1.92-.35,0-.48-.49-.48-1a20.56,20.56,0,0,1,.51-2.27c-1.4,1.8-2.88,3.32-3.74,3.32-.27,0-.68-.6-.68-1.08a5.83,5.83,0,0,1,.24-1.22l.76-2.91c.08-.29.22-.87.22-.94v-.21a5.871,5.871,0,0,0-1.3,1.35l-.3-.21c.89-1.27,1.57-1.89,2.31-1.89.35,0,.49.45.49,1a2.426,2.426,0,0,1-.06.48c-.43,1.69-.91,3.5-1,4.15,0,.43.1.6.27.6.33,0,1.69-1.43,2.94-3l.64-3h1.19l-1.11,5.1a2.909,2.909,0,0,0-.08.56c0,.24,0,.41.21.41s.75-.57,1.35-1.29Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-44" dataName="path" className="cls-1" d="M556.74,268.16h-.16a1.45,1.45,0,0,0-1-.35c-.41,0-1.43,1.72-1.53,2.21l-.68,3.5h-1.18l1-5.14c0-.27.11-.87.11-.94s0-.16-.06-.16c-.21,0-.65.46-1.29,1.35l-.3-.21c.89-1.27,1.54-1.89,2.27-1.89.35,0,.49.46.49,1a3.4,3.4,0,0,1-.06.54l-.13.84a5,5,0,0,1,2.29-2.34,2.44,2.44,0,0,1,1.1.37Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-45" dataName="path" className="cls-1" d="M561.65,268.24a2.25,2.25,0,0,0-1.64-.92,4.49,4.49,0,0,0-1.37,3.37c0,1.62.51,2.18,1.13,2.18s1.18-.52,1.92-1.34l.25.25a4.51,4.51,0,0,1-2.91,1.89c-1,0-1.67-1-1.67-2.46a5.131,5.131,0,0,1,1.3-3.28,3.45,3.45,0,0,1,2.5-1.37c.86,0,1.29.48,1.29.81S562,268.1,561.65,268.24Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-46" dataName="path" className="cls-1" d="M564.11,270.37v.64c0,1.13.43,1.84,1.16,1.84.52,0,1.18-.51,1.94-1.32l.25.25a4.49,4.49,0,0,1-2.94,1.89c-1,0-1.64-1-1.64-2.45a5.19,5.19,0,0,1,1.32-3.32,3.36,3.36,0,0,1,2.37-1.37,1.2,1.2,0,0,1,1.32,1.24C567.86,268.69,566.62,269.69,564.11,270.37Zm1.46-3.2a4.4,4.4,0,0,0-1.43,2.8,5.73,5.73,0,0,0,2.51-1.3.922.922,0,0,0,.06-.29c.01-.65-.12-1.2-1.14-1.2Z" transform="translate(-346.05 -198.67)" />
                  <path id="path-47" dataName="path" className="cls-1" d="M575.42,262.26l-2,9.54a4.377,4.377,0,0,0-.06.56c0,.19,0,.43.17.43a5.66,5.66,0,0,0,1.37-1.3l.29.24c-.92,1.11-1.77,1.92-2.59,1.92-.35,0-.48-.49-.48-1l.4-1.77c-1.3,1.56-2.66,2.81-3.51,2.81-.27,0-.76-.46-.76-1.7a5.37,5.37,0,0,1,1.42-3.69,7,7,0,0,1,3.74-1.83l.41-2.19a4.445,4.445,0,0,0,.1-.64c0-.32-.16-.43-.6-.43a4.768,4.768,0,0,0-.68.1l.08-.37,2.43-.64Zm-2.19,5.25a3,3,0,0,0-.64-.06,3.74,3.74,0,0,0-1.65.32,4.71,4.71,0,0,0-1.41,3.74c0,.94.24,1.22.41,1.22a10.371,10.371,0,0,0,2.7-2.54Z" transform="translate(-346.05 -198.67)" />
                </g>
              </svg>
            </div>
          </div>
        </div>
      else
        <div />
    }
    </div>

module.exports = Footer