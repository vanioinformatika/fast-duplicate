getCursors = (editor) ->

    cursors = for sel in editor.getSelections()
      do (sel) ->
        sel.selectLine(sel.getBufferRowRange()[0])
        sel.selectLine(sel.getBufferRowRange()[1])
        return sel.getText()

    return cursors

getTexts = (editor) ->
    editor.selectLinesContainingCursors()

    texts = for sel in editor.getSelections()
      do (sel) ->
        sel.selectLine(sel.getBufferRowRange()[0])
        sel.selectLine(sel.getBufferRowRange()[1])
        return sel.getText()

    return texts

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', "fast-duplicate:duplicate-down", => @down()
    atom.commands.add 'atom-workspace', "fast-duplicate:duplicate-up", => @up()
  down: ->
    editor = atom.workspace.activePaneItem
    cursors = getCursors(editor)
    texts = getTexts(editor)

    editor.moveRight()

    for sel, i in editor.getSelections()
      do (sel) ->
        sel.insertText(texts[i])
  up: ->
    editor = atom.workspace.activePaneItem
    cursors = getCursors(editor)
    texts = getTexts(editor)

    editor.moveLeft()

    for sel, i in editor.getSelections()
      do (sel) ->
        sel.insertText(texts[i])
