package store.view.strength{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.QualityType;   import ddt.data.goods.ShopItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PetSkillManager;   import ddt.manager.PlayerManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import ddt.utils.StaticFormula;   import ddt.view.SimpleItem;   import ddt.view.tips.GhostStarContainer;   import ddt.view.tips.GoodTipInfo;   import enchant.EnchantManager;   import enchant.data.EnchantInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.geom.Point;   import flash.text.TextFormat;   import latentEnergy.LatentEnergyTipItem;   import road7th.utils.DateUtils;   import road7th.utils.StringHelper;   import store.equipGhost.EquipGhostManager;   import store.equipGhost.data.EquipGhostData;   import store.equipGhost.data.GhostData;   import store.equipGhost.data.GhostPropertyData;      public class LaterEquipmentView extends Component   {            public static const ITEM_ENCHANT_COLOR:uint = 13971455;                   private var _strengthenLevelImage:MovieImage;            private var _fusionLevelImage:MovieImage;            private var _boundImage:ScaleFrameImage;            private var _nameTxt:FilterFrameText;            private var _qualityItem:SimpleItem;            private var _typeItem:SimpleItem;            private var _mainPropertyItem:SimpleItem;            private var _armAngleItem:SimpleItem;            private var _otherHp:SimpleItem;            private var _necklaceItem:FilterFrameText;            private var _attackTxt:FilterFrameText;            private var _defenseTxt:FilterFrameText;            private var _agilityTxt:FilterFrameText;            private var _luckTxt:FilterFrameText;            private var _enchantLevelTxt:FilterFrameText;            private var _enchantAttackTxt:FilterFrameText;            private var _enchantDefenceTxt:FilterFrameText;            private var _enchantAttackPencentTxt:FilterFrameText;            private var _enchantDefencePencentTxt:FilterFrameText;            private var _needLevelTxt:FilterFrameText;            private var _needSexTxt:FilterFrameText;            private var _holes:Vector.<FilterFrameText>;            private var _upgradeType:FilterFrameText;            private var _ghostSkillDesc:FilterFrameText;            private var _descriptionTxt:FilterFrameText;            private var _bindTypeTxt:FilterFrameText;            private var _remainTimeTxt:FilterFrameText;            private var _goldRemainTimeTxt:FilterFrameText;            private var _fightPropConsumeTxt:FilterFrameText;            private var _boxTimeTxt:FilterFrameText;            private var _limitGradeTxt:FilterFrameText;            private var _info:ItemTemplateInfo;            private var _bindImageOriginalPos:Point;            private var _maxWidth:int;            private var _minWidth:int = 196;            private var _autoGhostWidth:int;            private var _isArmed:Boolean;            private var _displayList:Vector.<DisplayObject>;            private var _displayIdx:int;            private var _lines:Vector.<Image>;            private var _lineIdx:int;            private var _isReAdd:Boolean;            private var _remainTimeBg:Bitmap;            private var _tipbackgound:MutipleImage;            private var _rightArrows:Bitmap;            private var _ghostLV:int = -1;            private var _ghostStartsContainer:GhostStarContainer = null;            public function LaterEquipmentView() { super(); }
            override protected function init() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            public function showTip(info:ItemTemplateInfo, typeIsSecond:Boolean = false) : void { }
            private function updateView() : void { }
            private function createGhostSkillitem() : void { }
            private function createEnchantProperties() : void { }
            private function clear() : void { }
            override protected function addChildren() : void { }
            private function createLatentEnergy() : void { }
            private function createItemName() : void { }
            private function createQualityItem() : void { }
            private function createCategoryItem() : void { }
            private function createMainProperty() : void { }
            private function createNecklaceItem() : void { }
            private function setPurpleHtmlTxt(title:String, value:int, add:String) : String { return null; }
            private function createProperties() : void { }
            private function createHoleItem() : void { }
            private function createSingleHole(inventoryInfo:InventoryItemInfo, index:int, strengthLevel:int, holeType:int) : FilterFrameText { return null; }
            public function getHole(inventoryInfo:InventoryItemInfo, index:int) : int { return 0; }
            private function getHoleType(type:int) : String { return null; }
            private function createOperationItem() : void { }
            private function createDescript() : void { }
            private function createShopItemLimitGrade(itemInfo:ShopItemInfo) : void { }
            private function ShowBound(info:InventoryItemInfo) : Boolean { return false; }
            private function createBindType() : void { }
            private function createRemainTime() : void { }
            private function createGoldRemainTime() : void { }
            private function createFightPropConsume() : void { }
            private function createBoxTimeItem() : void { }
            private function createStrenthLevel() : void { }
            private function seperateLine() : void { }
            override public function dispose() : void { }
   }}