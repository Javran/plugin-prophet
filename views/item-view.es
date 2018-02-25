
import { join } from 'path'
import React from 'react'
import { connect } from 'react-redux'
import { SlotitemIcon } from 'views/components/etc/icon'
import { get } from 'lodash'
import { equipIsAircraft } from 'views/utils/game-utils'

const { ROOT } = window

// friend item is from _slotitems, while enemy item is from $slotitems
// so for enemy item, its $item will always be undefined
const ItemView = connect((state, props) => ({
  $item: get(state, `const.$equips.${(props.item || {}).api_slotitem_id}`),
}))(({
  item, extra, label, warn, $item,
}) => {
  if (!item) {
    return <div />
  }
  const data = {
    ...$item,
    ...item,
  }
  return (
    <div className="item-info">
      <span className="item-icon">
        <SlotitemIcon slotitemId={(data.api_type || [])[3]} className="prophet-icon" />
        {
          label != null && (extra || equipIsAircraft((data.api_type || [])[3]))
          ?
            <span className={`number ${warn ? 'text-warning' : ''}`}>{label}</span>
          : null
        }
      </span>
      <span className="item-name">
        {window.i18n.resources.__(data.api_name)}
      </span>
      <span className="item-attr">
        <span className="alv">
          {
            (data.api_alv && data.api_alv >= 1 && data.api_alv <= 7) &&
            <img
              className="alv-img prophet-icon"
              src={join(ROOT, 'assets', 'img', 'airplane', `alv${data.api_alv}.png`)}
              alt="alv"
            />
          }
        </span>
        <span className="level">{data.api_level > 0 ? `★${data.api_level}` : ''}</span>
      </span>
    </div>
  )
})

export default ItemView
