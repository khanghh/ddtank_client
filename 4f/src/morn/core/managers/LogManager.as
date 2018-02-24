package morn.core.managers
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import morn.core.utils.ObjectUtils;
   
   public class LogManager extends Sprite
   {
       
      
      private var _msgs:Array;
      
      private var _box:Sprite;
      
      private var _textField:TextField;
      
      private var _filter:TextField;
      
      private var _filters:Array;
      
      private var _canScroll:Boolean = true;
      
      private var _scroll:TextField;
      
      public function LogManager(){super();}
      
      private function onAddedToStage(param1:Event) : void{}
      
      private function createLinkButton(param1:String) : TextField{return null;}
      
      private function onCopyClick(param1:MouseEvent) : void{}
      
      private function onScrollClick(param1:MouseEvent) : void{}
      
      private function onClearClick(param1:MouseEvent) : void{}
      
      private function onFilterKeyDown(param1:KeyboardEvent) : void{}
      
      private function onFilterFocusOut(param1:FocusEvent) : void{}
      
      private function onStageKeyDown(param1:KeyboardEvent) : void{}
      
      public function clear() : void{}
      
      public function info(... rest) : void{}
      
      public function echo(... rest) : void{}
      
      public function debug(... rest) : void{}
      
      public function error(... rest) : void{}
      
      public function warn(... rest) : void{}
      
      public function print(param1:String, param2:Array, param3:uint) : void{}
      
      public function toggle() : void{}
      
      private function refresh(param1:String) : void{}
      
      private function isFilter(param1:String) : Boolean{return false;}
   }
}
