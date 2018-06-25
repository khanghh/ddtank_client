package com.pickgliss.ui.core{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DisplayUtils;   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class SpriteLayer extends Sprite   {                   private var _blackGoundList:Vector.<DisplayObject>;            private var _alphaGoundList:Vector.<DisplayObject>;            private var _blackGound:Sprite;            private var _alphaGound:Sprite;            private var _autoClickTotop:Boolean;            public function SpriteLayer(enableMouse:Boolean = false) { super(); }
            private function init() : void { }
            public function addTolayer(child:DisplayObject, blockGound:int, focusTop:Boolean) : void { }
            private function __onClickToTop(event:MouseEvent) : void { }
            private function __onFocusChange(event:Event) : void { }
            private function __onChildRemoveFromStage(event:Event) : void { }
            private function arrangeBlockGound() : void { }
            private function focusTopLayerDisplay(exclude:DisplayObject = null) : void { }
            public function get backGroundInParent() : Boolean { return false; }
            private function get blackGound() : Sprite { return null; }
            private function __onBlackGoundMouseDown(event:MouseEvent) : void { }
            private function get alphaGound() : Sprite { return null; }
            private function __onAlphaGoundDownClicked(event:MouseEvent) : void { }
            private function __onAlphaGoundUpClicked(event:MouseEvent) : void { }
            public function set autoClickTotop(value:Boolean) : void { }
   }}