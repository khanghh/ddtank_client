package bagAndInfo
{
   import AvatarCollection.AvatarCollectionManager;
   import bagAndInfo.info.PlayerInfoViewControl;
   import beadSystem.beadSystemManager;
   import beadSystem.data.BeadEvent;
   import cardSystem.CardSocketEvent;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.DraftManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.MainToolBar;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.tips.OneLineTip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import giftSystem.GiftManager;
   import hall.tasktrack.HallTaskGuideManager;
   import homeTemple.HomeTempleManager;
   import magicStone.MagicStoneManager;
   import magicStone.event.MagicStoneEvent;
   import mark.MarkMgr;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.view.item.AddPetItem;
   import powerUp.PowerUpMovieManager;
   import pvePowerBuff.PvePowerBuffEvent;
   import pvePowerBuff.PvePowerBuffManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import totem.TotemManager;
   import trainer.view.NewHandContainer;
   
   public class BagAndGiftFrame extends Frame
   {
      
      public static const BAGANDINFO:int = 0;
      
      public static const GIFTVIEW:int = 1;
      
      public static const CARDVIEW:int = 2;
      
      public static const TEXPVIEW:int = 3;
      
      public static const EFFORT:int = 4;
      
      public static const PETVIEW:int = 5;
      
      public static const BEADVIEW:int = 21;
      
      public static const TOTEMVIEW:int = 6;
      
      public static const AVATARCOLLECTIONVIEW:int = 7;
      
      public static const DRESSVIEW:int = 8;
      
      public static const MAGICSTONEVIEW:int = 9;
      
      public static const GOD_TEMPLE:int = 10;
      
      public static const PVEPOWERBUFF_VIEW:int = 11;
      
      public static const MARK:int = 12;
      
      public static const BEAD_CHANGE:String = "beadChanged";
      
      private static const TEXP_OPEN_LEVEL:int = 13;
      
      private static const GIFT_OPEN_LEVEL:int = 16;
      
      private static const CARD_OPEN_LEVEL:int = 15;
      
      private static const PET_OPEN_LEVEL:int = 25;
      
      private static const TOTEM_OPEN_LEVEL:int = 22;
      
      private static const BEAD_OPEN_LEVEL:int = 16;
      
      private static const AVATAR_COLLECTION_OPEN_LEVEL:int = 10;
      
      private static const MAGIC_STONE_LEVEL:int = 40;
      
      private static const GOD_TEMPLE_LEVEL:int = 35;
      
      private static var _firstOpenCard:Boolean = true;
      
      private static var _isFirstEfforOpen:Boolean = true;
      
      private static var _firstOpenGift:Boolean = true;
      
      private static var _isFirstOpenBead:Boolean = true;
       
      
      private var _infoFrame:BagAndInfoFrame;
      
      private var _magicStoneMainView:Sprite;
      
      private var _BG:ScaleBitmapImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _infoBtn:SelectedButton;
      
      private var _texpBtn:SelectedButton;
      
      private var _texpBtnTip:OneLineTip;
      
      private var _texpBtnSprite:Sprite;
      
      private var _texpBtnShine:IEffect;
      
      private var _giftBtn:SelectedButton;
      
      private var _giftBtnShine:IEffect;
      
      private var _giftBtnTip:OneLineTip;
      
      private var _giftBtnSprite:Sprite;
      
      private var _petBtn:SelectedButton;
      
      private var _petBtnSprite:Sprite;
      
      private var _petBtnShine:IEffect;
      
      private var _petBtnTip:OneLineTip;
      
      private var _totemBtn:SelectedButton;
      
      private var _totemBtnSprite:Sprite;
      
      private var _totemBtnShine:IEffect;
      
      private var _totemBtnTip:OneLineTip;
      
      private var _beadBtn:SelectedButton;
      
      private var _beadBtnSprite:Sprite;
      
      private var _beadBtnShine:IEffect;
      
      private var _beadBtnTip:OneLineTip;
      
      private var _cardBtn:SelectedButton;
      
      private var _cardBtnSprite:Sprite;
      
      private var _cardBtnTip:OneLineTip;
      
      private var _avatarCollBtn:SelectedButton;
      
      private var _avatarCollBtnSprite:Sprite;
      
      private var _avatarCollBtnShine:IEffect;
      
      private var _avatarCollBtnTip:OneLineTip;
      
      private var _magicStoneBtn:SelectedButton;
      
      private var _magicStoneBtnSprite:Sprite;
      
      private var _magicStoneBtnShine:IEffect;
      
      private var _magicStoneBtnTip:OneLineTip;
      
      private var _godTempleBtn:SelectedButton;
      
      private var _godTempleBtnSprite:Sprite;
      
      private var _godTempleBtnShine:IEffect;
      
      private var _godTempleBtnTip:OneLineTip;
      
      private var _markBtnTip:OneLineTip;
      
      private var _markBtnSprite:Sprite;
      
      private var _pvePowerBuffBtn:SelectedButton;
      
      private var _pvePowerBuffBtnSprite:Sprite;
      
      private var _pvePowerBuffBtnShine:IEffect;
      
      private var _pvePowerBuffBtnTip:OneLineTip;
      
      private var _pvePowerBuffMainView:Sprite;
      
      private var _selectedBtnsHBox:HBox;
      
      private var _markBtn:SelectedButton;
      
      private var _markHelpBtn:BaseButton;
      
      private var _bagType:int = 0;
      
      private var _frame:BaseAlerFrame;
      
      private var _fightPower:int;
      
      public function BagAndGiftFrame()
      {
         BagAndInfoManager.Instance.isInBagAndInfoView = true;
         super();
         escEnable = true;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.bag");
         _BG = ComponentFactory.Instance.creatComponentByStylename("bagAndInfoFrame.bg1");
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.infoBtn1");
         _texpBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.texpBtn1");
         _cardBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.cardBtn");
         _totemBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.totemBtn1");
         _beadBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.BeadBtn");
         _avatarCollBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.avatarCollBtn1");
         _magicStoneBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.magicStoneBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_magicStoneBtn,40,"tips.open");
         _godTempleBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.godTempleBtn");
         _pvePowerBuffBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.pvepowerbuffBtn");
         _markBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.markBtn");
         _markHelpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"mark.btnHelp",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.markHelpInfo",463,550);
         _giftBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.giftBtn1");
         _petBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndGiftFrame.PetBtn");
         addToContent(_BG);
         addToContent(_infoBtn);
         addToContent(_texpBtn);
         addToContent(_cardBtn);
         addToContent(_totemBtn);
         addToContent(_beadBtn);
         addToContent(_avatarCollBtn);
         addToContent(_magicStoneBtn);
         addToContent(_godTempleBtn);
         addToContent(_pvePowerBuffBtn);
         addToContent(_markBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_infoBtn);
         _btnGroup.addSelectItem(_giftBtn);
         _btnGroup.addSelectItem(_texpBtn);
         _btnGroup.addSelectItem(_petBtn);
         _btnGroup.addSelectItem(_cardBtn);
         _btnGroup.addSelectItem(_totemBtn);
         _btnGroup.addSelectItem(_beadBtn);
         _btnGroup.addSelectItem(_avatarCollBtn);
         _btnGroup.addSelectItem(_magicStoneBtn);
         _btnGroup.addSelectItem(_godTempleBtn);
         _btnGroup.addSelectItem(_pvePowerBuffBtn);
         _btnGroup.addSelectItem(_markBtn);
         texpBtnEnable();
         cardBtnEnable();
         totemBtnEnable();
         beadBtnEnable();
         avatarCollBtnEnable();
         magicStoneBtnEnable();
         godTempleBtnEnable();
         pvePowerBuffEnable();
         markBtnEnable();
         if(PetsBagManager.instance().haveTaskOrderByID(368))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(94);
            PetsBagManager.instance().showPetFarmGuildArrow(95,-150,"farmTrainer.openPetLabelArrowPos","asset.farmTrainer.clickHere","farmTrainer.openPetLabelTipPos");
         }
         texpGuide();
         beadGuide();
         totemGuide();
         templeGuide();
         shGuide();
      }
      
      private function shGuide() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(143))
         {
            if(PlayerManager.Instance.Self.Grade >= 10 && TaskManager.instance.isAvailable(TaskManager.instance.getQuestByID(327)))
            {
               NewHandContainer.Instance.showArrow(201,180,new Point(597,235),"asset.trainer.txtWeaponTip","asset.trainer.shoushi.txtPos",LayerManager.Instance.getLayerByType(2));
            }
         }
      }
      
      private function texpGuide() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            if(PlayerManager.Instance.Self.Grade == 13 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(7)))
            {
               NewHandContainer.Instance.showArrow(140,180,new Point(202,157),"","",LayerManager.Instance.getLayerByType(2));
            }
         }
      }
      
      private function beadGuide() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(126))
         {
            if(PlayerManager.Instance.Self.Grade == 16 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(29)))
            {
               NewHandContainer.Instance.showArrow(142,180,new Point(534,157),"","",LayerManager.Instance.getLayerByType(2));
            }
         }
      }
      
      private function totemGuide() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(101))
         {
            if(PlayerManager.Instance.Self.Grade >= 22)
            {
               NewHandContainer.Instance.showArrow(145,180,new Point(372,157),"","",LayerManager.Instance.getLayerByType(2));
            }
         }
      }
      
      private function templeGuide() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(139))
         {
            if(PlayerManager.Instance.Self.Grade >= 35)
            {
               NewHandContainer.Instance.showArrow(149,180,new Point(714,157),"","",LayerManager.Instance.getLayerByType(2));
            }
         }
      }
      
      public function get btnGroup() : SelectedButtonGroup
      {
         return _btnGroup;
      }
      
      private function markBtnEnable() : void
      {
         if(MarkMgr.inst.checkMarkOpen())
         {
            _markBtn.enable = true;
            ObjectUtils.disposeObject(_markBtnSprite);
            _markBtnSprite = null;
         }
         else
         {
            _markBtn.enable = false;
            if(_markBtnSprite == null)
            {
               _markBtnSprite = new Sprite();
               _markBtnSprite.graphics.beginFill(0,0);
               _markBtnSprite.graphics.drawRect(0,0,_markBtn.displayWidth - 12,_markBtn.displayHeight);
               _markBtnSprite.graphics.endFill();
               _markBtnSprite.x = _markBtn.x + 17;
               _markBtnSprite.y = _markBtn.y + 3;
               addToContent(_markBtnSprite);
               _markBtnTip = new OneLineTip();
               _markBtnTip.tipData = LanguageMgr.GetTranslation("mark.openTips",ServerConfigManager.instance.markOpenLevel,ServerConfigManager.instance.markOpenLevel);
               _markBtnTip.visible = false;
               _markBtnSprite.addEventListener("rollOver",__markOverHandler);
               _markBtnSprite.addEventListener("rollOut",__markOutHandler);
            }
         }
      }
      
      private function __markOverHandler(param1:MouseEvent) : void
      {
         _markBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_markBtnTip,2);
         var _loc2_:Point = _markBtn.localToGlobal(new Point(0,0));
         _markBtnTip.x = _loc2_.x - _markBtnTip.width * 0.5;
         _markBtnTip.y = _loc2_.y + _markBtn.height;
      }
      
      private function __markOutHandler(param1:MouseEvent) : void
      {
         if(_markBtnTip)
         {
            _markBtnTip.visible = false;
         }
      }
      
      private function pvePowerBuffEnable() : void
      {
         if(PlayerManager.Instance.Self.Grade >= ServerConfigManager.instance.pvePowerBuffLevelLimit)
         {
            _pvePowerBuffBtn.enable = true;
            ObjectUtils.disposeObject(_pvePowerBuffBtnSprite);
            _pvePowerBuffBtnSprite = null;
         }
         else
         {
            _pvePowerBuffBtn.enable = false;
            if(_pvePowerBuffBtnSprite == null)
            {
               _pvePowerBuffBtnSprite = new Sprite();
               _pvePowerBuffBtnSprite.graphics.beginFill(0,0);
               _pvePowerBuffBtnSprite.graphics.drawRect(0,0,_pvePowerBuffBtn.displayWidth - 12,_pvePowerBuffBtn.displayHeight);
               _pvePowerBuffBtnSprite.graphics.endFill();
               _pvePowerBuffBtnSprite.x = _pvePowerBuffBtn.x + 17;
               _pvePowerBuffBtnSprite.y = _pvePowerBuffBtn.y + 3;
               addToContent(_pvePowerBuffBtnSprite);
               _pvePowerBuffBtnTip = new OneLineTip();
               _pvePowerBuffBtnTip.tipData = LanguageMgr.GetTranslation("ddt.pvePowerBuff.openPvePowerBuffBtn.text",ServerConfigManager.instance.pvePowerBuffLevelLimit);
               _pvePowerBuffBtnTip.visible = false;
               _pvePowerBuffBtnSprite.addEventListener("rollOver",__pvePowerBuffOverHandler);
               _pvePowerBuffBtnSprite.addEventListener("rollOut",__pvePowerBuffOutHandler);
            }
         }
      }
      
      private function __pvePowerBuffOverHandler(param1:MouseEvent) : void
      {
         _pvePowerBuffBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_pvePowerBuffBtnTip,2);
         var _loc2_:Point = _pvePowerBuffBtn.localToGlobal(new Point(0,0));
         _pvePowerBuffBtnTip.x = _loc2_.x;
         _pvePowerBuffBtnTip.y = _loc2_.y + 45;
      }
      
      private function __pvePowerBuffOutHandler(param1:MouseEvent) : void
      {
         if(_pvePowerBuffBtnTip)
         {
            _pvePowerBuffBtnTip.visible = false;
         }
      }
      
      private function godTempleBtnEnable() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 35)
         {
            _godTempleBtn.enable = true;
            ObjectUtils.disposeObject(_godTempleBtnSprite);
            _godTempleBtnSprite = null;
         }
         else
         {
            _godTempleBtn.enable = false;
            if(_godTempleBtnSprite == null)
            {
               _godTempleBtnSprite = new Sprite();
               _godTempleBtnSprite.graphics.beginFill(0,0);
               _godTempleBtnSprite.graphics.drawRect(0,0,_godTempleBtn.displayWidth - 12,_godTempleBtn.displayHeight);
               _godTempleBtnSprite.graphics.endFill();
               _godTempleBtnSprite.x = _godTempleBtn.x + 17;
               _godTempleBtnSprite.y = _godTempleBtn.y + 3;
               addToContent(_godTempleBtnSprite);
               _godTempleBtnTip = new OneLineTip();
               _godTempleBtnTip.tipData = LanguageMgr.GetTranslation("ddt.godTemple.openGodTempleBtn.text",35);
               _godTempleBtnTip.visible = false;
               _godTempleBtnSprite.addEventListener("rollOver",__godTempleOverHandler);
               _godTempleBtnSprite.addEventListener("rollOut",__godTempleOutHandler);
            }
         }
      }
      
      private function __godTempleOverHandler(param1:MouseEvent) : void
      {
         _godTempleBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_godTempleBtnTip,2);
         var _loc2_:Point = _godTempleBtn.localToGlobal(new Point(0,0));
         _godTempleBtnTip.x = _loc2_.x;
         _godTempleBtnTip.y = _loc2_.y + _godTempleBtn.height;
      }
      
      private function __godTempleOutHandler(param1:MouseEvent) : void
      {
         if(_godTempleBtnTip)
         {
            _godTempleBtnTip.visible = false;
         }
      }
      
      private function magicStoneBtnEnable() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade >= 40)
         {
            _magicStoneBtn.enable = true;
            ObjectUtils.disposeObject(_magicStoneBtnSprite);
            _magicStoneBtnSprite = null;
            if(!PlayerManager.Instance.Self.isNewOnceFinish(108) && !GiftManager.Instance.inChurch)
            {
               _loc1_ = {};
               _loc1_["color"] = "gold";
               _magicStoneBtnShine = EffectManager.Instance.creatEffect(3,_magicStoneBtn,_loc1_);
               _magicStoneBtnShine.play();
               MagicStoneManager.instance.weakGuide(3);
            }
         }
         else
         {
            _magicStoneBtn.enable = false;
            if(_magicStoneBtnSprite == null)
            {
               _magicStoneBtnSprite = new Sprite();
               _magicStoneBtnSprite.graphics.beginFill(0,0);
               _magicStoneBtnSprite.graphics.drawRect(0,0,_magicStoneBtn.displayWidth - 12,_magicStoneBtn.displayHeight);
               _magicStoneBtnSprite.graphics.endFill();
               _magicStoneBtnSprite.x = _magicStoneBtn.x + 17;
               _magicStoneBtnSprite.y = _magicStoneBtn.y + 3;
               addToContent(_magicStoneBtnSprite);
               _magicStoneBtnTip = new OneLineTip();
               _magicStoneBtnTip.tipData = LanguageMgr.GetTranslation("ddt.magicStoneSystem.openMagicStoneBtn.text",40);
               _magicStoneBtnTip.visible = false;
               _magicStoneBtnSprite.addEventListener("mouseOver",__magicStoneOverHandler);
               _magicStoneBtnSprite.addEventListener("mouseOut",__magicStoneOutHandler);
            }
         }
      }
      
      private function __magicStoneOverHandler(param1:MouseEvent) : void
      {
         _magicStoneBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_magicStoneBtnTip,2);
         var _loc2_:Point = _magicStoneBtn.localToGlobal(new Point(0,0));
         _magicStoneBtnTip.x = _loc2_.x;
         _magicStoneBtnTip.y = _loc2_.y + _magicStoneBtn.height;
      }
      
      private function __magicStoneOutHandler(param1:MouseEvent) : void
      {
         if(_magicStoneBtnTip)
         {
            _magicStoneBtnTip.visible = false;
         }
      }
      
      private function avatarCollBtnEnable() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            _avatarCollBtn.enable = true;
            if(_avatarCollBtnSprite)
            {
               ObjectUtils.disposeObject(_avatarCollBtnSprite);
               _avatarCollBtnSprite = null;
            }
            if(!PlayerManager.Instance.Self.isNewOnceFinish(106) && !GiftManager.Instance.inChurch)
            {
               _loc1_ = {};
               _loc1_["color"] = "gold";
               _avatarCollBtnShine = EffectManager.Instance.creatEffect(3,_avatarCollBtn,_loc1_);
               _avatarCollBtnShine.play();
            }
         }
         else
         {
            _avatarCollBtn.enable = false;
            if(!_avatarCollBtnSprite)
            {
               _avatarCollBtnSprite = new Sprite();
               _avatarCollBtnSprite.addEventListener("mouseOver",__avatarCollBtnOverHandler);
               _avatarCollBtnSprite.addEventListener("mouseOut",__avatarCollBtnOutHandler);
               _avatarCollBtnSprite.graphics.beginFill(0,0);
               _avatarCollBtnSprite.graphics.drawRect(0,0,_avatarCollBtn.displayWidth - 12,_avatarCollBtn.displayHeight);
               _avatarCollBtnSprite.graphics.endFill();
               _avatarCollBtnSprite.x = _avatarCollBtn.x + 17;
               _avatarCollBtnSprite.y = _avatarCollBtn.y + 3;
               addToContent(_avatarCollBtnSprite);
               _avatarCollBtnTip = new OneLineTip();
               _avatarCollBtnTip.tipData = LanguageMgr.GetTranslation("ddt.avatarCollSystem.openAvatarCollBtn.text",10);
               _avatarCollBtnTip.visible = false;
            }
         }
      }
      
      private function __avatarCollBtnOverHandler(param1:MouseEvent) : void
      {
         _avatarCollBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_avatarCollBtnTip,2);
         var _loc2_:Point = _avatarCollBtn.localToGlobal(new Point(0,0));
         _avatarCollBtnTip.x = _loc2_.x - 12;
         _avatarCollBtnTip.y = _loc2_.y + _avatarCollBtn.height;
      }
      
      private function __avatarCollBtnOutHandler(param1:MouseEvent) : void
      {
         _avatarCollBtnTip.visible = false;
      }
      
      private function GiftbtnEnable() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade >= 16 || GiftManager.Instance.inChurch == true)
         {
            _giftBtn.enable = true;
            if(_giftBtnSprite)
            {
               ObjectUtils.disposeObject(_giftBtnSprite);
            }
            _giftBtnSprite = null;
            if(SharedManager.Instance.giftFirstShow)
            {
               _loc1_ = {};
               _loc1_["color"] = "gold";
               _giftBtnShine = EffectManager.Instance.creatEffect(3,_giftBtn,_loc1_);
               _giftBtnShine.play();
            }
         }
         else
         {
            _giftBtn.enable = false;
            if(_giftBtnSprite == null)
            {
               _giftBtnSprite = new Sprite();
               _giftBtnSprite.graphics.beginFill(0,0);
               _giftBtnSprite.graphics.drawRect(0,0,_giftBtn.displayWidth,_giftBtn.displayHeight);
               _giftBtnSprite.graphics.endFill();
               _giftBtnSprite.x = _giftBtn.x + 49;
               _giftBtnSprite.y = _giftBtn.y + 3;
               addToContent(_giftBtnSprite);
               _giftBtnTip = new OneLineTip();
               _giftBtnTip.tipData = LanguageMgr.GetTranslation("ddt.giftSystem.openGiftBtn.text");
               _giftBtnTip.visible = false;
               _giftBtnSprite.addEventListener("mouseOver",__overHandler);
               _giftBtnSprite.addEventListener("mouseOut",__outHandler);
            }
         }
      }
      
      private function texpBtnEnable() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade >= 13)
         {
            _texpBtn.enable = true;
            if(_texpBtnSprite)
            {
               ObjectUtils.disposeObject(_texpBtnSprite);
               _texpBtnSprite = null;
            }
            if(SharedManager.Instance.texpSystemShow && !GiftManager.Instance.inChurch)
            {
               _loc1_ = {};
               _loc1_["color"] = "gold";
               _texpBtnShine = EffectManager.Instance.creatEffect(3,_texpBtn,_loc1_);
               _texpBtnShine.play();
            }
         }
         else
         {
            _texpBtn.enable = false;
            if(!_texpBtnSprite)
            {
               _texpBtnSprite = new Sprite();
               _texpBtnSprite.addEventListener("mouseOver",__texpBtnOverHandler);
               _texpBtnSprite.addEventListener("mouseOut",__texpBtnOutHandler);
               _texpBtnSprite.graphics.beginFill(0,0);
               _texpBtnSprite.graphics.drawRect(0,0,_texpBtn.displayWidth - 5,_texpBtn.displayHeight);
               _texpBtnSprite.graphics.endFill();
               _texpBtnSprite.x = _texpBtn.x + 33;
               _texpBtnSprite.y = _texpBtn.y + 3;
               addToContent(_texpBtnSprite);
               _texpBtnTip = new OneLineTip();
               _texpBtnTip.tipData = LanguageMgr.GetTranslation("ddt.texpSystem.openTexpBtn.text",13);
               _texpBtnTip.visible = false;
            }
         }
      }
      
      private function cardBtnEnable() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 15)
         {
            _cardBtn.enable = true;
            if(_cardBtnSprite)
            {
               ObjectUtils.disposeObject(_cardBtnSprite);
               _cardBtnSprite = null;
            }
         }
         else
         {
            _cardBtn.enable = false;
            if(!_cardBtnSprite)
            {
               _cardBtnSprite = new Sprite();
               _cardBtnSprite.addEventListener("mouseOver",__cardBtnOverHandler);
               _cardBtnSprite.addEventListener("mouseOut",__cardBtnOutHandler);
               _cardBtnSprite.graphics.beginFill(0,0);
               _cardBtnSprite.graphics.drawRect(0,0,_cardBtn.displayWidth - 7,_cardBtn.displayHeight);
               _cardBtnSprite.graphics.endFill();
               _cardBtnSprite.x = _cardBtn.x + 34;
               _cardBtnSprite.y = _cardBtn.y + 6;
               addToContent(_cardBtnSprite);
               _cardBtnTip = new OneLineTip();
               _cardBtnTip.tipData = LanguageMgr.GetTranslation("ddt.giftSystem.openCardBtn.text",15);
               _cardBtnTip.visible = false;
            }
         }
      }
      
      private function __cardBtnOverHandler(param1:MouseEvent) : void
      {
         _cardBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_cardBtnTip,2);
         var _loc2_:Point = _cardBtn.localToGlobal(new Point(0,0));
         _cardBtnTip.x = _loc2_.x;
         _cardBtnTip.y = _loc2_.y + _cardBtn.height;
      }
      
      private function __cardBtnOutHandler(param1:MouseEvent) : void
      {
         _cardBtnTip.visible = false;
      }
      
      private function totemBtnEnable() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade >= 22)
         {
            _totemBtn.enable = true;
            if(_totemBtnSprite)
            {
               ObjectUtils.disposeObject(_totemBtnSprite);
               _totemBtnSprite = null;
            }
            if(!PlayerManager.Instance.Self.isNewOnceFinish(102) && !GiftManager.Instance.inChurch)
            {
               _loc1_ = {};
               _loc1_["color"] = "gold";
               _totemBtnShine = EffectManager.Instance.creatEffect(3,_totemBtn,_loc1_);
               _totemBtnShine.play();
            }
         }
         else
         {
            _totemBtn.enable = false;
            if(!_totemBtnSprite)
            {
               _totemBtnSprite = new Sprite();
               _totemBtnSprite.addEventListener("mouseOver",__totemBtnOverHandler);
               _totemBtnSprite.addEventListener("mouseOut",__totemBtnOutHandler);
               _totemBtnSprite.graphics.beginFill(0,0);
               _totemBtnSprite.graphics.drawRect(0,0,_totemBtn.displayWidth - 12,_totemBtn.displayHeight);
               _totemBtnSprite.graphics.endFill();
               _totemBtnSprite.x = _totemBtn.x + 17;
               _totemBtnSprite.y = _totemBtn.y + 3;
               addToContent(_totemBtnSprite);
               _totemBtnTip = new OneLineTip();
               _totemBtnTip.tipData = LanguageMgr.GetTranslation("ddt.totemSystem.openTotemBtn.text",22);
               _totemBtnTip.visible = false;
            }
         }
      }
      
      private function beadBtnEnable() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade >= 16)
         {
            _beadBtn.enable = true;
            if(_beadBtnSprite)
            {
               ObjectUtils.disposeObject(_beadBtnSprite);
               _beadBtnSprite = null;
            }
            if(!PlayerManager.Instance.Self.isNewOnceFinish(105) && !GiftManager.Instance.inChurch)
            {
               _loc1_ = {};
               _loc1_["color"] = "gold";
               _beadBtnShine = EffectManager.Instance.creatEffect(3,_beadBtn,_loc1_);
               _beadBtnShine.play();
            }
         }
         else
         {
            _beadBtn.enable = false;
            if(!_beadBtnSprite)
            {
               _beadBtnSprite = new Sprite();
               _beadBtnSprite.addEventListener("mouseOver",__beadBtnOverHandler);
               _beadBtnSprite.addEventListener("mouseOut",__beadBtnOutHandler);
               _beadBtnSprite.graphics.beginFill(0,0);
               _beadBtnSprite.graphics.drawRect(0,0,_beadBtn.displayWidth - 12,_beadBtn.displayHeight);
               _beadBtnSprite.graphics.endFill();
               _beadBtnSprite.x = _beadBtn.x + 17;
               _beadBtnSprite.y = _beadBtn.y + 3;
               addToContent(_beadBtnSprite);
               _beadBtnTip = new OneLineTip();
               _beadBtnTip.tipData = LanguageMgr.GetTranslation("ddt.giftSystem.openBeadBtn.text",16);
               _beadBtnTip.visible = false;
            }
         }
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
         _infoBtn.addEventListener("click",__soundPlay);
         _texpBtn.addEventListener("click",__soundPlay);
         _giftBtn.addEventListener("click",__soundPlay);
         _petBtn.addEventListener("click",__soundPlay);
         _cardBtn.addEventListener("click",__soundPlay);
         _totemBtn.addEventListener("click",__soundPlay);
         _beadBtn.addEventListener("click",__soundPlay);
         _avatarCollBtn.addEventListener("click",__soundPlay);
         _magicStoneBtn.addEventListener("click",__soundPlay);
         _godTempleBtn.addEventListener("click",__soundPlay);
         _pvePowerBuffBtn.addEventListener("click",__soundPlay);
         addEventListener("response",__responseHandler);
         addEventListener("addedToStage",__getFocus);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,2),__addPet);
         PlayerManager.Instance.addEventListener("quickBugCards",__quickBuyCards);
      }
      
      private function __frameClose(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               _frame.removeEventListener("response",__frameClose);
               SoundManager.instance.play("008");
               (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__frameClose);
               (param1.currentTarget as BaseAlerFrame).dispose();
               SocketManager.Instance.out.sendClearStoreBag();
         }
      }
      
      private function __quickBuyCards(param1:BagEvent) : void
      {
         _btnGroup.selectIndex = 0;
      }
      
      public function __addPet(param1:PkgEvent) : void
      {
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:PackageIn = param1.pkg;
         var _loc4_:int = _loc6_.readInt();
         var _loc5_:Boolean = _loc6_.readBoolean();
         var _loc8_:PetInfo = new PetInfo();
         _loc8_.TemplateID = _loc4_;
         PetInfoManager.fillPetInfo(_loc8_);
         if(_loc8_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("bagandinfo.bagAndInfo.itemOpenUpTxt");
            _loc3_.text = LanguageMgr.GetTranslation("ddt.bagandinfo.bagAndInfo.itemOpenUpTxt");
            _frame = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.ItemPreviewListFrame2");
            _loc7_ = ComponentFactory.Instance.creat("bagAndInfo.petAddItem",[_loc8_]);
            _loc2_ = new AlertInfo(_loc8_.Name);
            _loc2_.showCancel = false;
            _loc2_.moveEnable = false;
            _frame.info = _loc2_;
            _frame.addToContent(_loc3_);
            _frame.addToContent(_loc7_);
            _frame.addEventListener("response",__frameClose);
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
         _infoFrame.clearTexpInfo();
      }
      
      private function removeEvent() : void
      {
         if(_giftBtnSprite)
         {
            _giftBtnSprite.removeEventListener("mouseOver",__overHandler);
            _giftBtnSprite.removeEventListener("mouseOut",__outHandler);
         }
         if(_texpBtnSprite)
         {
            _texpBtnSprite.removeEventListener("mouseOver",__texpBtnOverHandler);
            _texpBtnSprite.removeEventListener("mouseOut",__texpBtnOutHandler);
         }
         if(!_cardBtnSprite)
         {
         }
         if(_totemBtnSprite)
         {
            _totemBtnSprite.removeEventListener("mouseOver",__totemBtnOverHandler);
            _totemBtnSprite.removeEventListener("mouseOut",__totemBtnOutHandler);
         }
         if(_beadBtnSprite)
         {
            _beadBtnSprite.removeEventListener("mouseOver",__beadBtnOverHandler);
            _beadBtnSprite.removeEventListener("mouseOut",__beadBtnOutHandler);
         }
         _btnGroup.removeEventListener("change",__changeHandler);
         _infoBtn.removeEventListener("click",__soundPlay);
         _texpBtn.removeEventListener("click",__soundPlay);
         _giftBtn.removeEventListener("click",__soundPlay);
         _petBtn.removeEventListener("click",__soundPlay);
         _cardBtn.removeEventListener("click",__soundPlay);
         _totemBtn.removeEventListener("click",__soundPlay);
         _beadBtn.removeEventListener("click",__soundPlay);
         _avatarCollBtn.removeEventListener("click",__soundPlay);
         _magicStoneBtn.removeEventListener("click",__soundPlay);
         removeEventListener("response",__responseHandler);
         removeEventListener("addedToStage",__getFocus);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,2),__addPet);
         PlayerManager.Instance.removeEventListener("quickBugCards",__quickBuyCards);
         if(_infoFrame)
         {
            _infoFrame.bagView.removeEventListener("setSelectCardComplete",__setSelectCardComplete);
         }
         MagicStoneManager.instance.removeEventListener("magicStoneLoadComplete",doShowMagicStone);
      }
      
      protected function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
         {
            if(PlayerManager.Instance.Self.Grade == 13)
            {
               texpBtnEnable();
            }
            if(PlayerManager.Instance.Self.Grade == 15)
            {
               cardBtnEnable();
            }
            if(PlayerManager.Instance.Self.Grade == 22)
            {
               totemBtnEnable();
            }
            if(PlayerManager.Instance.Self.Grade == 40)
            {
               magicStoneBtnEnable();
            }
         }
      }
      
      private function __soundPlay(param1:MouseEvent) : void
      {
         PlayerInfoViewControl.isOpenFromBag = true;
         SoundManager.instance.play("008");
         if((param1.target as SelectedButton).selectedStyle == "asset.infoBtn2")
         {
            showInfoFrame(0);
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _giftBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_giftBtnTip,2);
         var _loc2_:Point = _giftBtn.localToGlobal(new Point(0,0));
         _giftBtnTip.x = _loc2_.x;
         _giftBtnTip.y = _loc2_.y + _giftBtn.height;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _giftBtnTip.visible = false;
      }
      
      private function __texpBtnOverHandler(param1:MouseEvent) : void
      {
         _texpBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_texpBtnTip,2);
         var _loc2_:Point = _texpBtn.localToGlobal(new Point(0,0));
         _texpBtnTip.x = _loc2_.x;
         _texpBtnTip.y = _loc2_.y + _texpBtn.height;
      }
      
      private function __texpBtnOutHandler(param1:MouseEvent) : void
      {
         _texpBtnTip.visible = false;
      }
      
      private function __petBtnOverHandler(param1:MouseEvent) : void
      {
         _petBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_petBtnTip,2);
         var _loc2_:Point = _petBtn.localToGlobal(new Point(0,0));
         _petBtnTip.x = _loc2_.x;
         _petBtnTip.y = _loc2_.y + _petBtn.height + 5;
      }
      
      private function __petBtnOutHandler(param1:MouseEvent) : void
      {
         _petBtnTip.visible = false;
      }
      
      private function __totemBtnOverHandler(param1:MouseEvent) : void
      {
         _totemBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_totemBtnTip,2);
         var _loc2_:Point = _totemBtn.localToGlobal(new Point(0,0));
         _totemBtnTip.x = _loc2_.x - 12;
         _totemBtnTip.y = _loc2_.y + _totemBtn.height;
      }
      
      private function __totemBtnOutHandler(param1:MouseEvent) : void
      {
         _totemBtnTip.visible = false;
      }
      
      private function __beadBtnOverHandler(param1:MouseEvent) : void
      {
         _beadBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_beadBtnTip,2);
         var _loc2_:Point = _beadBtn.localToGlobal(new Point(0,0));
         _beadBtnTip.x = _loc2_.x + 10;
         _beadBtnTip.y = _loc2_.y + _beadBtn.height;
      }
      
      private function __beadBtnOutHandler(param1:MouseEvent) : void
      {
         _beadBtnTip.visible = false;
      }
      
      public function selectTab(param1:int) : void
      {
         _btnGroup.selectIndex = param1;
         __changeHandler(null);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         if(_infoFrame)
         {
            _infoFrame.clearTexpInfo();
         }
         HomeTempleManager.getInstance().removeView();
         MarkMgr.inst.removeMarkView();
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _fightPower = PlayerManager.Instance.Self.FightPower;
               showInfoFrame(0,_bagType);
               if(_infoFrame)
               {
                  _infoFrame.checkGuide();
               }
               break;
            case 1:
               showGiftFrame();
               break;
            case 2:
               showInfoFrame(3);
               break;
            case 3:
               showInfoFrame(5);
               break;
            case 4:
               switchCardView();
               if(NewHandContainer.Instance.hasArrow(150))
               {
                  NewHandContainer.Instance.clearArrowByID(150);
               }
               break;
            case 5:
               showTotem();
               break;
            case 6:
               _fightPower = PlayerManager.Instance.Self.FightPower;
               showBeadView();
               break;
            case 7:
               showAvatarCollection();
               break;
            case 8:
               _fightPower = PlayerManager.Instance.Self.FightPower;
               showMagicStone();
               break;
            case 9:
               _fightPower = PlayerManager.Instance.Self.FightPower;
               showGodTemple();
               break;
            case 10:
               showPvePowerBuff();
               break;
            case 11:
               setVisible(12);
               MarkMgr.inst.showMarkView(_container);
         }
         _markHelpBtn.visible = _btnGroup.selectIndex == 12 - 1;
         beadSystemManager.Instance.dispatchEvent(new BeadEvent("autoOpenBead",3));
      }
      
      private function showPvePowerBuff() : void
      {
         if(!_pvePowerBuffMainView)
         {
            PvePowerBuffManager.instance.addEventListener("pvePowerBuffLoadComplete",__doShowPvePowerBuff);
            PvePowerBuffManager.instance.show();
         }
         else
         {
            setVisible(11);
         }
      }
      
      private function __doShowPvePowerBuff(param1:PvePowerBuffEvent) : void
      {
         PvePowerBuffManager.instance.removeEventListener("pvePowerBuffLoadComplete",__doShowPvePowerBuff);
         _pvePowerBuffMainView = param1.info;
         addToContent(_pvePowerBuffMainView);
         setVisible(11);
      }
      
      private function showGodTemple() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(139))
         {
            if(PlayerManager.Instance.Self.Grade >= 35)
            {
               SocketManager.Instance.out.syncWeakStep(139);
               NewHandContainer.Instance.clearArrowByID(149);
            }
         }
         HomeTempleManager.getInstance().setContainer(_container);
         HomeTempleManager.getInstance().show();
         setVisible(10);
      }
      
      private function showMagicStone() : void
      {
         if(_magicStoneBtnShine)
         {
            _magicStoneBtnShine.stop();
            SocketManager.Instance.out.syncWeakStep(108);
            MagicStoneManager.instance.removeWeakGuide(3);
         }
         if(!_magicStoneMainView)
         {
            MagicStoneManager.instance.addEventListener("magicStoneLoadComplete",doShowMagicStone);
            MagicStoneManager.instance.show();
         }
         else
         {
            setVisible(9);
            SocketManager.Instance.out.getMagicStoneScore();
         }
      }
      
      private function doShowMagicStone(param1:MagicStoneEvent) : void
      {
         MagicStoneManager.instance.removeEventListener("magicStoneLoadComplete",doShowMagicStone);
         _magicStoneMainView = param1.info;
         addToContent(_magicStoneMainView);
         setVisible(9);
         SocketManager.Instance.out.getMagicStoneScore();
      }
      
      private function showBeadView() : void
      {
         if(_beadBtnShine)
         {
            _beadBtnShine.stop();
            SocketManager.Instance.out.syncWeakStep(105);
         }
         showInfoFrame(21);
      }
      
      private function setVisible(param1:int) : void
      {
         var _loc2_:Boolean = true;
         if(_infoFrame)
         {
            if(param1 == 0 || param1 == 2)
            {
               _loc2_ = true;
            }
            else
            {
               _loc2_ = false;
            }
            _infoFrame.visible = _loc2_;
            if(param1 == 0)
            {
               _infoFrame._infoView.switchShow(false);
            }
            if(param1 == 2)
            {
               _infoFrame._infoView.x = 12;
               _infoFrame._infoView.y = 2;
               _infoFrame.bagView.x = 475;
               _infoFrame.bagView.y = -21;
            }
            else
            {
               _infoFrame._infoView.x = -9;
               _infoFrame._infoView.y = 2;
               _infoFrame.bagView.x = 442;
               _infoFrame.bagView.y = -16;
            }
            _infoFrame.bagView.bagLockBtn.visible = param1 == 0;
         }
         TotemManager.instance.setVisible("totemview",param1 == 6);
         AvatarCollectionManager.instance.visible(param1 == 7);
         if(_magicStoneMainView)
         {
            _magicStoneMainView.visible = param1 == 9;
         }
         if(_pvePowerBuffMainView)
         {
            _pvePowerBuffMainView.visible = param1 == 11;
         }
      }
      
      private function switchCardView() : void
      {
         SocketManager.Instance.out.getPlayerCardInfo(PlayerManager.Instance.Self.ID);
         if(_infoFrame == null)
         {
            _infoFrame = ComponentFactory.Instance.creatCustomObject("bagAndInfoFrame");
            addToContent(_infoFrame);
         }
         _infoFrame.bagView.addEventListener("setSelectCardComplete",__setSelectCardComplete);
         _infoFrame.switchShow(0);
         setVisible(2);
         _infoFrame.bagView.createCard();
      }
      
      private function __setSelectCardComplete(param1:CardSocketEvent) : void
      {
         _infoFrame._infoView.switchShow(true);
      }
      
      private function showTotem() : void
      {
         if(_totemBtnShine)
         {
            _totemBtnShine.stop();
            SocketManager.Instance.out.syncWeakStep(102);
         }
         TotemManager.instance.showView("totemview",{"parent":_container});
         setVisible(6);
      }
      
      private function showAvatarCollection() : void
      {
         if(_avatarCollBtnShine)
         {
            _avatarCollBtnShine.stop();
            SocketManager.Instance.out.syncWeakStep(106);
         }
         AvatarCollectionManager.instance.showFrame(_container);
         setVisible(7);
      }
      
      private function showGiftFrame() : void
      {
         if(_giftBtnShine)
         {
            _giftBtnShine.stop();
            SharedManager.Instance.giftFirstShow = false;
            SharedManager.Instance.save();
         }
         if(_firstOpenGift)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onGiftSmallLoadingClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__createGift);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onGiftUIProgress);
            UIModuleLoader.Instance.addUIModuleImp("ddtgiftsystem");
         }
         else
         {
            GiftManager.Instance.canActive = true;
            SocketManager.Instance.out.sendUpdateGoodsCount();
            setVisible(1);
         }
      }
      
      private function __createGift(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtgiftsystem")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",__onGiftSmallLoadingClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__createGift);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onGiftUIProgress);
            _firstOpenGift = false;
            showGiftFrame();
         }
      }
      
      protected function __onGiftSmallLoadingClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onGiftSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__createGift);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onGiftUIProgress);
      }
      
      protected function __onGiftUIProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtgiftsystem")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function showInfoFrame(param1:int, param2:int = 0) : void
      {
         if(param1 == 3 && _texpBtnShine)
         {
            _texpBtnShine.stop();
            SharedManager.Instance.texpSystemShow = false;
            SharedManager.Instance.save();
         }
         if(_infoFrame == null)
         {
            _infoFrame = ComponentFactory.Instance.creatCustomObject("bagAndInfoFrame");
            addToContent(_infoFrame);
         }
         if(param1 == 5)
         {
            _infoFrame.isScreenFood = true;
         }
         else
         {
            _infoFrame.isScreenFood = false;
         }
         _infoFrame.switchShow(param1,param2);
         setVisible(0);
      }
      
      private function __getFocus(param1:Event) : void
      {
         removeEventListener("addedToStage",__getFocus);
         StageReferance.stage.focus = this;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            if(PvePowerBuffManager.instance.isInGetBuff == true)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.SystemBusy"));
               return;
            }
            dispose();
            if(_btnGroup.selectIndex == 0 || _btnGroup.selectIndex == 6 || _btnGroup.selectIndex == 8)
            {
               if(_fightPower < PlayerManager.Instance.Self.FightPower)
               {
                  PowerUpMovieManager.powerNum = _fightPower;
                  PowerUpMovieManager.addedPowerNum = PlayerManager.Instance.Self.FightPower - _fightPower;
                  PowerUpMovieManager.Instance.dispatchEvent(new Event("powerUp"));
               }
            }
            if(PlayerManager.Instance.Self.Grade == 3)
            {
               MainToolBar.Instance.tipTask();
            }
         }
      }
      
      public function show(param1:int, param2:String = "", param3:int = 0) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _bagType = param3;
         if(param1 == 21)
         {
            _btnGroup.selectIndex = 6;
         }
         else
         {
            _btnGroup.selectIndex = param1;
         }
         if(DraftManager.instance.showDraft)
         {
            var _loc4_:* = false;
            _pvePowerBuffBtn.enable = _loc4_;
            _loc4_ = _loc4_;
            _godTempleBtn.enable = _loc4_;
            _loc4_ = _loc4_;
            _beadBtn.enable = _loc4_;
            _loc4_ = _loc4_;
            _avatarCollBtn.enable = _loc4_;
            _loc4_ = _loc4_;
            _totemBtn.enable = _loc4_;
            _loc4_ = _loc4_;
            _cardBtn.enable = _loc4_;
            _loc4_ = _loc4_;
            _magicStoneBtn.enable = _loc4_;
            _loc4_ = _loc4_;
            _texpBtn.enable = _loc4_;
            _infoBtn.enable = _loc4_;
            if(_texpBtnShine)
            {
               _texpBtnShine.stop();
            }
            if(_magicStoneBtnShine)
            {
               _magicStoneBtnShine.stop();
            }
            if(_totemBtnShine)
            {
               _totemBtnShine.stop();
            }
            if(_avatarCollBtnShine)
            {
               _avatarCollBtnShine.stop();
            }
            if(_beadBtnShine)
            {
               _beadBtnShine.stop();
            }
         }
         if(GiftManager.Instance.inChurch == true)
         {
            _infoBtn.enable = false;
            _texpBtn.enable = false;
            _petBtn.enable = false;
            _cardBtn.enable = false;
            _totemBtn.enable = false;
            _beadBtn.enable = false;
            _avatarCollBtn.enable = false;
            _godTempleBtn.enable = false;
            _pvePowerBuffBtn.enable = false;
         }
         if(param1 == 1 && param2 != "")
         {
            setTimeout(GiftManager.Instance.RebackClick,300,param2);
         }
         if(StateManager.isInGame(StateManager.currentStateType))
         {
            _infoBtn.enable = false;
            _texpBtn.enable = false;
            _giftBtn.enable = false;
            _petBtn.enable = false;
         }
      }
      
      override public function dispose() : void
      {
         if(DraftManager.instance.showDraft)
         {
            DraftManager.instance.show();
         }
         NewHandContainer.Instance.hideGuideCover();
         NewHandContainer.Instance.clearArrowByID(138);
         NewHandContainer.Instance.clearArrowByID(150);
         NewHandContainer.Instance.clearArrowByID(145);
         NewHandContainer.Instance.clearArrowByID(149);
         NewHandContainer.Instance.clearArrowByID(201);
         NewHandContainer.Instance.clearArrowByID(151);
         BagAndInfoManager.Instance.isInBagAndInfoView = false;
         if(_giftBtnShine)
         {
            EffectManager.Instance.removeEffect(_giftBtnShine);
         }
         _giftBtnShine = null;
         if(_texpBtnShine)
         {
            EffectManager.Instance.removeEffect(_texpBtnShine);
         }
         _texpBtnShine = null;
         if(_totemBtnShine)
         {
            EffectManager.Instance.removeEffect(_totemBtnShine);
         }
         _totemBtnShine = null;
         if(_beadBtnShine)
         {
            EffectManager.Instance.removeEffect(_beadBtnShine);
         }
         _beadBtnShine = null;
         BagAndInfoManager.Instance.clearReference();
         removeEvent();
         if(_petBtn)
         {
            ObjectUtils.disposeObject(_petBtn);
            _petBtn = null;
         }
         if(_frame)
         {
            _frame.removeEventListener("response",__frameClose);
            _frame.dispose();
            _frame = null;
         }
         if(_infoBtn)
         {
            ObjectUtils.disposeObject(_infoBtn);
         }
         _infoBtn = null;
         if(_texpBtn)
         {
            ObjectUtils.disposeObject(_texpBtn);
         }
         _texpBtn = null;
         if(_texpBtnTip)
         {
            ObjectUtils.disposeObject(_texpBtnTip);
         }
         _texpBtnTip = null;
         if(_texpBtnSprite)
         {
            ObjectUtils.disposeObject(_texpBtnSprite);
         }
         _texpBtnSprite = null;
         if(_giftBtn)
         {
            ObjectUtils.disposeObject(_giftBtn);
         }
         _giftBtn = null;
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_giftBtnSprite)
         {
            ObjectUtils.disposeObject(_giftBtnSprite);
         }
         _giftBtnSprite = null;
         if(_totemBtnSprite)
         {
            ObjectUtils.disposeObject(_totemBtnSprite);
         }
         _totemBtnSprite = null;
         if(_markBtnSprite)
         {
            ObjectUtils.disposeObject(_markBtnSprite);
         }
         _markBtnSprite = null;
         if(_beadBtnSprite)
         {
            ObjectUtils.disposeObject(_beadBtnSprite);
         }
         _beadBtnSprite = null;
         if(_giftBtnTip)
         {
            ObjectUtils.disposeObject(_giftBtnTip);
         }
         _giftBtnTip = null;
         if(_petBtnTip)
         {
            ObjectUtils.disposeObject(_petBtnTip);
         }
         _petBtnTip = null;
         if(_cardBtnTip)
         {
            ObjectUtils.disposeObject(_cardBtnTip);
         }
         _cardBtnTip = null;
         if(_totemBtnTip)
         {
            ObjectUtils.disposeObject(_totemBtnTip);
         }
         _totemBtnTip = null;
         if(_markBtnTip)
         {
            ObjectUtils.disposeObject(_markBtnTip);
         }
         _markBtnTip = null;
         if(_beadBtnTip)
         {
            ObjectUtils.disposeObject(_beadBtnTip);
         }
         _beadBtnTip = null;
         if(_infoFrame)
         {
            _infoFrame.dispose();
         }
         _infoFrame = null;
         if(_totemBtn)
         {
            ObjectUtils.disposeObject(_totemBtn);
         }
         _totemBtn = null;
         if(_avatarCollBtn)
         {
            ObjectUtils.disposeObject(_avatarCollBtn);
         }
         _avatarCollBtn = null;
         ObjectUtils.disposeObject(_godTempleBtn);
         _godTempleBtn = null;
         ObjectUtils.disposeObject(_pvePowerBuffBtn);
         _pvePowerBuffBtn = null;
         ObjectUtils.disposeObject(_magicStoneBtn);
         _magicStoneBtn = null;
         ObjectUtils.disposeObject(_magicStoneBtnShine);
         _magicStoneBtnShine = null;
         ObjectUtils.disposeObject(_magicStoneBtnSprite);
         _magicStoneBtnSprite = null;
         ObjectUtils.disposeObject(_magicStoneBtnTip);
         _magicStoneBtnTip = null;
         TotemManager.instance.closeView("totemview");
         AvatarCollectionManager.instance.closeFrame();
         ObjectUtils.disposeObject(_magicStoneMainView);
         _magicStoneMainView = null;
         MagicStoneManager.instance.disposeView();
         ObjectUtils.disposeObject(_pvePowerBuffMainView);
         _pvePowerBuffMainView = null;
         PvePowerBuffManager.instance.disposeView();
         PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(95);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
         HallTaskGuideManager.instance.clearTask1Arrow();
         HallTaskGuideManager.instance.showTask1ClickBagArrow();
         NewHandContainer.Instance.clearArrowByID(140);
         NewHandContainer.Instance.clearArrowByID(141);
         NewHandContainer.Instance.clearArrowByID(142);
         MarkMgr.inst.removeMarkView();
      }
      
      public function get infoFrame() : BagAndInfoFrame
      {
         return _infoFrame;
      }
   }
}
