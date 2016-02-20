{Table, ProgressBar, Grid, Input, Col, Alert, Button, OverlayTrigger, Popover, Tooltip} = ReactBootstrap

getCondStyle = (cond, show) ->
  if show
    window.getCondStyle cond

Slotitems = React.createClass
  shouldComponentUpdate: (nextProps, nextState) ->
    not _.isEqual nextProps, @props
  render: ->
    <div className="slotitems-mini" style={display: "flex", flexFlow: "column"}>
    {
      for itemId, i in @props.slot
        continue if itemId == -1
        if @props.owner == 1
          item = window.$slotitems[itemId]
        else
          item = window._slotitems[itemId]
        <div key={i} className="slotitem-container-mini">
          <span className="slotitem-name-mini">
            {item.api_name}
              {if @props.owner != 1 && item.api_level > 0 then <strong style={color: '#45A9A5'}> ★{item.api_level}</strong> else ''}              
          </span>
        </div>
    }
    </div>

module.exports = React.createClass
  render: ->
    if @props.lv == -1
      <td>　</td>
    else
      nameText = "#{@props.ship.name} "
      showCond = @props.condShow
      nameText += "★#{@props.ship.cond} " if showCond
      nameText += "- Lv.#{@props.ship.lv} " if !@props.compactMode

      <td style={opacity: 1 - 0.6 * @props.isBack} className="prophet-info-content">
        <div className="ship-title">
          <OverlayTrigger placement={if (window.layout == 'vertical') then 'left' else 'right'} overlay={
            <Tooltip id="ship-pop-#{@props.ship.id}" className="ship-pop">
              <div className="item-name">
                <Slotitems slot={@props.ship.slot} owner={@props.ship.owner}/>
              </div>
            </Tooltip>
          }>
            <div className="ship-name">
              <span className={getCondStyle(@props.ship.cond, showCond)}>
                <span className="prophet-info-name">{nameText}</span>
              </span>
            </div>
          </OverlayTrigger>
        </div>
        <div className="attack-damage">
          {
            if @props.mvp == true
              <span className={getCondStyle(100, 1)}>{@props.ship.hp.damage}</span>
            else
              <span>{@props.ship.hp.damage}</span>
          }
        </div>
      </td>
