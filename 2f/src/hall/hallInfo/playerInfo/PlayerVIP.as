package hall.hallInfo.playerInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class PlayerVIP extends Sprite
   {
       
      
      private var _expSprite:Sprite;
      
      private var _mask:Sprite;
      
      private var _expBitmap:Bitmap;
      
      private var _expBitmapTip:ScaleFrameImage;
      
      private var _expText:FilterFrameText;
      
      private var _selfInfo:SelfInfo;
      
      private var _vipBtn:ScaleFrameImage;
      
      private var _levelNum:ScaleFrameImage;
      
      public function PlayerVIP(){super();}
      
      private function initEvent() : void{}
      
      protected function __isOpenBtn(param1:Event) : void{}
      
      private function initView() : void{}
      
      private function setVIPState() : void{}
      
      private function createMask() : void{}
      
      private function setVIPProgress() : void{}
      
      private function setExpTipData() : void{}
      
      private function setProgress(param1:int, param2:int) : void{}
      
      private function __showVipFrame(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
