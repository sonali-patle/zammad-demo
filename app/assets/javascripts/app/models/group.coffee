class App.Group extends App.Model
  @configure 'Group', 'name', 'assignment_timeout', 'follow_up_possible', 'follow_up_assignment', 'email_address_id', 'signature_id', 'note', 'active', 'shared_drafts', 'updated_at'
  @extend Spine.Model.Ajax
  @url: @apiPath + '/groups'

  @configure_attributes = [
    { name: 'name',                 display: __('Name'),              tag: 'input',  type: 'text', limit: 100, null: false },
    { name: 'assignment_timeout',   display: __('Assignment timeout'), tag: 'input', note: __('Assignment timeout in minutes if assigned agent is not working on it. Ticket will be shown as unassigend.'), type: 'text', limit: 100, null: true },
    { name: 'follow_up_possible',   display: __('Follow-up possible'),tag: 'select', default: 'yes', options: { yes: 'yes', 'new_ticket': 'do not reopen Ticket but create new Ticket' }, null: false, note: __('Follow-up for closed ticket possible or not.'), translate: true },
    { name: 'follow_up_assignment', display: __('Assign follow-ups'), tag: 'select', default: 'yes', options: { true: 'yes', false: 'no' }, null: false, note: __('Assign follow-up to latest agent again.'), translate: true },
    { name: 'email_address_id',     display: __('Email'),             tag: 'select', multiple: false, null: true, relation: 'EmailAddress', nulloption: true, do_not_log: true },
    { name: 'signature_id',         display: __('Signature'),         tag: 'select', multiple: false, null: true, relation: 'Signature', nulloption: true, do_not_log: true, display_warn: true, warn: __('This signature is inactive, it won\'t be included in the reply. Change state <a href="#channels/email">here</a>') },
    { name: 'note',                 display: __('Note'),              tag: 'textarea', note: __('Notes are visible to agents only, never to customers.'), limit: 250, null: true },
    { name: 'updated_at',           display: __('Updated'),           tag: 'datetime', readonly: 1 },
    { name: 'active',               display: __('Active'),            tag: 'active', default: true },
    { name: 'shared_drafts',        display: __('Shared Drafts'),     tag: 'active' },
  ]
  @configure_clone = true
  @configure_overview = [
    'name',
  ]

  uiUrl: ->
    '#group/zoom/' + @id

  activityMessage: (item) ->
    if item.type is 'create'
      return App.i18n.translateContent('%s created group |%s|', item.created_by.displayName(), item.title)
    else if item.type is 'update'
      return App.i18n.translateContent('%s updated group |%s|', item.created_by.displayName(), item.title)
    return "Unknow action for (#{@objectDisplayName()}/#{item.type}), extend activityMessage() of model."

  avatar: (size = 40, cssClass = []) ->
    size = parseInt(size, 10)
    cssClass.push("size-#{ size }")
    cssClass.push("avatar--group-color-#{@id % 3}")

    return App.view('avatar_group')
      cssClass: cssClass.join(' ')

  @accesses: ->
    read: __('Read')
    create: __('Create')
    change: __('Change')
    overview: __('Overview')
    full: __('Full')

  signature_id_is_display_warning: (signature_id) ->
    !App.Signature.find(signature_id).active
