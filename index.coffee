command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $1,$2,$3 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 1000

style: """
    top: 100px
    left: 700px
    color: #fff
    font-family: Helvetica Neue

    table
      border-collapse: collapse
      table-layout: fixed

      &:after
        content: 'battery'
        position: absolute
        left: 0
        top: -14px
        font-size: 12px

    td
      border: 1px solid #fff
      font-size: 24px
      font-weight: 100
      width: 120px
      max-width: 250px
      overflow: hidden
      text-shadow: 0 0 1px rgba(#000, 0.5)

    .value
      padding: 4px 6px 4px 6px
      position: relative

    .col1
      background: rgba(#000, 0.2)
		
    .col2
      background: rgba(#000, 0.3)
	  
    .col3
      background: rgba(#000, 0.4)

    p
      padding: 0
      margin: 0
      font-size: 11px
      font-weight: normal
      max-width: 100%
      color: #ddd
      text-overflow: ellipsis
      text-shadow: none
"""

render: -> """
<table>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  values = output.split(' ')
  table     = $(domEl).find('table')

  renderValue = (battery, index, label) ->
    "<div class='value'>" +
      "#{battery}" +
      "<p class=label> #{label}</p>" +
    "</div>"

  for value, i in values
    if i == 0
      label = 'Battery'
    else if i == 1
      label = 'charge[%]'
    else if i == 2
      label = 'charge[state]'

    table.find(".col#{i+1}").html renderValue(value,i, label)
