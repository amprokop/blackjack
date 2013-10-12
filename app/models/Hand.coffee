class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last() unless @isDealer
    scores = @scores()
    isBusted = _.all scores, (score) -> score > 21
    if isBusted
      console.log('bust')
      $('.stand-button').click()
    if @isDealer
      console.log(@.at(0))
      @.at(0).flip()
      scores = this.scores()
      while scores[0] < 17
        @add(@deck.pop()).last()
        scores = @scores()
      @.trigger('ended')

  stand: ->
    #if dealerhand score < 17, repeatedly hit until over 16
    #changes turn
    #gets rid of button handlers/buttons

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->   #just checks to see if there's an ace in your hand
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  bestScore: ->
    scores = @scores()
    best = 0
    for score in scores when best < score <= 21
        best = score
    if best is 0 then best = "BUST"
    best




