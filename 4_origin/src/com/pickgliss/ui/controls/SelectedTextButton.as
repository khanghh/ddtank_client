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
      
      public function set unSelectedButtonOuterRectPosString(value:String) : void
      {
         if(_unSelectedButtonOuterRectPosString == value)
         {
            return;
         }
         _unSelectedButtonOuterRectPosString = value;
         _unSelectedButtonOuterRectPos = ClassUtils.CreatInstance("com.pickgliss.geom.OuterRectPos",ComponentFactory.parasArgs(_unSelectedButtonOuterRectPosString));
         onPropertiesChanged("unSelectedButtonOuterRectPos");
      }
      
      public function set backgoundInnerRectString(value:String) : void
      {
         if(_backgoundInnerRectString == value)
         {
            return;
         }
         _backgoundInnerRectString = value;
         var rectsData:Array = ComponentFactory.parasArgs(_backgoundInnerRectString);
         if(rectsData.length > 0 && rectsData[0] != "")
         {
            _selectedBackgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",String(rectsData[0]).split("|"));
         }
         if(rectsData.length > 1 && rectsData[1] != "")
         {
            _unselectedBackgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",String(rectsData[1]).split("|"));
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
      
      public function set text(value:String) : void
      {
         if(_text == value)
         {
            return;
         }
         _text = value;
         onPropertiesChanged("text");
      }
      
      public function set selectedTextField(field:TextField) : void
      {
         if(_selectedTextField == field)
         {
            return;
         }
         ObjectUtils.disposeObject(_selectedTextField);
         _selectedTextField = field;
         onPropertiesChanged("selectedtextField");
      }
      
      public function set unSelectedTextField(field:TextField) : void
      {
         if(_unSelectedTextField == field)
         {
            return;
         }
         ObjectUtils.disposeObject(_unSelectedTextField);
         _unSelectedTextField = field;
         onPropertiesChanged("unselectedtextField");
      }
      
      public function set textStyle(stylename:String) : void
      {
         if(_textStyle == stylename)
         {
            return;
         }
         _textStyle = stylename;
         var styles:Array = ComponentFactory.parasArgs(stylename);
         if(styles.length > 0 && styles[0] != "")
         {
            selectedTextField = ComponentFactory.Instance.creatComponentByStylename(styles[0]);
         }
         if(styles.length > 1 && styles[1] != "")
         {
            unSelectedTextField = ComponentFactory.Instance.creatComponentByStylename(styles[1]);
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
      
      override public function set selected(value:Boolean) : void
      {
         .super.selected = value;
         if(_selectedTextField)
         {
            _selectedTextField.visible = value;
         }
         if(_unSelectedTextField)
         {
            _unSelectedTextField.visible = !value;
         }
         onPropertiesChanged("selected");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var rectangleSe:* = null;
         var rectangleUnSe:* = null;
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
               rectangleSe = _selectedBackgoundInnerRect.getInnerRect(_selectedTextField.textWidth,_selectedTextField.textHeight);
               var _loc3_:* = rectangleSe.width;
               _selectedButton.width = _loc3_;
               _width = _loc3_;
               _loc3_ = rectangleSe.height;
               _selectedButton.height = _loc3_;
               _height = _loc3_;
               _selectedTextField.x = _selectedBackgoundInnerRect.para1;
               _selectedTextField.y = _selectedBackgoundInnerRect.para3;
            }
            else if(!_selected && _unSelectedTextField)
            {
               upUnselectedButtonPos();
               rectangleUnSe = _unselectedBackgoundInnerRect.getInnerRect(_unSelectedTextField.textWidth,_unSelectedTextField.textHeight);
               _loc3_ = rectangleUnSe.width;
               _unSelectedButton.width = _loc3_;
               _width = _loc3_;
               _loc3_ = rectangleUnSe.height;
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
         var posRect:Point = _unSelectedButtonOuterRectPos.getPos(_unSelectedButton.width,_unSelectedButton.height,_selectedButton.width,_selectedButton.height);
         _unSelectedButton.x = posRect.x;
         _unSelectedButton.y = posRect.y;
      }
   }
}
