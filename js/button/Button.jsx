import React, { PureComponent } from 'react';
import classNames from 'classnames';
import PropTypes from 'prop-types';

const noop = () => {};
const mapThemeToCls = {
  default: 'my-pref-button_theme_default',
  prymary: 'my-pref-button_theme_primary'
};

export class Button extends PureComponent {
  static propTypes = {
    caption: PropTypes.string,
    children: PropTypes.node,
    className: PropTypes.string,
    disabled: PropTypes.bool,
    onBlur: PropTypes.func,
    onClick: PropTypes.func,
    onFocus: PropTypes.func,
    onKeyDown: PropTypes.func,
    onKeyUp: PropTypes.func,
    style: PropTypes.object,
    tabIndex: PropTypes.number,
    theme: PropTypes.string,
    type: PropTypes.string
  }

  static defaultProps = {
    disabled: false,
    onBlur: noop,
    onClick: noop,
    onFocus: noop,
    tabIndex: 0,
    theme: 'default',
    type: 'button'
  }

  constructor (props) {
    super(props);

    this.handleBlur = this.handleBlur.bind(this);
    this.handleClick = this.handleClick.bind(this);
    this.handleFocus = this.handleFocus.bind(this);
  }

  handleClick (e) {
    /* do some with button ref */
    
    this.props.onClick(e);
  }

  handleBlur (e) {
    /* do some with button ref */

    this.props.onBlur(e);
  }

  handleFocus (e) {
    /* do some with button ref */

    this.props.onFocus(e);
  }

  render() {
    const {
      caption,
      children,
      className,
      theme,
      ...other
    } = this.props;

    const buttonCls = classNames(
      'my-pref-button',
      mapThemeToCls[theme],
      { [className]: className }
    );

    return (
      <button 
        {...other}
        className={buttonCls}
        onBlur={this.onBlur}
        onClick={this.handleClick}
        onFocus={this.handleFocus}
        ref={(button) => this.button = button}
      >
        {caption ? caption : children}
      </button>
    );
  }
}

export default Button;
