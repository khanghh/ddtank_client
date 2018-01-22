package com.pickgliss.ui.core
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DisplayUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SpriteLayer extends Sprite
   {
       
      
      private var _blackGoundList:Vector.<DisplayObject>;
      
      private var _alphaGoundList:Vector.<DisplayObject>;
      
      private var _blackGound:Sprite;
      
      private var _alphaGound:Sprite;
      
      private var _autoClickTotop:Boolean;
      
      public function SpriteLayer(param1:Boolean = false){super();}
      
      private function init() : void{}
      
      public function addTolayer(param1:DisplayObject, param2:int, param3:Boolean) : void{}
      
      private function __onClickToTop(param1:MouseEvent) : void{}
      
      private function __onFocusChange(param1:Event) : void{}
      
      private function __onChildRemoveFromStage(param1:Event) : void{}
      
      private function arrangeBlockGound() : void{}
      
      private function focusTopLayerDisplay(param1:DisplayObject = null) : void{}
      
      public function get backGroundInParent() : Boolean{return false;}
      
      private function get blackGound() : Sprite{return null;}
      
      private function __onBlackGoundMouseDown(param1:MouseEvent) : void{}
      
      private function get alphaGound() : Sprite{return null;}
      
      private function __onAlphaGoundDownClicked(param1:MouseEvent) : void{}
      
      private function __onAlphaGoundUpClicked(param1:MouseEvent) : void{}
      
      public function set autoClickTotop(param1:Boolean) : void{}
   }
}
