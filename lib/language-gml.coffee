GameMakerView = require './game-maker-view'
{CompositeDisposable} = require 'atom'

module.exports = GameMaker =
  gameMakerView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @gameMakerView = new GameMakerView(state.gameMakerViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @gameMakerView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'game-maker:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @gameMakerView.destroy()

  serialize: ->
    gameMakerViewState: @gameMakerView.serialize()

  toggle: ->
    console.log 'GameMaker was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
