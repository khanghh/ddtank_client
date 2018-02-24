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
      
      public function SelectedTextButton(){super();}
      
      public function set unSelectedButtonOuterRectPosString(param1:String) : void{}
      
      public function set backgoundInnerRectString(param1:String) : void{}
      
      override public function dispose() : void{}
      
      public function set text(param1:String) : void{}
      
      public function set selectedTextField(param1:TextField) : void{}
      
      public function set unSelectedTextField(param1:TextField) : void{}
      
      public function set textStyle(param1:String) : void{}
      
      override protected function addChildren() : void{}
      
      override public function set selected(param1:Boolean) : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      private function upUnselectedButtonPos() : void{}
   }
}
