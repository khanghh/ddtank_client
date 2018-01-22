package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.geom.OuterRectPos;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class SelectedTextButton extends SelectedButton
   {
      
      public static const P_backgoundInnerRect:String = "backgoundInnerRect";
      
      public static const P_text:String = "text";
      
      public static const P_selectedTextField:String = "selectedtextField";
      
      public static const P_unSelectedTextField:String = "unselectedtextField";
      
      public static const P_selected:String = "selected";
      
      public static const P_unSelectedButtonOuterRectPos:String = "unSelectedButtonOuterRectPos";
       
      
      protected var _selectedTextField:TextField;
      
      protected var _unSelectedTextField:TextField;
      
      protected var _text:String = "";
      
      protected var _textStyle:String;
      
      protected var _selectedBackgoundInnerRect:InnerRectangle;
      
      protected var _unselectedBackgoundInnerRect:InnerRectangle;
      
      protected var _backgoundInnerRectString:String;
      
      protected var _unSelectedButtonOuterRectPosString:String;
      
      protected var _unSelectedButtonOuterRectPos:OuterRectPos;
      
      public function SelectedTextButton()
      {
         _selectedBackgoundInnerRect = new InnerRectangle(0,0,0,0,-1);
         _unselectedBackgoundInnerRect = new InnerRectangle(0,0,0,0,-1);
         super();
      }
      
      public function set unSelectedButtonOuterRectPosString(param1:String) : void
      {
         if(_unSelectedButtonOuterRectPosString == param1)
         {
            return;
         }
         _unSelectedButtonOuterRectPosString = param1;
         _unSelectedButtonOuterRectPos = ClassUtils.CreatInstance("com.pickgliss.geom.OuterRectPos",ComponentFactory.parasArgs(_unSelectedButtonOuterRectPosString));
         onPropertiesChanged("unSelectedButtonOuterRectPos");
      }
      
      public function set backgoundInnerRectString(param1:String) : void
      {
         if(_backgoundInnerRectString == param1)
         {
            return;
         }
         _backgoundInnerRectString = param1;
         var _loc2_:Array = ComponentFactory.parasArgs(_backgoundInnerRectString);
         if(_loc2_.length > 0 && _loc2_[0] != "")
         {
            _selectedBackgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",String(_loc2_[0]).split("|"));
         }
         if(_loc2_.length > 1 && _loc2_[1] != "")
         {
            _unselectedBackgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",String(_loc2_[1]).split("|"));
         }
         onPropertiesChanged("backgoundInnerRect");
      }
      
      override public function dispose() : void
      {
         if(_selectedTextField)
         {
            ObjectUtils.disposeObject(_selectedTextField);
         }
         _selectedTextField = null;
         if(_unSelectedTextField)
         {
            ObjectUtils.disposeObject(_unSelectedTextField);
         }
         _unSelectedTextField = null;
         super.dispose();
      }
      
      public function set text(param1:String) : void
      {
         if(_text == param1)
         {
            return;
         }
         _text = param1;
         onPropertiesChanged("text");
      }
      
      public function set selectedTextField(param1:TextField) : void
      {
         if(_selectedTextField == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_selectedTextField);
         _selectedTextField = param1;
         onPropertiesChanged("selectedtextField");
      }
      
      public function set unSelectedTextField(param1:TextField) : void
      {
         if(_unSelectedTextField == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_unSelectedTextField);
         _unSelectedTextField = param1;
         onPropertiesChanged("unselectedtextField");
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyle == param1)
         {
            return;
         }
         _textStyle = param1;
         var _loc2_:Array = ComponentFactory.parasArgs(param1);
         if(_loc2_.length > 0 && _loc2_[0] != "")
         {
            selectedTextField = ComponentFactory.Instance.creatComponentByStylename(_loc2_[0]);
         }
         if(_loc2_.length > 1 && _loc2_[1] != "")
         {
            unSelectedTextField = ComponentFactory.Instance.creatComponentByStylename(_loc2_[1]);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_selectedTextField)
         {
            addChild(_selectedTextField);
         }
         if(_unSelectedTextField)
         {
            addChild(_unSelectedTextField);
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         .super.selected = param1;
         if(_selectedTextField)
         {
            _selectedTextField.visible = param1;
         }
         if(_unSelectedTextField)
         {
            _unSelectedTextField.visible = !param1;
         }
         onPropertiesChanged("selected");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         super.onProppertiesUpdate();
         if(_selected && _selectedTextField)
         {
            _selectedTextField.text = _text;
         }
         else if(!_selected && _unSelectedTextField)
         {
            _unSelectedTextField.text = _text;
         }
         if(_autoSizeAble)
         {
            if(_selected && _selectedTextField)
            {
               _loc2_ = _selectedBackgoundInnerRect.getInnerRect(_selectedTextField.textWidth,_selectedTextField.textHeight);
               var _loc3_:* = _loc2_.width;
               _selectedButton.width = _loc3_;
               _width = _loc3_;
               _loc3_ = _loc2_.height;
               _selectedButton.height = _loc3_;
               _height = _loc3_;
               _selectedTextField.x = _selectedBackgoundInnerRect.para1;
               _selectedTextField.y = _selectedBackgoundInnerRect.para3;
            }
            else if(!_selected && _unSelectedTextField)
            {
               upUnselectedButtonPos();
               _loc1_ = _unselectedBackgoundInnerRect.getInnerRect(_unSelectedTextField.textWidth,_unSelectedTextField.textHeight);
               _loc3_ = _loc1_.width;
               _unSelectedButton.width = _loc3_;
               _width = _loc3_;
               _loc3_ = _loc1_.height;
               _unSelectedButton.height = _loc3_;
               _height = _loc3_;
               _unSelectedTextField.x = _unselectedBackgoundInnerRect.para1 + _unSelectedButton.x;
               _unSelectedTextField.y = _unselectedBackgoundInnerRect.para3 + _unSelectedButton.y;
            }
            else if(_selected)
            {
               _width = _selectedButton.width;
               _height = _selectedButton.height;
            }
            else
            {
               upUnselectedButtonPos();
               _width = _unSelectedButton.width;
               _height = _unSelectedButton.height;
            }
         }
         else
         {
            upUnselectedButtonPos();
            _loc3_ = _width;
            _unSelectedButton.width = _loc3_;
            _selectedButton.width = _loc3_;
            _loc3_ = _height;
            _unSelectedButton.height = _loc3_;
            _selectedButton.height = _loc3_;
            if(_selectedTextField)
            {
               _selectedTextField.x = (_width - _selectedTextField.textWidth) / 2;
               _selectedTextField.y = (_height - _selectedTextField.textHeight) / 2;
            }
            if(_unSelectedTextField)
            {
               _unSelectedTextField.x = (_width - _unSelectedTextField.textWidth) / 2;
               _unSelectedTextField.y = (_height - _unSelectedTextField.textHeight) / 2;
            }
         }
      }
      
      private function upUnselectedButtonPos() : void
      {
         if(_unSelectedButton == null || _selectedButton == null)
         {
            return;
         }
         if(_unSelectedButtonOuterRectPos == null)
         {
            return;
         }
         var _loc1_:Point = _unSelectedButtonOuterRectPos.getPos(_unSelectedButton.width,_unSelectedButton.height,_selectedButton.width,_selectedButton.height);
         _unSelectedButton.x = _loc1_.x;
         _unSelectedButton.y = _loc1_.y;
      }
   }
}
