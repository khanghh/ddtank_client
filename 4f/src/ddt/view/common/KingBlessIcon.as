package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import kingBless.KingBlessManager;
   
   public class KingBlessIcon extends Sprite implements ITipedDisplay, Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _isOpen:Boolean;
      
      private var _isSelf:Boolean;
      
      public function KingBlessIcon(param1:int){super();}
      
      protected function __openKingBlessFrameHandlder(param1:MouseEvent) : void{}
      
      private function updateIcon() : void{}
      
      public function dispose() : void{}
      
      public function get tipStyle() : String{return null;}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __refreshBtnState(param1:Event) : void{}
      
      public function setInfo(param1:Boolean, param2:Boolean) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function get tipDirctions() : String{return null;}
      
      public function get tipGapV() : int{return 0;}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function set tipData(param1:Object) : void{}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function set tipGapV(param1:int) : void{}
      
      public function set tipGapH(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
