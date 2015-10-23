getCursors = (editor) ->

    cursors = for cursor in editor.getCursorBufferPositions()
      do (cursor) ->
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

hasSelectionAtLastLine = (editor) ->
    editor.selectLinesContainingCursors()
    hasLast = false
    for sel in editor.getSelections()
      do (sel) ->
        hasLast = hasLast || (sel.getBufferRowRange()[1]+1 == editor.getLineCount())

    return hasLast


module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', "fast-duplicate:duplicate-down", => @down()
    atom.commands.add 'atom-workspace', "fast-duplicate:duplicate-up", => @up()
  down: ->
    editor = atom.workspace.paneContainer.activePane.activeItem
    editor.duplicateLines()
    # cursors = getCursors(editor)
    # texts = getTexts(editor)
    # hasLastLine = hasSelectionAtLastLine(editor)
    # texts = getTexts(editor)
    #
    # editor.moveRight()
    #
    # for sel, i in editor.getSelections()
    #   do (sel) ->
    #     sel.insertText(texts[i])

  up: ->
    editor = atom.workspace.paneContainer.activePane.activeItem
    cursors = getCursors(editor)
    texts = getTexts(editor)

    editor.moveLeft()

    for sel, i in editor.getSelections()
      do (sel) ->
        sel.insertText(texts[i])

    for cursor, i in editor.getCursors()
      do (cursor) ->
        cursor.setBufferPosition([cursor.getBufferPosition().row-1, cursors[i].column])
