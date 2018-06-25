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
      
      public function GiftBannerView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         BG = ComponentFactory.Instance.creatComponentByStylename("GiftBannerView.BG");
         _portrait = ComponentFactory.Instance.creatCustomObject("gift.GiftBannerPortrait",["right"]);
         _name = ComponentFactory.Instance.creatComponentByStylename("GiftBannerView.name");
         _level = ComponentFactory.Instance.creatComponentByStylename("GiftBannerView.level");
         _levelBg = ComponentFactory.Instance.creatBitmap("asset.ddtgift.level");
         _charmNum = ComponentFactory.Instance.creatComponentByStylename("GiftBannerView.charmNum");
         _levelProgress = ComponentFactory.Instance.creatComponentByStylename("GiftBannerView.levelProgress");
         _totalGiftBackground = ComponentFactory.Instance.creatComponentByStylename("asset.giftBannerView.presentBG");
         _totalGiftBackground1 = ComponentFactory.Instance.creatBitmap("asset.ddtgiftGoodItem.BG1");
         _totalGiftShow = ComponentFactory.Instance.creatComponentByStylename("GiftBannerView.totalGiftShow");
         _totalGiftShowNum = ComponentFactory.Instance.creatComponentByStylename("GiftBannerView.totalGiftShowNum");
         _goEmail = ComponentFactory.Instance.creatComponentByStylename("GiftBannerView.goEmail");
         var data:Object = {};
         data["blurWidth"] = 6;
         data["color"] = "yellow";
         _emailShine = EffectManager.Instance.creatEffect(3,_goEmail,data);
         addChild(BG);
         addChild(_portrait);
         addChild(_name);
         addChild(_level);
         addChild(_levelBg);
         addChild(_charmNum);
         addChild(_levelProgress);
         addChild(_totalGiftBackground);
         addChild(_totalGiftBackground1);
         addChild(_totalGiftShow);
         addChild(_totalGiftShowNum);
         addChild(_goEmail);
      }
      
      protected function __updateEmail(event:EmailEvent) : void
      {
         if(MailManager.Instance.Model.hasUnReadGiftEmail())
         {
            _emailShine.play();
         }
         else
         {
            _emailShine.stop();
         }
      }
      
      private function __goToEmail(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         MailManager.Instance.switchVisible();
         GiftController.Instance.hideGiftFrame();
         MailManager.Instance.isOpenFromBag = true;
      }
      
      public function set info(value:PlayerInfo) : void
      {
         if(_info == value)
         {
            return;
         }
         if(_info)
         {
            _info.removeEventListener("propertychange",__upView);
            PlayerManager.Instance.removeEventListener("selfGiftInfoChange",__upView);
         }
         _info = value;
         _portrait.info = _info;
         _info.addEventListener("propertychange",__upView);
         PlayerManager.Instance.addEventListener("selfGiftInfoChange",__upView);
         if(GiftManager.Instance.canActive)
         {
            __updateEmail(null);
            MailManager.Instance.Model.addEventListener("initEmail",__updateEmail);
         }
         upView();
      }
      
      private function __upView(event:Event) : void
      {
         upView();
      }
      
      private function upView() : void
      {
         _name.text = _info.NickName;
         _level.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftBannerView.giftLvel",_info.charmLevel);
         _charmNum.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.charmNum");
         var current:int = _info.charmGP - PlayerInfo.CHARM_LEVEL_ALL_EXP[_info.charmLevel - 1];
         _totalGiftShow.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftBannerView.giftShow");
         _totalGiftShowNum.text = _info.giftSum.toString();
         _levelProgress.setProgress(current,PlayerInfo.CHARM_LEVEL_NEED_EXP[_info.charmLevel]);
         if(_info.charmLevel == 100)
         {
            _levelProgress.setProgress(1,1);
         }
         if(GiftManager.Instance.canActive)
         {
            _levelProgress.tipStyle = "ddt.view.tips.OneLineTip";
            _levelProgress.tipDirctions = "3,7,6";
            _levelProgress.tipGapV = 4;
            if(current >= 0 && _info.charmLevel < 100)
            {
               _levelProgress.tipData = current + "/" + PlayerInfo.CHARM_LEVEL_NEED_EXP[_info.charmLevel];
            }
            else if(_info.charmLevel == 100)
            {
               _levelProgress.tipData = PlayerInfo.CHARM_LEVEL_NEED_EXP[99] + current + "/" + PlayerInfo.CHARM_LEVEL_NEED_EXP[99];
            }
         }
         _levelProgress.labelText = _info.charmGP.toString();
         if(GiftManager.Instance.canActive && !GiftManager.Instance.inChurch)
         {
            _goEmail.enable = true;
            _goEmail.addEventListener("click",__goToEmail);
         }
         else
         {
            _goEmail.enable = false;
         }
      }
      
      public function dispose() : void
      {
         GiftManager.Instance.inChurch = false;
         _goEmail.removeEventListener("click",__goToEmail);
         _info.removeEventListener("propertychange",__upView);
         MailManager.Instance.Model.removeEventListener("initEmail",__updateEmail);
         PlayerManager.Instance.removeEventListener("selfGiftInfoChange",__upView);
         if(BG)
         {
            ObjectUtils.disposeObject(BG);
         }
         BG = null;
         if(_portrait)
         {
            _portrait.dispose();
         }
         _portrait = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_level)
         {
            ObjectUtils.disposeObject(_level);
         }
         _level = null;
         if(_levelBg)
         {
            ObjectUtils.disposeObject(_levelBg);
         }
         _levelBg = null;
         if(_charmNum)
         {
            ObjectUtils.disposeObject(_charmNum);
         }
         _charmNum = null;
         if(_levelProgress)
         {
            ObjectUtils.disposeObject(_levelProgress);
         }
         _levelProgress = null;
         if(_totalGiftBackground)
         {
            ObjectUtils.disposeObject(_totalGiftBackground);
         }
         _totalGiftBackground = null;
         if(_totalGiftBackground1)
         {
            ObjectUtils.disposeObject(_totalGiftBackground1);
         }
         _totalGiftBackground1 = null;
         if(_totalGiftShow)
         {
            ObjectUtils.disposeObject(_totalGiftShow);
         }
         _totalGiftShow = null;
         if(_goEmail)
         {
            ObjectUtils.disposeObject(_goEmail);
         }
         _goEmail = null;
         if(_emailShine)
         {
            EffectManager.Instance.removeEffect(_emailShine);
         }
         _emailShine = null;
         if(_totalGiftShowNum)
         {
            ObjectUtils.disposeObject(_totalGiftShowNum);
         }
         _totalGiftShowNum = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
