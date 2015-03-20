getCursors = (editor) ->

    cursors = for cursor in editor.getCursorBufferPositions()
      do (cursor) ->
        console.log(cursor)
        return cursor

    return cursors

getTexts = (editor) ->
    editor.selectLinesContainingCursors()

    texts = for sel in editor.getSelections()
      do (sel) ->
        sel.selectLine(sel.getBufferRowRange()[0])
        sel.selectLine(sel.getBufferRowRange()[1])
        return sel.getText()

    return texts

# TODO: add new line if last or first line
# TODO: mantain cursor position on duplicated lines

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
