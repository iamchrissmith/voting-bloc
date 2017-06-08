const ResultsList = ({results}) =>
  <div>
    {results.map(function(result) {
      return (
        <Result result={result} key={result}/>
      )
    })}
  </div>
