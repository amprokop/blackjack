// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = (function(_super) {
    __extends(App, _super);

    function App() {
      _ref = App.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    App.prototype.initialize = function() {
      var deck,
        _this = this;
      this.set('deck', deck = new Deck());
      this.set('playerHand', deck.dealPlayer());
      this.set('dealerHand', deck.dealDealer());
      return this.get('dealerHand playerHand').on('ended', function() {
        var currentDealerScore, currentPlayerScore, dealerScores, playerScores, score, text, _i, _j, _len, _len1;
        dealerScores = _this.get('dealerHand').scores();
        playerScores = _this.get('playerHand').scores();
        currentPlayerScore = 0;
        currentDealerScore = 0;
        for (_i = 0, _len = playerScores.length; _i < _len; _i++) {
          score = playerScores[_i];
          if ((currentPlayerScore < score && score <= 21)) {
            currentPlayerScore = score;
          }
        }
        for (_j = 0, _len1 = dealerScores.length; _j < _len1; _j++) {
          score = dealerScores[_j];
          if ((currentDealerScore < score && score <= 21)) {
            currentDealerScore = score;
          }
        }
        if (currentPlayerScore > currentDealerScore) {
          text = "WINNER";
        } else {
          text = "LOSER";
        }
        _this.text = text;
        return _this.trigger('ended');
      });
    };

    return App;

  })(Backbone.Model);

}).call(this);
