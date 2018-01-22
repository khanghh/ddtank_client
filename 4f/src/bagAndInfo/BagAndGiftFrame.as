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
      
      public function BagAndGiftFrame(){super();}
      
      private function initView() : void{}
      
      private function shGuide() : void{}
      
      private function texpGuide() : void{}
      
      private function beadGuide() : void{}
      
      private function totemGuide() : void{}
      
      private function templeGuide() : void{}
      
      public function get btnGroup() : SelectedButtonGroup{return null;}
      
      private function markBtnEnable() : void{}
      
      private function __markOverHandler(param1:MouseEvent) : void{}
      
      private function __markOutHandler(param1:MouseEvent) : void{}
      
      private function pvePowerBuffEnable() : void{}
      
      private function __pvePowerBuffOverHandler(param1:MouseEvent) : void{}
      
      private function __pvePowerBuffOutHandler(param1:MouseEvent) : void{}
      
      private function godTempleBtnEnable() : void{}
      
      private function __godTempleOverHandler(param1:MouseEvent) : void{}
      
      private function __godTempleOutHandler(param1:MouseEvent) : void{}
      
      private function magicStoneBtnEnable() : void{}
      
      private function __magicStoneOverHandler(param1:MouseEvent) : void{}
      
      private function __magicStoneOutHandler(param1:MouseEvent) : void{}
      
      private function avatarCollBtnEnable() : void{}
      
      private function __avatarCollBtnOverHandler(param1:MouseEvent) : void{}
      
      private function __avatarCollBtnOutHandler(param1:MouseEvent) : void{}
      
      private function GiftbtnEnable() : void{}
      
      private function texpBtnEnable() : void{}
      
      private function cardBtnEnable() : void{}
      
      private function __cardBtnOverHandler(param1:MouseEvent) : void{}
      
      private function __cardBtnOutHandler(param1:MouseEvent) : void{}
      
      private function totemBtnEnable() : void{}
      
      private function beadBtnEnable() : void{}
      
      private function initEvent() : void{}
      
      private function __frameClose(param1:FrameEvent) : void{}
      
      private function __quickBuyCards(param1:BagEvent) : void{}
      
      public function __addPet(param1:PkgEvent) : void{}
      
      private function removeEvent() : void{}
      
      protected function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function __soundPlay(param1:MouseEvent) : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      private function __texpBtnOverHandler(param1:MouseEvent) : void{}
      
      private function __texpBtnOutHandler(param1:MouseEvent) : void{}
      
      private function __petBtnOverHandler(param1:MouseEvent) : void{}
      
      private function __petBtnOutHandler(param1:MouseEvent) : void{}
      
      private function __totemBtnOverHandler(param1:MouseEvent) : void{}
      
      private function __totemBtnOutHandler(param1:MouseEvent) : void{}
      
      private function __beadBtnOverHandler(param1:MouseEvent) : void{}
      
      private function __beadBtnOutHandler(param1:MouseEvent) : void{}
      
      public function selectTab(param1:int) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function showPvePowerBuff() : void{}
      
      private function __doShowPvePowerBuff(param1:PvePowerBuffEvent) : void{}
      
      private function showGodTemple() : void{}
      
      private function showMagicStone() : void{}
      
      private function doShowMagicStone(param1:MagicStoneEvent) : void{}
      
      private function showBeadView() : void{}
      
      private function setVisible(param1:int) : void{}
      
      private function switchCardView() : void{}
      
      private function __setSelectCardComplete(param1:CardSocketEvent) : void{}
      
      private function showTotem() : void{}
      
      private function showAvatarCollection() : void{}
      
      private function showGiftFrame() : void{}
      
      private function __createGift(param1:UIModuleEvent) : void{}
      
      protected function __onGiftSmallLoadingClose(param1:Event) : void{}
      
      protected function __onGiftUIProgress(param1:UIModuleEvent) : void{}
      
      private function showInfoFrame(param1:int, param2:int = 0) : void{}
      
      private function __getFocus(param1:Event) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      public function show(param1:int, param2:String = "", param3:int = 0) : void{}
      
      override public function dispose() : void{}
      
      public function get infoFrame() : BagAndInfoFrame{return null;}
   }
}
