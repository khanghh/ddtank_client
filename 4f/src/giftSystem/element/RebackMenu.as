package giftSystem.element
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.data.RecordItemInfo;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import giftSystem.GiftManager;
   
   public class RebackMenu extends Sprite
   {
      
      private static var _instance:RebackMenu;
       
      
      private var _BG:Bitmap;
      
      private var _rebackBtn:BaseButton;
      
      private var _checkBtn:BaseButton;
      
      private var _info:RecordItemInfo;
      
      public function RebackMenu(){super();}
      
      public static function get Instance() : RebackMenu{return null;}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __mouseClick(param1:MouseEvent) : void{}
      
      private function __check(param1:MouseEvent) : void{}
      
      private function __reback(param1:MouseEvent) : void{}
      
      public function show(param1:RecordItemInfo, param2:int, param3:int) : void{}
      
      public function hide() : void{}
   }
}
