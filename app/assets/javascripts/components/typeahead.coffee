class window.components.typeahead
  constructor: (@args)->

  initialize:()->
    if @args.txt_input.length and @args.url and @args.url.length > 0

      entries = new Bloodhound(
        datumTokenizer: Bloodhound.tokenizers.whitespace
        queryTokenizer: Bloodhound.tokenizers.whitespace
        prefetch: 
          url: @args.url
          cache: false
      )

      @args.txt_input.typeahead(
        {
          hint: true,
          highlight: true,
        },  
        { 
          name: 'entries',
          source: entries
        }
      )