#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    dealerHand = @.get('dealerHand')
    @.get('playerHand').on 'ended', =>
      @tally()
    @.get('dealerHand').on 'ended', =>
      @tally()
      dealerHand.at(0).flip()

  tally: ->
    dealerScores = @.get('dealerHand').scores()
    playerScores = @.get('playerHand').scores()
    currentPlayerScore = 0
    currentDealerScore = 0
    for score in playerScores when currentPlayerScore < score <= 21
      currentPlayerScore = score
    for score in dealerScores when currentDealerScore < score <= 21
      currentDealerScore = score
    if currentPlayerScore > currentDealerScore then text = "WINNER" 
    else text = "LOSER"
    @.text = text
    @.trigger 'ended'

