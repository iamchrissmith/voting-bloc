const ResultsList = ({results}) =>
  <div>
    {results.results.map(function(result) {
      return (
        <Result result={result} key={result.first}/>
      )
    })}
  </div>
