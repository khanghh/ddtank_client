package giftSystem.view
{
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.EmailEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.PlayerPortraitView;
   import email.MailManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import giftSystem.GiftController;
   import giftSystem.GiftManager;
   
   public class GiftBannerView extends Sprite implements Disposeable
   {
       
      
      private var BG:MutipleImage;
      
      private var _portrait:PlayerPortraitView;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _levelBg:Bitmap;
      
      private var _charmNum:FilterFrameText;
      
      private var _levelProgress:GiftPropress;
      
      private var _totalGiftShow:FilterFrameText;
      
      private var _totalGiftShowNum:FilterFrameText;
      
      private var _goEmail:BaseButton;
      
      private var _emailShine:IEffect;
      
      private var _totalGiftBackground:MutipleImage;
      
      private var _totalGiftBackground1:Bitmap;
      
      private var _info:PlayerInfo;
      
      public function GiftBannerView(){super();}
      
      private function init() : void{}
      
      protected function __updateEmail(param1:EmailEvent) : void{}
      
      private function __goToEmail(param1:MouseEvent) : void{}
      
      public function set info(param1:PlayerInfo) : void{}
      
      private function __upView(param1:Event) : void{}
      
      private function upView() : void{}
      
      public function dispose() : void{}
   }
}
