package ddt.view.tips
{
   import GodSyah.SyahManager;
   import GodSyah.SyahTip;
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.amulet.EquipAmuletManager;
   import bagAndInfo.bag.ring.RingSystemTip;
   import bagAndInfo.bag.ring.data.RingSystemData;
   import bagAndInfo.info.PlayerInfoViewControl;
   import beadSystem.model.BeadInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.AwakenEquipInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.store.FineSuitVo;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.FineSuitManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.utils.StaticFormula;
   import ddt.view.SimpleItem;
   import enchant.EnchantManager;
   import enchant.data.EnchantInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import gemstone.GemstoneManager;
   import gemstone.items.GemstonTipItem;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   import itemActivityGift.ItemActivityGiftManager;
   import itemActivityGift.data.ItemEveryDayRecordData;
   import latentEnergy.LatentEnergyTipItem;
   import mark.MarkMgr;
   import petsBag.PetsBagManager;
   import road7th.utils.DateUtils;
   import road7th.utils.StringHelper;
   import store.FineEvolutionManager;
   import store.data.EvolutionData;
   import store.data.StoreEquipExperience;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.EquipGhostData;
   import store.equipGhost.data.GhostData;
   import store.equipGhost.data.GhostPropertyData;
   
   public class GoodTip extends BaseTip implements Disposeable, ITip
   {
      
      private static const LEVELMAX:Array = [63,65,68,70];
      
      public static const BOUND:uint = 1;
      
      public static const UNBOUND:uint = 2;
      
      public static const ITEM_NORMAL_COLOR:uint = 16777215;
      
      public static const ITEM_NECKLACE_COLOR:uint = 16750899;
      
      public static const ITEM_PROPERTIES_COLOR:uint = 16750899;
      
      public static const ITEM_HOLES_COLOR:uint = 16777215;
      
      public static const ITEM_HOLE_RESERVE_COLOR:uint = 16776960;
      
      public static const ITEM_HOLE_GREY_COLOR:uint = 6710886;
      
      public static const ITEM_FIGHT_PROP_CONSUME_COLOR:uint = 14520832;
      
      public static const ITEM_NEED_LEVEL_COLOR:uint = 13421772;
      
      public static const ITEM_NEED_LEVEL_FAILED_COLOR:uint = 16711680;
      
      public static const ITEM_UPGRADE_TYPE_COLOR:uint = 10092339;
      
      public static const ITEM_NEED_SEX_COLOR:uint = 10092339;
      
      public static const ITEM_NEED_SEX_FAILED_COLOR:uint = 16711680;
      
      public static const ITEM_ETERNAL_COLOR:uint = 16776960;
      
      public static const ITEM_PAST_DUE_COLOR:uint = 16711680;
      
      public static const ITEM_MAGIC_STONE_COLOR:uint = 2467327;
      
      public static const ITEM_ENCHANT_COLOR:uint = 13971455;
      
      public static const ITEM_ENCHANT_ENABLE_COLOR:uint = 11842740;
      
      public static const ITEM_ENCHANT_0_PECENT:uint = 16777215;
      
      public static const ITEM_ENCHANT_60_PECENT:uint = 65328;
      
      public static const ITEM_ENCHANT_80_PECENT:uint = 762111;
      
      public static const ITEM_ENCHANT_100_PECENT:uint = 10833407;
      
      public static const enchantLevelTxtArr:Array = LanguageMgr.GetTranslation("enchant.levelTxt").split(",");
      
      private static const PET_SPECIAL_FOOD:int = 334100;
       
      
      private var _strengthenLevelImage:MovieImage;
      
      private var _fusionLevelImage:MovieImage;
      
      private var _boundImage:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _qualityItem:SimpleItem;
      
      private var _typeItem:SimpleItem;
      
      private var _expItem:SimpleItem;
      
      private var _mainPropertyItem:SimpleItem;
      
      private var _armAngleItem:SimpleItem;
      
      private var _otherHp:SimpleItem;
      
      private var _armShellProtertyTxts:Vector.<FilterFrameText>;
      
      private var _necklaceItem:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _defenseTxt:FilterFrameText;
      
      private var _agilityTxt:FilterFrameText;
      
      private var _luckTxt:FilterFrameText;
      
      private var _magicAttackTxt:FilterFrameText;
      
      private var _magicDefenceTxt:FilterFrameText;
      
      private var _mgStoneName:FilterFrameText;
      
      private var _attackTxt2:FilterFrameText;
      
      private var _defenseTxt2:FilterFrameText;
      
      private var _agilityTxt2:FilterFrameText;
      
      private var _luckTxt2:FilterFrameText;
      
      private var _magicAttackTxt2:FilterFrameText;
      
      private var _magicDefenceTxt2:FilterFrameText;
      
      private var _magicStoneIcon:Bitmap;
      
      private var _enchantLevelTxt:FilterFrameText;
      
      private var _enchantAttackTxt:FilterFrameText;
      
      private var _enchantDefenceTxt:FilterFrameText;
      
      private var _enchantAttackPencentTxt:FilterFrameText;
      
      private var _enchantDefencePencentTxt:FilterFrameText;
      
      private var _gp:FilterFrameText;
      
      private var _maxGP:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _needLevelTxt:FilterFrameText;
      
      private var _needSexTxt:FilterFrameText;
      
      private var _holes:Vector.<FilterFrameText>;
      
      private var _upgradeType:FilterFrameText;
      
      private var _ghostSkillDesc:FilterFrameText;
      
      private var _armShellNameTxt:FilterFrameText;
      
      private var _descriptionTxt:FilterFrameText;
      
      private var _bindTypeTxt:FilterFrameText;
      
      protected var _remainTimeTxt:FilterFrameText;
      
      private var _goldRemainTimeTxt:FilterFrameText;
      
      private var _fightPropConsumeTxt:FilterFrameText;
      
      private var _boxTimeTxt:FilterFrameText;
      
      private var _limitGradeTxt:FilterFrameText;
      
      protected var _info:ItemTemplateInfo;
      
      private var _bindImageOriginalPos:Point;
      
      private var _maxWidth:int;
      
      private var _minWidth:int = 240;
      
      private var _autoGhostWidth:int;
      
      private var _isArmed:Boolean;
      
      protected var _displayList:Vector.<DisplayObject>;
      
      protected var _displayIdx:int;
      
      private var _lines:Vector.<Image>;
      
      private var _lineIdx:int;
      
      private var _isReAdd:Boolean;
      
      protected var _remainTimeBg:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      protected var _laterEquipmentGoodView:LaterEquipmentGoodView;
      
      protected var syahTip:SyahTip;
      
      private var _thingsFromTxt:FilterFrameText;
      
      private var _openCountTxt:FilterFrameText;
      
      private var _petsSkillTxt:FilterFrameText;
      
      private var _suitIcon:ScaleFrameImage;
      
      private var _nameContent:Sprite;
      
      private var _ghostContent:Sprite;
      
      private var _addition:RingSystemTip;
      
      private var _ghostPropertyData:GhostPropertyData;
      
      private var _ghostStartsContainer:GhostStarContainer = null;
      
      private var _markContainer:MarkPropsTip = null;
      
      private var _exp:int;
      
      private var _UpExp:int;
      
      private var _figSpirit1:FilterFrameText;
      
      private var _figSpirit2:FilterFrameText;
      
      private var _figSpirit3:FilterFrameText;
      
      public function GoodTip(){super();}
      
      override protected function init() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      public function showTip(param1:ItemTemplateInfo, param2:Boolean = false) : void{}
      
      public function showSuitTip(param1:ItemTemplateInfo) : void{}
      
      private function showSyahTip() : void{}
      
      private function updateView() : void{}
      
      private function createMarkProps() : void{}
      
      private function createRingAddition() : void{}
      
      private function laterEquipment(param1:ItemTemplateInfo) : void{}
      
      private function clear() : void{}
      
      override protected function addChildren() : void{}
      
      private function createLatentEnergy() : void{}
      
      private function creatLevel() : void{}
      
      private function createPetsSkill() : void{}
      
      private function creatGemstone() : void{}
      
      private function createItemName() : void{}
      
      private function createQualityItem() : void{}
      
      private function getInfoQuality() : int{return 0;}
      
      private function createCategoryItem() : void{}
      
      private function careteEXP() : void{}
      
      private function createMainProperty() : void{}
      
      private function createArmShellProperty() : void{}
      
      private function createNecklaceItem() : void{}
      
      private function createProperties() : void{}
      
      private function createGhostSkillitem() : void{}
      
      private function createHoleItem() : void{}
      
      private function createSingleHole(param1:InventoryItemInfo, param2:int, param3:int, param4:int) : FilterFrameText{return null;}
      
      public function getHole(param1:InventoryItemInfo, param2:int) : int{return 0;}
      
      private function getHoleType(param1:int) : String{return null;}
      
      private function createOperationItem() : void{}
      
      private function createArmShellName() : void{}
      
      private function createDescript() : void{}
      
      private function ShowBound(param1:InventoryItemInfo) : Boolean{return false;}
      
      private function createBindType() : void{}
      
      protected function cantAddPrice() : void{}
      
      protected function createRemainTime() : void{}
      
      private function createGoldRemainTime() : void{}
      
      private function createFightPropConsume() : void{}
      
      private function createBoxTimeItem() : void{}
      
      private function createStrenthLevel() : void{}
      
      private function createMagicStone() : void{}
      
      private function createEvolutionProperties() : void{}
      
      private function createEnchantProperties() : void{}
      
      protected function seperateLine() : void{}
      
      private function getGhostPropertyData() : GhostPropertyData{return null;}
   }
}
