package ddt.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SimpleReturnBar extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _stretchBtn:SelectedButton;
      
      private var _returnBtn:BaseButton;
      
      private var _returnCall:Function;
      
      public var stopTo:Number;
      
      public var moveTo:Number;
      
      public function SimpleReturnBar(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __onStretchBtnClick(param1:MouseEvent) : void{}
      
      private function __onReturnClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function set returnCall(param1:Function) : void{}
      
      public function dispose() : void{}
   }
}
