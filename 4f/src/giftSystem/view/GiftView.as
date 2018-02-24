package giftSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Sprite;
   
   public class GiftView extends Sprite implements Disposeable
   {
       
      
      private var _giftInfoView:GiftInfoView;
      
      private var _giftShopView:GiftShopView;
      
      private var _helpBtn:BaseButton;
      
      private var _info:PlayerInfo;
      
      public function GiftView(){super();}
      
      public function set info(param1:PlayerInfo) : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
