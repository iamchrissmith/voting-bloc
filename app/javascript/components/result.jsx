import React from 'react'

const Result = ({result}) =>
  <div>
    <p>{result.candidate}: {result.votes} votes</p>
  </div>

export default Result
