package com.pickgliss.ui.controls.alert
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class BaseAlerFrame extends Frame
   {
      
      public static const P_buttonToBottom:String = "buttonToBottom";
      
      public static const P_cancelButton:String = "submitButton";
      
      public static const P_info:String = "info";
      
      public static const P_submitButton:String = "submitButton";
       
      
      protected var _buttonToBottom:int;
      
      protected var _cancelButton:BaseButton;
      
      protected var _cancelButtonStyle:String;
      
      protected var _info:AlertInfo;
      
      protected var _sound;
      
      protected var _submitButton:BaseButton;
      
      protected var _submitButtonStyle:String;
      
      protected var _isBand:Boolean;
      
      protected var _isShowTheLog:Boolean;
      
      protected var _selectedCheckBtn:SelectedCheckButton;
      
      public function BaseAlerFrame()
      {
         super();
      }
      
      public function set buttonToBottom(param1:int) : void
      {
         if(_buttonToBottom == param1)
         {
            return;
         }
         _buttonToBottom = param1;
         onPropertiesChanged("buttonToBottom");
      }
      
      public function set cancelButtonEnable(param1:Boolean) : void
      {
         _cancelButton.enable = param1;
      }
      
      public function set cancelButtonStyle(param1:String) : void
      {
         if(_cancelButtonStyle == param1)
         {
            return;
         }
         _cancelButtonStyle = param1;
         _cancelButton = ComponentFactory.Instance.creat(_cancelButtonStyle);
         onPropertiesChanged("submitButton");
      }
      
      override public function dispose() : void
      {
         var _loc1_:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(_loc1_ && contains(_loc1_))
         {
            StageReferance.stage.focus = null;
         }
         if(_submitButton)
         {
            _submitButton.removeEventListener("click",__onSubmitClick);
            ObjectUtils.disposeObject(_submitButton);
            _submitButton = null;
         }
         if(_cancelButton)
         {
            _cancelButton.removeEventListener("click",__onCancelClick);
            ObjectUtils.disposeObject(_cancelButton);
            _cancelButton = null;
         }
         removeEventListener("keyDown",__onKeyDown);
         _info = null;
         super.dispose();
      }
      
      public function get info() : AlertInfo
      {
         return _info;
      }
      
      public function get isBand() : Boolean
      {
         return _isBand;
      }
      
      public function set isBand(param1:Boolean) : void
      {
         _isBand = param1;
      }
      
      public function set info(param1:AlertInfo) : void
      {
         if(_info == param1)
         {
            return;
         }
         if(_info)
         {
            _info.removeEventListener("stateChange",__onInfoChanged);
         }
         _info = param1;
         _info.addEventListener("stateChange",__onInfoChanged);
         onPropertiesChanged("info");
      }
      
      public function setIsShowTheLog(param1:Boolean, param2:String) : void
      {
         if(_isShowTheLog != param1)
         {
            _isShowTheLog = param1;
            _info.logText = param2;
            creatTheLog();
         }
      }
      
      protected function creatTheLog() : void
      {
      }
      
      public function set submitButtonEnable(param1:Boolean) : void
      {
         _submitButton.enable = param1;
      }
      
      public function set submitButtonStyle(param1:String) : void
      {
         if(_submitButtonStyle == param1)
         {
            return;
         }
         _submitButtonStyle = param1;
         _submitButton = ComponentFactory.Instance.creat(_submitButtonStyle);
         onPropertiesChanged("submitButton");
      }
      
      protected function __onCancelClick(param1:MouseEvent) : void
      {
         if(_sound != null)
         {
            ComponentSetting.PLAY_SOUND_FUNC(_sound);
         }
         onResponse(4);
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         if(_sound != null)
         {
            ComponentSetting.PLAY_SOUND_FUNC(_sound);
         }
         super.__onCloseClick(param1);
      }
      
      override protected function __onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13 && enterEnable || param1.keyCode == 27 && escEnable)
         {
            if(_sound != null)
            {
               ComponentSetting.PLAY_SOUND_FUNC(_sound);
            }
         }
         super.__onKeyDown(param1);
      }
      
      protected function __onSubmitClick(param1:MouseEvent) : void
      {
         if(_sound != null)
         {
            ComponentSetting.PLAY_SOUND_FUNC(_sound);
         }
         onResponse(3);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_submitButton)
         {
            addChild(_submitButton);
         }
         if(_cancelButton)
         {
            addChild(_cancelButton);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["info"])
         {
            _sound = _info.sound;
            _escEnable = _info.escEnable;
            _enterEnable = info.enterEnable;
            _titleText = _info.title;
            _changedPropeties["titleText"] = true;
            _moveEnable = _info.moveEnable;
            _changedPropeties["moveEnable"] = true;
         }
         super.onProppertiesUpdate();
         if(_changedPropeties["info"] || _changedPropeties["submitButton"] || _changedPropeties["submitButton"])
         {
            if(_cancelButton && _info)
            {
               _cancelButton.visible = _info.showCancel;
               _cancelButton.enable = _info.cancelEnabled;
               if(_cancelButton is TextButton)
               {
                  TextButton(_cancelButton).text = _info.cancelLabel;
               }
               if(_cancelButton.visible)
               {
                  _cancelButton.addEventListener("click",__onCancelClick);
               }
            }
            if(_submitButton && _info)
            {
               _submitButton.visible = _info.showSubmit;
               _submitButton.enable = _info.submitEnabled;
               if(_submitButton is TextButton)
               {
                  TextButton(_submitButton).text = _info.submitLabel;
               }
               if(_submitButton.visible)
               {
                  _submitButton.addEventListener("click",__onSubmitClick);
               }
            }
         }
         if(_changedPropeties["info"] || _changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["buttonToBottom"])
         {
            updatePos();
         }
      }
      
      override protected function onResponse(param1:int) : void
      {
         if(_info && _info.autoDispose)
         {
            dispose();
         }
         super.onResponse(param1);
      }
      
      protected function updatePos() : void
      {
         if(_info == null)
         {
            return;
         }
         if(_info.bottomGap)
         {
            _buttonToBottom = int(_info.bottomGap);
         }
         if(_submitButton)
         {
            _submitButton.y = _height - _submitButton.height - _buttonToBottom;
         }
         if(_cancelButton)
         {
            _cancelButton.y = _height - _cancelButton.height - _buttonToBottom;
         }
         if(_info.showCancel || _info.showSubmit)
         {
            if(_info.customPos)
            {
               if(_submitButton)
               {
                  _submitButton.x = _info.customPos.x;
                  _submitButton.y = _info.customPos.y;
                  if(_cancelButton)
                  {
                     _cancelButton.x = _info.customPos.x + _cancelButton.width + _info.buttonGape;
                     _cancelButton.y = _info.customPos.y;
                  }
               }
               else if(_cancelButton)
               {
                  _cancelButton.x = _info.customPos.x;
                  _cancelButton.y = _info.customPos.y;
               }
            }
            else
            {
               if(_info.autoButtonGape)
               {
                  if(_submitButton != null && _cancelButton != null)
                  {
                     _info.buttonGape = (_width - _submitButton.width - _cancelButton.width) / 2;
                  }
               }
               if(!_info.showCancel && _submitButton)
               {
                  _submitButton.x = (_width - _submitButton.width) / 2;
               }
               else if(!_info.showSubmit && _cancelButton)
               {
                  _cancelButton.x = (_width - _cancelButton.width) / 2;
               }
               else if(_cancelButton != null && _submitButton != null)
               {
                  _submitButton.x = (_width - _submitButton.width - _cancelButton.width - _info.buttonGape) / 2;
                  _cancelButton.x = _submitButton.x + _submitButton.width + _info.buttonGape;
               }
            }
         }
      }
      
      private function __onInfoChanged(param1:InteractiveEvent) : void
      {
         onPropertiesChanged("info");
      }
      
      public function get selectedCheckButton() : SelectedCheckButton
      {
         return _selectedCheckBtn;
      }
   }
}
