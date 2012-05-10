$('[data-nested="add"]').live 'click', (e)->
    e.preventDefault()
    association = $(this).data('association')
    fields = $(this).data('fields')
    target = $("[data-association='#{association}_fields']")
    
    regexp = new RegExp('new_' + association, 'g');
    new_id = new Date().getTime();
    fields = fields.replace(regexp, "new_" + new_id);
    
    target.append(fields)
    
$('[data-nested="remove"]').live 'click', (e)->
    e.preventDefault()
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('div').hide()

