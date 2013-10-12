class window.AppView extends Backbone.View

  className: 'table'

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events: #this is for user events
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": ->
      @model.get('playerHand').stand()
      @model.get('dealerHand').hit()

  initialize: ->
    @.model.on('ended', =>
      $('button').hide()
      $('.table').prepend('<button class="playAgain">Would you care to play again, Sir or Madam?</button>')
      that = @
      @.flasher()
      $('.playAgain').on('click', ->
        that.model.initialize()
        that.render()
      ))
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


  flasher:  =>
        console.log "YOU ARE A WINNER"
        $('#winner').text(@.model.text)
        $('#winner').css('display', 'inline')
        i = 1
        setInterval ->
          $('#winner').css('font-size', i + 'px')
          $('#winner').css('color', ['green', 'blue', 'red', 'purple', 'pink', 'white','brown','orange'][Math.floor(Math.random()*8)])
          i++
        ,20
