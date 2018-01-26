package ddt.view.buff.buffButton
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.view.tips.BuffTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BuffButton extends Sprite implements Disposeable, ITipedDisplay
   {
      
      protected static var Setting:Boolean = false;
       
      
      protected var _info:BuffInfo;
      
      private var _canClick:Boolean;
      
      protected var _tipStyle:String;
      
      protected var _tipData:BuffTipInfo;
      
      protected var _tipDirctions:String;
      
      protected var _tipGapV:int;
      
      protected var _tipGapH:int;
      
      public function BuffButton(param1:String){super();}
      
      public static function createBuffButton(param1:int, param2:String = "") : BuffButton{return null;}
      
      private function initEvents() : void{}
      
      protected function __onclick(param1:MouseEvent) : void{}
      
      protected function __onMouseOver(param1:MouseEvent) : void{}
      
      protected function __onMouseOut(param1:MouseEvent) : void{}
      
      protected function checkBagLocked() : Boolean{return false;}
      
      protected function buyBuff(param1:Boolean = true) : void{}
      
      protected function createTipRender() : Sprite{return null;}
      
      public function setSize(param1:Number, param2:Number) : void{}
      
      private function updateView() : void{}
      
      public function set CanClick(param1:Boolean) : void{}
      
      public function get CanClick() : Boolean{return false;}
      
      public function set info(param1:BuffInfo) : void{}
      
      public function get info() : BuffInfo{return null;}
      
      protected function __onBuyResponse(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      public function dispose() : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function set tipGapH(param1:int) : void{}
   }
}
