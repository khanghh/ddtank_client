package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [Event(name="select",type="flash.events.Event")]
   public class SelectedButton extends BaseButton implements ISelectable
   {
      
      public static const P_selectedStyle:String = "selectedStyle";
      
      public static const P_unSelectedStyle:String = "unSelectedStyle";
      
      public static const P_selected:String = "selected";
       
      
      protected var _selected:Boolean;
      
      protected var _selectedButton:DisplayObject;
      
      protected var _selectedStyle:String;
      
      protected var _unSelectedButton:DisplayObject;
      
      protected var _unSelectedStyle:String;
      
      private var _autoSelect:Boolean = true;
      
      private var _selectHitArea:Sprite;
      
      private var _unSelectHitArea:Sprite;
      
      public function SelectedButton(){super();}
      
      public function set autoSelect(param1:Boolean) : void{}
      
      override public function dispose() : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get selectedStyle() : String{return null;}
      
      public function set selectedStyle(param1:String) : void{}
      
      override public function setFrame(param1:int) : void{}
      
      public function setSelectedButton(param1:DisplayObject) : void{}
      
      public function setUnselectedButton(param1:DisplayObject) : void{}
      
      public function get unSelectedStyle() : String{return null;}
      
      public function set unSelectedStyle(param1:String) : void{}
      
      override protected function __onMouseClick(param1:MouseEvent) : void{}
      
      override protected function adaptHitArea() : void{}
      
      override protected function addChildren() : void{}
      
      override protected function drawHitArea() : void{}
      
      override protected function onProppertiesUpdate() : void{}
   }
}
