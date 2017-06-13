import React from 'react'
import Result from './result'

const ResultsList = ({results}) =>
  <div>
    {results.results.map(function(result) {
      return (
        <Result result={result} key={result.candidate}/>
      )
    })}
  </div>
  
export default ResultsList
