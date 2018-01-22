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
      
      public function GoodTip()
      {
         _holes = new Vector.<FilterFrameText>();
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:int = 0;
         _lines = new Vector.<Image>();
         _displayList = new Vector.<DisplayObject>();
         _tipbackgound = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _strengthenLevelImage = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameMc");
         _fusionLevelImage = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTrinketLevelMc");
         _boundImage = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.BoundImage");
         _bindImageOriginalPos = new Point(_boundImage.x,_boundImage.y);
         _nameContent = new Sprite();
         _suitIcon = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.image");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameTxt");
         _thingsFromTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipThingsFromTxt");
         _qualityItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.QualityItem");
         _typeItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.TypeItem");
         _expItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.EXPItem");
         _mainPropertyItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.MainPropertyItem");
         _armAngleItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.armAngleItem");
         _otherHp = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.otherHp");
         _armShellProtertyTxts = new Vector.<FilterFrameText>();
         _armShellProtertyTxts.push(ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt"));
         _armShellProtertyTxts.push(ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt"));
         _necklaceItem = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _defenseTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _agilityTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _luckTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _magicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _magicDefenceTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _mgStoneName = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _attackTxt2 = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _defenseTxt2 = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _agilityTxt2 = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _luckTxt2 = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _magicAttackTxt2 = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _magicDefenceTxt2 = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantLevelTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantAttackTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantDefenceTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantAttackPencentTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantDefencePencentTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.LimitGradeTxt");
         _gp = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _maxGP = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _level = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _gp = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _maxGP = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _holes = new Vector.<FilterFrameText>();
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _holes.push(ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt"));
            _loc1_++;
         }
         _needLevelTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _needSexTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _upgradeType = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _openCountTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsOpenCountTxt");
         _armShellNameTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.DescriptionTxt");
         _ghostSkillDesc = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.ghostDescTxt");
         _bindTypeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _remainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemDateTxt");
         _goldRemainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipGoldItemDateTxt");
         _remainTimeBg = ComponentFactory.Instance.creatBitmap("asset.core.tip.restTime");
         _fightPropConsumeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _boxTimeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _limitGradeTxt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.LimitGradeTxt");
         _laterEquipmentGoodView = new LaterEquipmentGoodView();
         _laterEquipmentGoodView.visible = false;
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            if(param1 is GoodTipInfo)
            {
               _tipData = param1 as GoodTipInfo;
               if(EquipType.isBead(_tipData.itemInfo.Property1) || EquipType.isMagicStone(_tipData.itemInfo.CategoryID))
               {
                  _exp = _tipData.exp;
                  _UpExp = _tipData.upExp;
               }
               else if(EquipType.canBringUp(_tipData.itemInfo))
               {
                  _loc2_ = _tipData.itemInfo as ItemTemplateInfo;
                  if(_loc2_ is InventoryItemInfo)
                  {
                     if((_loc2_ as InventoryItemInfo).curExp == 0)
                     {
                        _exp = int(ItemManager.Instance.getTemplateById(_loc2_.TemplateID).Property2);
                     }
                     else
                     {
                        _exp = (_loc2_ as InventoryItemInfo).curExp;
                     }
                  }
                  else
                  {
                     _exp = int(_loc2_.Property2);
                  }
                  if(_loc2_.FusionType == 0)
                  {
                     _UpExp = 0;
                  }
                  else
                  {
                     _UpExp = int(ItemManager.Instance.getTemplateById(_loc2_.FusionType).Property2);
                  }
               }
               showTip(_tipData.itemInfo,_tipData.typeIsSecond);
               if(PathManager.suitEnable)
               {
                  showSuitTip(_tipData.itemInfo);
               }
               else
               {
                  _laterEquipmentGoodView.visible = false;
               }
               if(SyahManager.Instance.isOpen)
               {
                  showSyahTip();
               }
            }
            else if(param1 is ShopItemInfo)
            {
               _tipData = param1 as ShopItemInfo;
               showTip(_tipData.TemplateInfo);
               _laterEquipmentGoodView.visible = false;
            }
            else
            {
               _laterEquipmentGoodView.visible = false;
            }
            visible = true;
         }
         else
         {
            _tipData = null;
            visible = false;
            _laterEquipmentGoodView.visible = false;
         }
      }
      
      public function showTip(param1:ItemTemplateInfo, param2:Boolean = false) : void
      {
         _displayIdx = 0;
         _displayList = new Vector.<DisplayObject>();
         _lineIdx = 0;
         _isReAdd = false;
         _maxWidth = 0;
         _autoGhostWidth = 0;
         _info = param1;
         _ghostPropertyData = getGhostPropertyData();
         updateView();
      }
      
      public function showSuitTip(param1:ItemTemplateInfo) : void
      {
         var _loc2_:* = null;
         var _loc3_:ItemTemplateInfo = _tipData.itemInfo;
         if(_loc3_ is ItemTemplateInfo)
         {
            if(_loc3_.SuitId != 0)
            {
               _laterEquipmentGoodView.visible = true;
               _loc2_ = localToGlobal(new Point(_tipbackgound.x,_tipbackgound.y));
               if(_loc2_.x + _tipbackgound.width + _laterEquipmentGoodView.width < StageReferance.stageWidth)
               {
                  _laterEquipmentGoodView.x = _width + 5;
               }
               else
               {
                  _laterEquipmentGoodView.x = -_laterEquipmentGoodView.width - 5;
               }
               laterEquipment(_loc3_);
            }
            else
            {
               _laterEquipmentGoodView.visible = false;
            }
         }
         else
         {
            _laterEquipmentGoodView.visible = false;
         }
         _laterEquipmentGoodView.y = _tipbackgound.height - _laterEquipmentGoodView.height;
      }
      
      private function showSyahTip() : void
      {
         var _loc1_:* = null;
         if(SyahManager.Instance.getSyahModeByInfo(_tipData.itemInfo))
         {
            syahTip = new SyahTip();
            syahTip.setTipInfo(_tipData.itemInfo);
            if(_laterEquipmentGoodView.visible)
            {
               syahTip.setBGWidth(_laterEquipmentGoodView.getBGWidth());
               syahTip.x = _laterEquipmentGoodView.x;
               syahTip.y = _laterEquipmentGoodView.y - syahTip.displayHeight;
               if(syahTip.y + this.y < 5)
               {
                  syahTip.y = 0;
                  _laterEquipmentGoodView.y = syahTip.displayHeight;
               }
            }
            else
            {
               syahTip.setBGWidth(228);
               _loc1_ = localToGlobal(new Point(_tipbackgound.x,_tipbackgound.y));
               if(_loc1_.x + _tipbackgound.width + syahTip.displayWidth < StageReferance.stageWidth)
               {
                  syahTip.x = _width + 5;
               }
               else
               {
                  syahTip.x = -250;
               }
               syahTip.y = _tipbackgound.height - syahTip.displayHeight;
            }
            addChild(syahTip);
         }
      }
      
      private function updateView() : void
      {
         if(_info == null)
         {
            return;
         }
         clear();
         _isArmed = false;
         createItemName();
         createQualityItem();
         createCategoryItem();
         careteEXP();
         createMainProperty();
         seperateLine();
         createArmShellProperty();
         seperateLine();
         createNecklaceItem();
         createProperties();
         seperateLine();
         createEnchantProperties();
         seperateLine();
         createMagicStone();
         seperateLine();
         creatGemstone();
         seperateLine();
         creatLevel();
         createPetsSkill();
         seperateLine();
         createLatentEnergy();
         seperateLine();
         createOperationItem();
         seperateLine();
         createGhostSkillitem();
         createEvolutionProperties();
         createArmShellName();
         createDescript();
         createBindType();
         createRemainTime();
         createGoldRemainTime();
         createFightPropConsume();
         createBoxTimeItem();
         addChildren();
         createStrenthLevel();
         createRingAddition();
         createMarkProps();
      }
      
      private function createMarkProps() : void
      {
         var _loc2_:InventoryItemInfo = _info as InventoryItemInfo;
         if(_loc2_ == null || !MarkMgr.inst.checkTip(_loc2_.CategoryID,_loc2_.Place))
         {
            return;
         }
         var _loc1_:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         if(_loc1_.getMarkChipCntByPlace(_loc2_.Place) == 0)
         {
            return;
         }
         if(_markContainer)
         {
            if(_markContainer.parent)
            {
               _markContainer.parent.removeChild(_markContainer);
            }
            ObjectUtils.disposeObject(_markContainer);
            _markContainer = null;
         }
         _markContainer = new MarkPropsTip(_loc2_.Place);
         _markContainer.data = _loc1_;
         _markContainer.x = this.width;
         _height = _markContainer.height > _height?_markContainer.height:Number(_height);
         _width = _width + _markContainer.width;
         addChild(_markContainer);
      }
      
      private function createRingAddition() : void
      {
         var _loc1_:* = null;
         if(_info is InventoryItemInfo && EquipType.isWeddingRing(_info))
         {
            _loc1_ = BagAndInfoManager.Instance.getRingData(InventoryItemInfo(_info).RingExp);
            if(PlayerManager.Instance.Self.ID == InventoryItemInfo(_info).UserID)
            {
               _loc1_ = BagAndInfoManager.Instance.getRingData(PlayerManager.Instance.Self.RingExp);
            }
            _addition = new RingSystemTip();
            _addition.setAdditiontext([_info.Attack * _loc1_.Attack,_info.Defence * _loc1_.Defence,_info.Agility * _loc1_.Agility,_info.Luck * _loc1_.Luck]);
            _addition.x = _attackTxt.x + 130;
            _addition.y = _attackTxt.y + 3;
            addChild(_addition);
         }
      }
      
      private function laterEquipment(param1:ItemTemplateInfo) : void
      {
         if(!_laterEquipmentGoodView)
         {
            _laterEquipmentGoodView = new LaterEquipmentGoodView();
         }
         _laterEquipmentGoodView.tipData = param1;
      }
      
      private function clear() : void
      {
         var _loc1_:* = null;
         while(numChildren > 0)
         {
            _loc1_ = getChildAt(0) as DisplayObject;
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         if(_markContainer)
         {
            ObjectUtils.disposeObject(_markContainer);
            _markContainer = null;
         }
      }
      
      override protected function addChildren() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = _displayList.length;
         var _loc6_:Point = new Point(4,4);
         var _loc3_:int = 6;
         var _loc5_:int = _maxWidth;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_displayList[_loc4_] as DisplayObject)
            {
               _loc1_ = _displayList[_loc4_] as DisplayObject;
               if(_lines.indexOf(_loc1_ as Image) < 0 && _loc1_ != _descriptionTxt && _loc1_ != _ghostSkillDesc)
               {
                  _loc5_ = Math.max(_loc1_.width,_loc5_);
               }
               PositionUtils.setPos(_loc1_,_loc6_);
               addChild(_loc1_);
               _loc6_.y = _loc1_.y + _loc1_.height + _loc3_;
            }
            _loc4_++;
         }
         _maxWidth = Math.max(_minWidth,_loc5_);
         if(_autoGhostWidth > _maxWidth)
         {
            _maxWidth = _autoGhostWidth;
         }
         if(_descriptionTxt.width != _maxWidth)
         {
            _descriptionTxt.width = _maxWidth;
            _descriptionTxt.height = _descriptionTxt.textHeight + 10;
            addChildren();
            return;
         }
         if(_ghostSkillDesc.width != _maxWidth)
         {
            _ghostSkillDesc.width = _maxWidth;
            _ghostSkillDesc.height = _ghostSkillDesc.textHeight + 10;
            addChildren();
            return;
         }
         if(!_isReAdd)
         {
            _loc4_ = 0;
            while(_loc4_ < _lines.length)
            {
               _lines[_loc4_].width = _maxWidth;
               if(_loc4_ + 1 < _lines.length && _lines[_loc4_ + 1].parent != null && Math.abs(_lines[_loc4_ + 1].y - _lines[_loc4_].y) <= 10)
               {
                  _displayList.splice(_displayList.indexOf(_lines[_loc4_ + 1]),1);
                  _lines[_loc4_ + 1].parent.removeChild(_lines[_loc4_ + 1]);
                  _isReAdd = true;
               }
               _loc4_++;
            }
            if(_isReAdd)
            {
               addChildren();
               return;
            }
         }
         if(_markContainer && !_markContainer.parent)
         {
            _markContainer.x = this.width;
            addChild(_markContainer);
         }
         if(_loc2_ > 0)
         {
            var _loc7_:* = _maxWidth + 8;
            _tipbackgound.width = _loc7_;
            _width = _loc7_;
            _loc7_ = _loc1_.y + _loc1_.height + 8;
            _tipbackgound.height = _loc7_;
            _height = _loc7_;
            if(_markContainer)
            {
               _height = _markContainer.height > _height?_markContainer.height:Number(_height);
            }
         }
         if(_tipbackgound)
         {
            addChildAt(_tipbackgound,0);
         }
         if(_remainTimeBg.parent)
         {
            _remainTimeBg.x = _remainTimeTxt.x + 2;
            _remainTimeBg.y = _remainTimeTxt.y + 2;
            _remainTimeBg.parent.addChildAt(_remainTimeBg,1);
         }
         addChild(_laterEquipmentGoodView);
         if(_enchantAttackTxt.parent)
         {
            _enchantAttackPencentTxt.x = _enchantAttackTxt.x + _enchantAttackTxt.width + 3;
            _enchantAttackPencentTxt.y = _enchantAttackTxt.y;
            addChild(_enchantAttackPencentTxt);
         }
         if(_enchantDefenceTxt.parent)
         {
            _enchantDefencePencentTxt.x = _enchantDefenceTxt.x + _enchantDefenceTxt.width + 3;
            _enchantDefencePencentTxt.y = _enchantDefenceTxt.y;
            addChild(_enchantDefencePencentTxt);
         }
      }
      
      private function createLatentEnergy() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(_info is InventoryItemInfo)
         {
            _loc2_ = _info as InventoryItemInfo;
            if(_loc2_.isHasLatentEnergy)
            {
               _loc1_ = _loc2_.latentEnergyCurList;
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  _loc3_ = new LatentEnergyTipItem();
                  _loc3_.setView(_loc4_,_loc1_[_loc4_]);
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _loc3_;
                  _loc4_++;
               }
            }
         }
      }
      
      private function creatLevel() : void
      {
         if(_info.CategoryID == 50 || _info.CategoryID == 51 || _info.CategoryID == 52)
         {
            _levelTxt.text = LanguageMgr.GetTranslation("ddt.petEquipLevel",_info.Property2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _levelTxt;
         }
      }
      
      private function createPetsSkill() : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_info is InventoryItemInfo)
         {
            _loc5_ = _info as InventoryItemInfo;
            _loc4_ = PetsBagManager.instance().getAwakenEquipInfo(_loc5_.ItemID.toString());
            if(_loc4_ == null)
            {
               return;
            }
            _loc6_ = new Sprite();
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.petsSkillTxt");
            _loc3_.text = _loc4_.belongPetName + LanguageMgr.GetTranslation("petsBag.petsAwaken.awakenEquipTips.petsTxt");
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _loc3_;
            if(_loc4_.skillId1 > 0)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.petsSkillNameTxt");
               _loc1_.text = _loc4_.getSkill1Info().Name;
               _loc6_.addChild(_loc1_);
            }
            if(_loc4_.skillId2 > 0)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.petsSkillNameTxt");
               _loc2_.text = _loc4_.getSkill2Info().Name;
               _loc2_.y = 25;
               _loc6_.addChild(_loc2_);
            }
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _loc6_;
         }
      }
      
      private function creatGemstone() : void
      {
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc10_:int = 0;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc6_:* = null;
         if(_info is InventoryItemInfo)
         {
            _loc3_ = _info as InventoryItemInfo;
            if(_loc3_.gemstoneList)
            {
               if(_loc3_.gemstoneList.length == 0)
               {
                  return;
               }
               _loc8_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.GoldenAddAttack");
               _loc5_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.GoldenReduceDamage");
               _loc10_ = 0;
               while(_loc10_ < 3)
               {
                  if(_loc3_.gemstoneList[_loc10_].level > 0)
                  {
                     _loc7_ = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameTxtString");
                     _loc9_ = new GemstonTipItem();
                     _displayIdx = Number(_displayIdx) + 1;
                     _displayList[Number(_displayIdx)] = _loc9_;
                     _loc2_ = _loc3_.gemstoneList[_loc10_].level;
                     if(_loc3_.gemstoneList[_loc10_].fightSpiritId == 100001)
                     {
                        if(_loc3_.gemstoneList[_loc10_].level == 6)
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneAtc",GemstoneManager.Instance.redInfoList[_loc2_].attack + _loc8_);
                        }
                        else
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.redGemstoneAtc",_loc2_,GemstoneManager.Instance.redInfoList[_loc2_].attack);
                        }
                        _loc1_ = GemstoneManager.Instance.redInfoList[_loc2_].attack;
                     }
                     else if(_loc3_.gemstoneList[_loc10_].fightSpiritId == 100002)
                     {
                        if(_loc3_.gemstoneList[_loc10_].level == 6)
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneDef",GemstoneManager.Instance.bluInfoList[_loc2_].defence + _loc5_);
                        }
                        else
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.bluGemstoneDef",_loc2_,GemstoneManager.Instance.bluInfoList[_loc2_].defence);
                        }
                        _loc1_ = GemstoneManager.Instance.bluInfoList[_loc2_].defence;
                     }
                     else if(_loc3_.gemstoneList[_loc10_].fightSpiritId == 100003)
                     {
                        if(_loc3_.gemstoneList[_loc10_].level == 6)
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneAgi",GemstoneManager.Instance.greInfoList[_loc2_].agility + _loc8_);
                        }
                        else
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.gesGemstoneAgi",_loc2_,GemstoneManager.Instance.greInfoList[_loc2_].agility);
                        }
                        _loc1_ = GemstoneManager.Instance.greInfoList[_loc2_].agility;
                     }
                     else if(_loc3_.gemstoneList[_loc10_].fightSpiritId == 100004)
                     {
                        if(_loc3_.gemstoneList[_loc10_].level == 6)
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneLuk",GemstoneManager.Instance.yelInfoList[_loc2_].luck + _loc5_);
                        }
                        else
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.yelGemstoneLuk",_loc2_,GemstoneManager.Instance.yelInfoList[_loc2_].luck);
                        }
                        _loc1_ = GemstoneManager.Instance.yelInfoList[_loc2_].luck;
                     }
                     else if(_loc3_.gemstoneList[_loc10_].fightSpiritId == 100005)
                     {
                        if(_loc3_.gemstoneList[_loc10_].level == 6)
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneHp",GemstoneManager.Instance.purpleInfoList[_loc2_].blood + _loc5_);
                        }
                        else
                        {
                           _loc4_ = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.purpleGemstoneLuk",_loc2_,GemstoneManager.Instance.purpleInfoList[_loc2_].blood);
                        }
                        _loc1_ = GemstoneManager.Instance.purpleInfoList[_loc2_].blood;
                     }
                     _loc6_ = {};
                     _loc6_.id = _loc3_.gemstoneList[_loc10_].fightSpiritId;
                     _loc6_.str = _loc4_;
                     _loc9_.setInfo(_loc6_);
                  }
                  _loc10_++;
               }
            }
         }
      }
      
      private function createItemName() : void
      {
         var _loc6_:* = null;
         var _loc11_:* = null;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc10_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         if(EquipType.isBead(int(_info.Property1)) || EquipType.isMagicStone(_info.CategoryID))
         {
            _nameTxt.text = _tipData.beadName;
         }
         else
         {
            _nameTxt.text = String(_info.Name);
         }
         var _loc5_:InventoryItemInfo = _info as InventoryItemInfo;
         if(_loc5_ && _loc5_.CategoryID == 70 && _loc5_.CategoryID != 74)
         {
            _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("ddtKingGrade.grade",_loc5_.StrengthenLevel);
         }
         else if(_loc5_ && _loc5_.StrengthenLevel > 0 && !EquipType.isMagicStone(_loc5_.CategoryID) && _loc5_.CategoryID != 19 && _loc5_.CategoryID != 74)
         {
            if(_loc5_.isGold)
            {
               if(_loc5_.StrengthenLevel > PathManager.solveStrengthMax())
               {
                  _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("store.view.exalt.goodTips",_loc5_.StrengthenLevel - 12);
               }
               else
               {
                  _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("wishBead.StrengthenLevel");
               }
            }
            else if(_loc5_.StrengthenLevel <= PathManager.solveStrengthMax())
            {
               _nameTxt.text = _nameTxt.text + ("(+" + (_info as InventoryItemInfo).StrengthenLevel + ")");
            }
            else if(_loc5_.StrengthenLevel > PathManager.solveStrengthMax())
            {
               _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("store.view.exalt.goodTips",_loc5_.StrengthenLevel - 12);
            }
         }
         var _loc7_:int = _nameTxt.text.indexOf("+");
         if(_loc7_ > 0)
         {
            _loc6_ = ComponentFactory.Instance.model.getSet("core.goodTip.ItemNameNumTxtFormat");
            _nameTxt.setTextFormat(_loc6_,_loc7_,_loc7_ + 1);
         }
         if(PlayerInfoViewControl.currentPlayer)
         {
            if(_loc5_ && _loc5_.Place == 12 && _loc5_.UserID == PlayerInfoViewControl.currentPlayer.ID && PlayerInfoViewControl.currentPlayer.necklaceLevel > 0 && _loc5_.CategoryID == 14)
            {
               _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.goodTip",PlayerInfoViewControl.currentPlayer.necklaceLevel);
            }
         }
         _nameTxt.textColor = QualityType.QUALITY_COLOR[getInfoQuality()];
         if(_tipData is GoodTipInfo && _loc5_ && _loc5_.UserID)
         {
            _loc11_ = _tipData as GoodTipInfo;
            if(_loc11_.suitIcon)
            {
               if(_loc5_.CategoryID == 1 || _loc5_.CategoryID == 2 || _loc5_.CategoryID == 3 || _loc5_.CategoryID == 4 || _loc5_.CategoryID == 5 || _loc5_.CategoryID == 6 || _loc5_.CategoryID == 8 || _loc5_.CategoryID == 9 || _loc5_.CategoryID == 13 || _loc5_.CategoryID == 14 || _loc5_.CategoryID == 15)
               {
                  _loc1_ = PlayerManager.Instance.findPlayer(_loc5_.UserID).fineSuitExp;
                  _loc4_ = FineSuitManager.Instance.getSuitVoByLevel(1).exp;
                  _loc10_ = FineSuitManager.Instance.getSuitVoByExp(_loc1_);
                  _loc2_ = _loc10_.level;
                  if(_loc2_ > 14)
                  {
                     _loc2_ = int(_loc2_ % 14) == 0?14:int(_loc2_ % 14);
                  }
                  _loc3_ = [0,1,2,3,4,5,11,13,12,16,9,10,7,8];
                  _loc9_ = _loc3_.indexOf(_loc5_.Place) + 1;
                  _loc8_ = _loc10_.type;
                  if(_loc9_ > _loc2_)
                  {
                     _loc8_--;
                  }
                  if(_loc1_ < _loc4_ || _loc8_ <= 0)
                  {
                     _displayIdx = Number(_displayIdx) + 1;
                     _displayList[Number(_displayIdx)] = _nameTxt;
                     return;
                  }
                  _suitIcon.setFrame(_loc8_);
                  _nameContent.addChild(_suitIcon);
                  _nameContent.addChild(_nameTxt);
                  var _loc12_:int = 0;
                  _suitIcon.y = _loc12_;
                  _suitIcon.x = _loc12_;
                  _nameTxt.x = 30;
                  _nameTxt.y = 8;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _nameContent;
                  return;
               }
            }
         }
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _nameTxt;
      }
      
      private function createQualityItem() : void
      {
         var _loc1_:FilterFrameText = _qualityItem.foreItems[0] as FilterFrameText;
         _loc1_.text = QualityType.QUALITY_STRING[getInfoQuality()];
         _loc1_.textColor = QualityType.QUALITY_COLOR[getInfoQuality()];
         if(!EquipType.isBead(int(_info.Property1)))
         {
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _qualityItem;
         }
      }
      
      private function getInfoQuality() : int
      {
         if(_info.CategoryID == 69)
         {
            return HorseAmuletManager.instance.getHorseAmuletVo(_info.TemplateID).Quality;
         }
         if(_info.CategoryID == 70)
         {
            if(_info is InventoryItemInfo)
            {
               return EquipAmuletManager.Instance.getAmuletPhaseByGrade((_info as InventoryItemInfo).StrengthenLevel);
            }
            return 1;
         }
         return _info.Quality;
      }
      
      private function createCategoryItem() : void
      {
         var _loc1_:FilterFrameText = _typeItem.foreItems[0] as FilterFrameText;
         var _loc2_:Array = EquipType.PARTNAME;
         if(_info.CategoryID == 31)
         {
            _loc1_.text = LanguageMgr.GetTranslation("tank.data.EquipType.tempHelp");
         }
         else if(_info.CategoryID == 222222222)
         {
            _loc1_.text = LanguageMgr.GetTranslation("tank.data.EquipType.normal");
         }
         else if(_info.CategoryID == 80)
         {
            _loc1_.text = LanguageMgr.GetTranslation("tank.data.EquipType.fuzhudaoju");
         }
         else if(_info.Property1 == "31")
         {
            var _loc3_:* = _info.Property2;
            if("1" !== _loc3_)
            {
               if("2" !== _loc3_)
               {
                  if("3" === _loc3_)
                  {
                     _loc1_.text = LanguageMgr.GetTranslation("tank.data.EquipType.attribute");
                  }
               }
               else
               {
                  _loc1_.text = LanguageMgr.GetTranslation("tank.data.EquipType.defent");
               }
            }
            else
            {
               _loc1_.text = LanguageMgr.GetTranslation("tank.data.EquipType.atacckt");
            }
         }
         else
         {
            _loc1_.text = EquipType.PARTNAME[_info.CategoryID] + "";
         }
         if(EquipType.isBead(int(_info.Property1)))
         {
            _loc1_.textColor = 65406;
         }
         if(_info.TemplateID == 20150 || _info.TemplateID == 201266)
         {
            _loc1_.text = EquipType.PARTNAME[23];
         }
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _typeItem;
      }
      
      private function careteEXP() : void
      {
         var _loc1_:FilterFrameText = _expItem.foreItems[0] as FilterFrameText;
         if(EquipType.isBead(int(_info.Property1)) || EquipType.isMagicStone(_info.CategoryID) || EquipType.canBringUp(_info))
         {
            _loc1_.text = _exp + "/" + _UpExp;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _expItem;
         }
      }
      
      private function createMainProperty() : void
      {
         var _loc11_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = null;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:String = "";
         var _loc4_:int = 0;
         var _loc1_:FilterFrameText = _mainPropertyItem.foreItems[0] as FilterFrameText;
         var _loc7_:ScaleFrameImage = _mainPropertyItem.backItem as ScaleFrameImage;
         var _loc13_:InventoryItemInfo = _info as InventoryItemInfo;
         GhostStarContainer(_mainPropertyItem.foreItems[1]).visible = false;
         GhostStarContainer(_armAngleItem.foreItems[1]).visible = false;
         _autoGhostWidth = 0;
         var _loc10_:uint = 0;
         var _loc2_:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         if(EquipType.isArm(_info))
         {
            _loc11_ = 0;
            if(_loc13_ && _loc13_.StrengthenLevel > 0)
            {
               _loc4_ = !!_loc13_.isGold?_loc13_.StrengthenLevel + 1:_loc13_.StrengthenLevel;
               _loc11_ = Number(StaticFormula.getHertAddition(int(_loc13_.Property7),_loc4_));
            }
            _loc7_.setFrame(1);
            _loc10_ = _loc11_ + (!!_ghostPropertyData?_ghostPropertyData.mainProperty:0);
            _loc12_ = _loc10_ > 0?"(+" + _loc10_ + ")":"";
            _loc1_.text = " " + _info.Property7.toString() + _loc12_;
            FilterFrameText(_armAngleItem.foreItems[0]).text = " " + _info.Property5 + "°~" + _info.Property6 + "°";
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _armAngleItem;
            if(_ghostPropertyData != null)
            {
               _ghostStartsContainer = _armAngleItem.foreItems[1] as GhostStarContainer;
               _ghostStartsContainer.x = _armAngleItem.foreItems[0].width + _armAngleItem.foreItems[0].x;
               _ghostStartsContainer.y = _armAngleItem.foreItems[0].y + 8;
               _ghostStartsContainer.maxLv = EquipGhostManager.getInstance().model.topLvDic[_info.CategoryID == 27?7:_info.CategoryID];
               _ghostStartsContainer.level = _loc2_.getGhostDataByCategoryID(_info.CategoryID).level;
               _ghostStartsContainer.visible = true;
               _autoGhostWidth = _ghostStartsContainer.x + _ghostStartsContainer.width;
            }
         }
         else if(EquipType.isArmShell(_info))
         {
            FilterFrameText(_armAngleItem.foreItems[0]).text = " " + _info.Property5 + "°~" + _info.Property6 + "°";
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _armAngleItem;
         }
         else if(EquipType.isHead(_info) || EquipType.isCloth(_info))
         {
            _loc8_ = 0;
            if(_loc13_ && _loc13_.StrengthenLevel > 0)
            {
               _loc4_ = !!_loc13_.isGold?_loc13_.StrengthenLevel + 1:_loc13_.StrengthenLevel;
               _loc8_ = Number(StaticFormula.getDefenseAddition(int(_loc13_.Property7),_loc4_));
            }
            _loc7_.setFrame(2);
            _loc10_ = _loc8_ + (_ghostPropertyData != null?_ghostPropertyData.mainProperty:0);
            _loc12_ = _loc10_ > 0?"(+" + _loc10_ + ")":"";
            _loc1_.text = " " + _info.Property7.toString() + _loc12_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
            if(_loc13_ && _loc13_.isGold)
            {
               FilterFrameText(_otherHp.foreItems[0]).text = _loc13_.Boold.toString();
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _otherHp;
            }
            if(_ghostPropertyData != null)
            {
               _ghostStartsContainer = _mainPropertyItem.foreItems[1] as GhostStarContainer;
               _ghostStartsContainer.maxLv = EquipGhostManager.getInstance().model.topLvDic[_info.CategoryID == 27?7:_info.CategoryID];
               _ghostStartsContainer.x = _mainPropertyItem.foreItems[0].width + _mainPropertyItem.foreItems[0].x;
               _ghostStartsContainer.y = _mainPropertyItem.foreItems[0].y + 8;
               _ghostStartsContainer.level = _loc2_.getGhostDataByCategoryID(_info.CategoryID).level;
               _ghostStartsContainer.visible = true;
               _autoGhostWidth = _ghostStartsContainer.x + _ghostStartsContainer.width;
            }
         }
         else if(StaticFormula.isDeputyWeapon(_info) || _info.CategoryID == 31)
         {
            _loc9_ = " ";
            if(_info.Property3 == "32")
            {
               if(_loc13_ && _loc13_.StrengthenLevel > 0)
               {
                  _loc4_ = !!_loc13_.isGold?_loc13_.StrengthenLevel + 1:_loc13_.StrengthenLevel;
                  _loc12_ = "(+" + StaticFormula.getRecoverHPAddition(int(_loc13_.Property7),_loc4_) + ")";
               }
               _loc7_.setFrame(3);
               _loc9_ = "   ";
            }
            else
            {
               if(_loc13_ && _loc13_.StrengthenLevel > 0)
               {
                  _loc4_ = !!_loc13_.isGold?_loc13_.StrengthenLevel + 1:_loc13_.StrengthenLevel;
                  _loc12_ = "(+" + StaticFormula.getDefenseAddition(int(_loc13_.Property7),_loc4_) + ")";
               }
               _loc7_.setFrame(4);
               _loc9_ = "            ";
            }
            _loc1_.text = " " + _info.Property7.toString() + _loc12_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
         }
         if(_loc1_)
         {
            _loc5_ = ComponentFactory.Instance.model.getSet("ddt.store.view.exalt.LaterEquipmentViewTextTF");
            _loc3_ = _loc1_.text.indexOf("(");
            _loc6_ = _loc1_.text.indexOf(")") + 1;
            if(_loc3_ != -1 && _loc6_ != 0)
            {
               _loc1_.setTextFormat(_loc5_,_loc3_,_loc6_);
            }
         }
      }
      
      private function createArmShellProperty() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(EquipType.isArmShell(_info))
         {
            _armShellProtertyTxts[0].text = LanguageMgr.GetTranslation("ddt.armShellClip.damageTips",LanguageMgr.GetTranslation("ddt.armShellClip.normalDamageTips"),Number(ServerConfigManager.instance.weaponShellNormalAdd / 10));
            _armShellProtertyTxts[0].textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _armShellProtertyTxts[0];
            if(_info is InventoryItemInfo)
            {
               _loc2_ = InventoryItemInfo(_info);
               if(_loc2_.AttackCompose > 0 && _loc2_.DefendCompose > 0)
               {
                  _loc1_ = ItemManager.Instance.getTemplateById(_loc2_.AttackCompose);
                  if(_loc1_)
                  {
                     _armShellProtertyTxts[1].text = LanguageMgr.GetTranslation("ddt.armShellClip.damageTips",_loc1_.Name,Number(_loc2_.DefendCompose / 10));
                     _armShellProtertyTxts[1].textColor = 16750899;
                     _displayIdx = Number(_displayIdx) + 1;
                     _displayList[Number(_displayIdx)] = _armShellProtertyTxts[1];
                  }
               }
            }
         }
      }
      
      private function createNecklaceItem() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(_info.CategoryID == 14)
         {
            _necklaceItem.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.life") + ":" + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.advance") + _info.Property1 + "%";
            _loc1_ = _info as InventoryItemInfo;
            if(_loc1_ && _loc1_.Place == 12 && PlayerInfoViewControl.currentPlayer && _loc1_.UserID == PlayerInfoViewControl.currentPlayer.ID && PlayerInfoViewControl.currentPlayer.necklaceLevel > 0)
            {
               _loc2_ = StoreEquipExperience.getNecklaceStrengthPlus(PlayerInfoViewControl.currentPlayer.necklaceLevel);
               _necklaceItem.text = _necklaceItem.text + LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.goodTipII",_loc2_);
            }
            _necklaceItem.textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _necklaceItem;
         }
         else if(_info.CategoryID == 19)
         {
            _necklaceItem.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.life") + ":" + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.reply") + _info.Property2;
            _necklaceItem.textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _necklaceItem;
         }
      }
      
      private function createProperties() : void
      {
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc10_:String = "";
         var _loc6_:String = "";
         var _loc2_:String = "";
         var _loc5_:String = "";
         var _loc7_:String = "";
         var _loc13_:String = "";
         var _loc1_:String = "";
         var _loc4_:String = "";
         if(_info is InventoryItemInfo && !EquipType.isMagicStone(_info.CategoryID))
         {
            _loc8_ = _info as InventoryItemInfo;
            if(_loc8_.AttackCompose > 0)
            {
               _loc10_ = "(+" + String(_loc8_.AttackCompose) + ")";
            }
            if(_loc8_.DefendCompose > 0)
            {
               _loc6_ = "(+" + String(_loc8_.DefendCompose) + ")";
            }
            if(_loc8_.AgilityCompose > 0)
            {
               _loc2_ = "(+" + String(_loc8_.AgilityCompose) + ")";
            }
            if(_loc8_.LuckCompose > 0)
            {
               _loc5_ = "(+" + String(_loc8_.LuckCompose) + ")";
            }
         }
         if(_ghostPropertyData != null)
         {
            if(_ghostPropertyData.attack > 0)
            {
               _loc7_ = LanguageMgr.GetTranslation("equipGhost.tip",_ghostPropertyData.attack);
            }
            if(_ghostPropertyData.defend > 0)
            {
               _loc13_ = LanguageMgr.GetTranslation("equipGhost.tip",_ghostPropertyData.defend);
            }
            if(_ghostPropertyData.lucky > 0)
            {
               _loc4_ = LanguageMgr.GetTranslation("equipGhost.tip",_ghostPropertyData.lucky);
            }
            if(_ghostPropertyData.agility > 0)
            {
               _loc1_ = LanguageMgr.GetTranslation("equipGhost.tip",_ghostPropertyData.agility);
            }
         }
         if(_info.Attack != 0)
         {
            _attackTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.fire") + ":" + String(_info.Attack) + _loc10_) + _loc7_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _attackTxt;
         }
         if(_info.Defence != 0)
         {
            _defenseTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.recovery") + ":" + String(_info.Defence) + _loc6_) + _loc13_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _defenseTxt;
         }
         if(_info.Agility != 0)
         {
            _agilityTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.agility") + ":" + String(_info.Agility) + _loc2_) + _loc1_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _agilityTxt;
         }
         if(_info.Luck != 0)
         {
            _luckTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.lucky") + ":" + String(_info.Luck) + _loc5_) + _loc4_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _luckTxt;
         }
         if(_info.MagicAttack != 0)
         {
            _magicAttackTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicAttack") + ":" + String(_info.MagicAttack);
            _magicAttackTxt.textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _magicAttackTxt;
         }
         if(_info.MagicDefence != 0)
         {
            _magicDefenceTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicDefence") + ":" + String(_info.MagicDefence);
            _magicDefenceTxt.textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _magicDefenceTxt;
         }
         var _loc9_:InventoryItemInfo = _info as InventoryItemInfo;
         if(!_loc9_ && EquipType.isMagicStone(_info.CategoryID))
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
            switch(int(_info.Property3) - 2)
            {
               case 0:
                  _loc3_.text = LanguageMgr.GetTranslation("magicStone.canGetTwoAbove");
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _loc3_;
                  break;
               case 1:
                  _loc3_.text = LanguageMgr.GetTranslation("magicStone.canGetThreeAbove");
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _loc3_;
                  break;
               case 2:
                  _loc3_.text = LanguageMgr.GetTranslation("magicStone.canGetFourAbove");
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _loc3_;
            }
            _loc3_.textColor = 16777215;
         }
         if(_info.TemplateID == 334100)
         {
            _gp.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.gp") + ":" + InventoryItemInfo(_info).DefendCompose;
            _gp.textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _gp;
            _maxGP.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.maxGP") + ":" + InventoryItemInfo(_info).AgilityCompose;
            _maxGP.textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _maxGP;
         }
         if(_info.CategoryID == 70)
         {
            _loc11_ = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
            if(_loc9_)
            {
               _loc12_ = EquipAmuletManager.Instance.getAmuletHpByGrade(_loc9_.StrengthenLevel);
               _loc11_.text = LanguageMgr.GetTranslation("MaxHp") + ":" + _loc12_;
               _loc11_.textColor = 16750899;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _loc11_;
               if(_loc9_.Hole1 > 0)
               {
                  _attackTxt.text = HorseAmuletManager.instance.getByExtendType(_loc9_.Hole1) + ":" + _loc9_.equipAmuletProperty1;
                  _attackTxt.textColor = 16750899;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _attackTxt;
                  _defenseTxt.text = HorseAmuletManager.instance.getByExtendType(_loc9_.Hole2) + ":" + _loc9_.equipAmuletProperty2;
                  _defenseTxt.textColor = 16750899;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _defenseTxt;
                  _agilityTxt.text = HorseAmuletManager.instance.getByExtendType(_loc9_.Hole3) + ":" + _loc9_.equipAmuletProperty3;
                  _agilityTxt.textColor = 16750899;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _agilityTxt;
                  _luckTxt.text = HorseAmuletManager.instance.getByExtendType(_loc9_.Hole4) + ":" + _loc9_.equipAmuletProperty4;
                  _luckTxt.textColor = 16750899;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _luckTxt;
               }
               else
               {
                  _attackTxt.text = LanguageMgr.GetTranslation("tank.equipAmulet.notActivateAmulet");
                  _attackTxt.textColor = 16750899;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _attackTxt;
               }
            }
            else
            {
               _loc12_ = EquipAmuletManager.Instance.getAmuletHpByGrade(1);
               _loc11_.text = LanguageMgr.GetTranslation("MaxHp") + ":" + _loc12_;
               _loc11_.textColor = 16750899;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _loc11_;
               _attackTxt.text = LanguageMgr.GetTranslation("tank.equipAmulet.notActivateAmulet");
               _attackTxt.textColor = 16750899;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _attackTxt;
            }
         }
      }
      
      private function createGhostSkillitem() : void
      {
         var _loc3_:* = null;
         if(!_ghostPropertyData)
         {
            return;
         }
         var _loc1_:PlayerInfo = !!PlayerInfoViewControl.currentPlayer?PlayerInfoViewControl.currentPlayer:PlayerManager.Instance.Self;
         var _loc2_:EquipGhostData = _loc1_.getGhostDataByCategoryID(_info.CategoryID);
         if(_loc2_)
         {
            _loc3_ = EquipGhostManager.getInstance().model.getGhostData(_info.CategoryID == 27?7:_info.CategoryID,_loc2_.level);
            if(_loc3_)
            {
               _ghostSkillDesc.text = StringHelper.format(PetSkillManager.getSkillByID(_loc3_.skillId).Description);
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _ghostSkillDesc;
            }
         }
      }
      
      private function createHoleItem() : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc1_:* = null;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         if(!StringHelper.isNullOrEmpty(_info.Hole))
         {
            _loc6_ = [];
            _loc7_ = _info.Hole.split("|");
            _loc1_ = _info as InventoryItemInfo;
            if(_loc7_.length > 0 && String(_loc7_[0]) != "" && _loc1_ != null)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  _loc2_ = String(_loc7_[_loc8_]);
                  _loc3_ = _loc2_.split(",");
                  if(_loc8_ < 4)
                  {
                     if(int(_loc3_[0]) > 0 && int(_loc3_[0]) - _loc1_.StrengthenLevel <= 3 || getHole(_loc1_,_loc8_ + 1) >= 0)
                     {
                        _loc4_ = _loc3_[0];
                        _loc5_ = createSingleHole(_loc1_,_loc8_,_loc4_,_loc3_[1]);
                        _displayIdx = Number(_displayIdx) + 1;
                        _displayList[Number(_displayIdx)] = _loc5_;
                     }
                  }
                  else if(_loc1_["Hole" + (_loc8_ + 1) + "Level"] >= 1 || _loc1_["Hole" + (_loc8_ + 1)] > 0)
                  {
                     _loc5_ = createSingleHole(_loc1_,_loc8_,2147483647,_loc3_[1]);
                     _displayIdx = Number(_displayIdx) + 1;
                     _displayList[Number(_displayIdx)] = _loc5_;
                  }
                  _loc8_++;
               }
            }
         }
      }
      
      private function createSingleHole(param1:InventoryItemInfo, param2:int, param3:int, param4:int) : FilterFrameText
      {
         var _loc6_:* = null;
         var _loc8_:int = 0;
         var _loc7_:FilterFrameText = _holes[param2];
         var _loc5_:int = getHole(param1,param2 + 1);
         if(param1.StrengthenLevel >= param3)
         {
            if(_loc5_ <= 0)
            {
               _loc7_.text = getHoleType(param4) + ":" + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holeenable");
               _loc7_.textColor = 16777215;
            }
            else
            {
               _loc6_ = ItemManager.Instance.getTemplateById(_loc5_);
               if(_loc6_)
               {
                  _loc7_.text = _loc6_.Data;
                  _loc7_.textColor = 16776960;
               }
            }
         }
         else if(param2 >= 4)
         {
            _loc8_ = param1["Hole" + (param2 + 1) + "Level"];
            if(_loc5_ > 0)
            {
               _loc6_ = ItemManager.Instance.getTemplateById(_loc5_);
               _loc7_.text = _loc6_.Data + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holeLv",param1["Hole" + (param2 + 1) + "Level"]);
               if(Math.floor(_loc6_.Level + 1 >> 1) <= _loc8_)
               {
                  _loc7_.textColor = 16776960;
               }
               else
               {
                  _loc7_.textColor = 6710886;
               }
            }
            else
            {
               _loc7_.text = getHoleType(param4) + StringHelper.format(LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holeLv",param1["Hole" + (param2 + 1) + "Level"]));
               _loc7_.textColor = 16777215;
            }
         }
         else if(_loc5_ <= 0)
         {
            _loc7_.text = getHoleType(param4) + StringHelper.format(LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holerequire"),param3.toString());
            _loc7_.textColor = 6710886;
         }
         else
         {
            _loc6_ = ItemManager.Instance.getTemplateById(_loc5_);
            if(_loc6_)
            {
               _loc7_.text = _loc6_.Data + StringHelper.format(LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holerequire"),param3.toString());
               _loc7_.textColor = 6710886;
            }
         }
         return _loc7_;
      }
      
      public function getHole(param1:InventoryItemInfo, param2:int) : int
      {
         return int(param1["Hole" + param2.toString()]);
      }
      
      private function getHoleType(param1:int) : String
      {
         switch(int(param1) - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.trianglehole");
            case 1:
               return LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.recthole");
            case 2:
               return LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.ciclehole");
         }
      }
      
      private function createOperationItem() : void
      {
         var _loc1_:int = 0;
         if(_info.NeedLevel > 1 && _info.TemplateID != 20150 && _info.TemplateID != 201266)
         {
            if(PlayerManager.Instance.Self.Grade >= _info.NeedLevel)
            {
               _loc1_ = 13421772;
            }
            else
            {
               _loc1_ = 16711680;
            }
            _needLevelTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.need") + ":" + String(_info.NeedLevel);
            _needLevelTxt.textColor = _loc1_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _needLevelTxt;
         }
         if(_info.NeedSex == 1)
         {
            _needSexTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.man");
            _needSexTxt.textColor = !!PlayerManager.Instance.Self.Sex?10092339:16711680;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _needSexTxt;
         }
         else if(_info.NeedSex == 2)
         {
            _needSexTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.woman");
            _needSexTxt.textColor = !!PlayerManager.Instance.Self.Sex?16711680:10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _needSexTxt;
         }
         var _loc2_:String = "";
         if(_info.CanStrengthen && _info.CanCompose && _info.CategoryID != 27)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.may");
            if(EquipType.isRongLing(_info))
            {
               _loc2_ = _loc2_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.melting");
            }
            _upgradeType.text = _loc2_;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(_info.CanCompose && !EquipType.isMagicStone(_info.CategoryID) && _info.CategoryID != 27)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.compose");
            if((_info.CategoryID == 8 || _info.CategoryID == 9) && !EquipType.isWeddingRing(_info))
            {
               _loc2_ = _loc2_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.bringUp");
            }
            else if(EquipType.isRongLing(_info))
            {
               _loc2_ = _loc2_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.melting");
            }
            _upgradeType.text = _loc2_;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(_info.CanStrengthen && _info.CategoryID != 27)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.strong");
            if(EquipType.isRongLing(_info))
            {
               _loc2_ = _loc2_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.melting");
            }
            _upgradeType.text = _loc2_;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(EquipType.isRongLing(_info))
         {
            _loc2_ = _loc2_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.canmelting");
            _upgradeType.text = _loc2_;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(_info.CategoryID == 31 || _info.CategoryID == 31)
         {
            _loc2_ = _loc2_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.strong");
            _upgradeType.text = "   ";
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
      }
      
      private function createArmShellName() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         if(EquipType.isArm(_info) && _info is InventoryItemInfo && PlayerInfoViewControl.currentPlayer)
         {
            _loc2_ = InventoryItemInfo(_info);
            if(_loc2_.Place == 6)
            {
               _loc3_ = LanguageMgr.GetTranslation("tank.room.difficulty.none");
               _loc1_ = PlayerInfoViewControl.currentPlayer.Bag.getItemAt(20);
               if(_loc1_)
               {
                  _loc3_ = _loc1_.Name;
               }
               _armShellNameTxt.text = LanguageMgr.GetTranslation("tank.data.EquipType.armShell") + ":" + _loc3_;
               _armShellNameTxt.textColor = 16711680;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _armShellNameTxt;
            }
         }
      }
      
      private function createDescript() : void
      {
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(_info.Description == "")
         {
            return;
         }
         if(_info.CategoryID == 50 || _info.CategoryID == 51 || _info.CategoryID == 52 || _info.CategoryID == 9)
         {
            return;
         }
         if(_info.CategoryID == 222222222)
         {
            _loc1_ = _info as InventoryItemInfo;
            _loc5_ = ItemActivityGiftManager.instance.model.itemEveryDayRecord[_loc1_.TemplateID + "," + _loc1_.ItemID];
            if(_loc5_)
            {
               _loc6_ = _info.Description.split("|");
               if(_loc6_.length > 1)
               {
                  _descriptionTxt.text = _loc6_[_loc5_.OpenIndex] + "";
               }
               else
               {
                  _descriptionTxt.text = _loc6_[0] + "";
               }
            }
         }
         else if(_info.CategoryID == 69)
         {
            _loc3_ = HorseAmuletManager.instance.data[_info.TemplateID];
            _descriptionTxt.text = StringHelper.format(_loc3_.Desc,_loc3_.BaseType1Value,(_info as InventoryItemInfo).Hole1);
         }
         else if(_info.Property1 != "31")
         {
            _descriptionTxt.text = _info.Description + "";
         }
         else
         {
            _loc2_ = _info as InventoryItemInfo;
            _loc4_ = BeadTemplateManager.Instance.GetBeadInfobyID(_info.TemplateID);
            if(_loc4_.Attribute1 == "0" && _loc4_.Attribute2 == "0")
            {
               _descriptionTxt.text = StringHelper.format(_info.Description);
            }
            else if(_loc4_.Attribute1 == "0" && _loc4_.Attribute2 != "0")
            {
               if(_loc4_.Att2.length > 1)
               {
                  if(_loc2_ && _loc2_.Hole1 > _loc4_.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att2[1],_loc4_.Att3[1]);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att2[0]);
                  }
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Attribute2);
               }
            }
            else if(_loc4_.Attribute1 != "0" && _loc4_.Attribute2 == "0")
            {
               if(_loc4_.Att1.length > 1)
               {
                  if(_loc2_ && _loc2_.Hole1 > _loc4_.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[1]);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[0]);
                  }
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Attribute1);
               }
            }
            else if(_loc4_.Attribute1 != "0" && _loc4_.Attribute2 != "0" && _loc4_.Attribute3 == "0")
            {
               if(_loc4_.Att1.length > 1 && _loc4_.Att2.length == 1)
               {
                  if(_loc2_ && _loc2_.Hole1 > _loc4_.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[1],_loc4_.Attribute2);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[0],_loc4_.Attribute2);
                  }
               }
               else if(_loc4_.Att1.length == 1 && _loc4_.Att2.length > 1)
               {
                  if(_loc2_ && _loc2_.Hole1 > _loc4_.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Attribute1,_loc4_.Att2[1]);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Attribute1,_loc4_.Att2[0]);
                  }
               }
               else if(_loc2_ && _loc2_.Hole1 > _loc4_.BaseLevel)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[1],_loc4_.Att2[1],_loc4_.Att3[1]);
               }
               else if(_loc4_.Type3 > 0)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[0],_loc4_.Att2[0],_loc4_.Att3[0]);
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[0],_loc4_.Att2[0]);
               }
            }
            else if(_loc4_.Attribute1 != "0" && _loc4_.Attribute2 != "0" && _loc4_.Attribute3 != "0")
            {
               if(_loc4_.Att1.length != 1)
               {
                  if(_loc2_ && _loc2_.Hole1 > _loc4_.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[1],_loc4_.Att2[1],_loc4_.Att3[1]);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[0],_loc4_.Att2[0],_loc4_.Att3[0]);
                  }
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc4_.Att1[0],_loc4_.Att2[0],_loc4_.Att3[0]);
               }
            }
         }
         _descriptionTxt.height = _descriptionTxt.textHeight + 10;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _descriptionTxt;
      }
      
      private function ShowBound(param1:InventoryItemInfo) : Boolean
      {
         return param1.CategoryID != 32 && param1.CategoryID != 33 && param1.CategoryID != 36;
      }
      
      private function createBindType() : void
      {
         var _loc1_:* = null;
         if(SyahManager.Instance.inView)
         {
            return;
         }
         var _loc2_:InventoryItemInfo = _info as InventoryItemInfo;
         if(_loc2_ && ShowBound(_loc2_) && _loc2_.isShowBind)
         {
            _boundImage.setFrame(!!_loc2_.IsBinds?1:uint(2));
            _loc1_ = _typeItem.foreItems[0] as FilterFrameText;
            _bindImageOriginalPos.x = _loc1_.x + _loc1_.width + 50;
            PositionUtils.setPos(_boundImage,_bindImageOriginalPos);
            _minWidth = _boundImage.x + _boundImage.width > _minWidth?_boundImage.x + _boundImage.width:_minWidth;
            addChild(_boundImage);
            if(!_loc2_.IsBinds)
            {
               if(_loc2_.BindType == 3)
               {
                  _bindTypeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.bangding");
                  _bindTypeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _bindTypeTxt;
               }
               else if(_info.BindType == 2)
               {
                  _bindTypeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.zhuangbei");
                  _bindTypeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _bindTypeTxt;
               }
               else if(_info.BindType == 4)
               {
                  if(_boundImage.parent)
                  {
                     _boundImage.parent.removeChild(_boundImage);
                  }
               }
            }
         }
         else if(_boundImage.parent)
         {
            _boundImage.parent.removeChild(_boundImage);
         }
         if(_maxWidth < _boundImage.x + _boundImage.width)
         {
            _maxWidth = _boundImage.x + _boundImage.width + 50;
            _tipbackgound.width = _maxWidth;
         }
      }
      
      protected function cantAddPrice() : void
      {
      }
      
      protected function createRemainTime() : void
      {
         var _loc7_:Number = NaN;
         var _loc6_:* = null;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc3_:* = null;
         var _loc9_:* = NaN;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = 0;
         if(_remainTimeBg.parent)
         {
            _remainTimeBg.parent.removeChild(_remainTimeBg);
         }
         if(_info is InventoryItemInfo)
         {
            _loc6_ = _info as InventoryItemInfo;
            _loc4_ = _loc6_.getRemainDate();
            _loc8_ = _loc6_.getColorValidDate();
            _loc3_ = _loc6_.CategoryID == 7?LanguageMgr.GetTranslation("bag.changeColor.tips.armName"):"";
            if(_loc8_ > 0 && _loc8_ != 2147483647)
            {
               if(_loc8_ >= 1)
               {
                  _remainTimeTxt.text = (!!_loc6_.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + Math.ceil(_loc8_) + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               else
               {
                  _loc9_ = Number(Math.floor(_loc8_ * 24));
                  if(_loc9_ < 1)
                  {
                     _loc9_ = 1;
                  }
                  _remainTimeTxt.text = (!!_loc6_.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc9_ + LanguageMgr.GetTranslation("hours");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
            }
            if(_loc4_ == 2147483647)
            {
               _remainTimeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
               _remainTimeTxt.textColor = 16776960;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _remainTimeTxt;
            }
            else if(_loc4_ > 0)
            {
               if(_loc4_ >= 1)
               {
                  _loc7_ = Math.ceil(_loc4_);
                  _remainTimeTxt.text = (!!_loc6_.IsUsed?_loc3_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc7_ + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               else if(_loc4_ * 24 >= 1)
               {
                  _loc7_ = Math.floor(_loc4_ * 24);
                  _loc7_ = _loc7_ < 1?1:Number(_loc7_);
                  _remainTimeTxt.text = (!!_loc6_.IsUsed?_loc3_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc7_ + LanguageMgr.GetTranslation("hours");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               else if(_loc4_ * 24 * 60 >= 1)
               {
                  _loc7_ = Math.floor(_loc4_ * 24 * 60);
                  _loc7_ = _loc7_ < 1?1:Number(_loc7_);
                  _remainTimeTxt.text = (!!_loc6_.IsUsed?_loc3_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc7_ + LanguageMgr.GetTranslation("minute");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               addChild(_remainTimeBg);
            }
            else if(!isNaN(_loc4_))
            {
               _remainTimeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.over");
               _remainTimeTxt.textColor = 16711680;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _remainTimeTxt;
            }
            if(_loc6_.isHasLatentEnergy)
            {
               _loc2_ = TimeManager.Instance.getMaxRemainDateStr(_loc6_.latentEnergyEndTime,2);
               _loc1_ = _remainTimeTxt.text;
               _loc1_ = _loc1_ + LanguageMgr.GetTranslation("ddt.latentEnergy.tipRemainDateTxt",_loc2_);
               _loc5_ = uint(_remainTimeTxt.textColor);
               _remainTimeTxt.text = _loc1_;
               _remainTimeTxt.textColor = _loc5_;
            }
         }
      }
      
      private function createGoldRemainTime() : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:* = null;
         var _loc5_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc2_:* = null;
         if(SyahManager.Instance.inView)
         {
            return;
         }
         if(_info is InventoryItemInfo)
         {
            _loc3_ = _info as InventoryItemInfo;
            _loc5_ = _loc3_.getGoldRemainDate();
            _loc1_ = _loc3_.goldValidDate;
            _loc2_ = _loc3_.goldBeginTime;
            if((_info as InventoryItemInfo).isGold)
            {
               if(_loc5_ >= 1)
               {
                  _loc4_ = Math.ceil(_loc5_);
                  _goldRemainTimeTxt.text = LanguageMgr.GetTranslation("wishBead.GoodsTipPanel.txt1") + _loc4_ + LanguageMgr.GetTranslation("wishBead.GoodsTipPanel.txt2");
               }
               else
               {
                  _loc4_ = Math.floor(_loc5_ * 24);
                  _loc4_ = _loc4_ < 1?1:Number(_loc4_);
                  _goldRemainTimeTxt.text = LanguageMgr.GetTranslation("wishBead.GoodsTipPanel.txt1") + _loc4_ + LanguageMgr.GetTranslation("wishBead.GoodsTipPanel.txt3");
               }
               addChild(_remainTimeBg);
               _goldRemainTimeTxt.textColor = 16777215;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _goldRemainTimeTxt;
            }
         }
      }
      
      private function createFightPropConsume() : void
      {
         if(_info.CategoryID == 10)
         {
            _fightPropConsumeTxt.text = " " + LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip.consume") + _info.Property4;
            _fightPropConsumeTxt.textColor = 14520832;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _fightPropConsumeTxt;
         }
      }
      
      private function createBoxTimeItem() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(EquipType.isTimeBox(_info))
         {
            _loc2_ = DateUtils.getDateByStr((_info as InventoryItemInfo).BeginDate);
            _loc1_ = int(_info.Property3) * 60 - (TimeManager.Instance.Now().getTime() - _loc2_.getTime()) / 1000;
            if(_loc1_ > 0)
            {
               _loc4_ = _loc1_ / 3600;
               _loc3_ = _loc1_ % 3600 / 60;
               _loc3_ = _loc3_ > 0?_loc3_:1;
               _boxTimeTxt.text = LanguageMgr.GetTranslation("ddt.userGuild.boxTip",_loc4_,_loc3_);
               _boxTimeTxt.textColor = 16777215;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _boxTimeTxt;
            }
         }
      }
      
      private function createStrenthLevel() : void
      {
         var _loc1_:InventoryItemInfo = _info as InventoryItemInfo;
         if(_loc1_ && _loc1_.StrengthenLevel > 0 && !EquipType.isMagicStone(_info.CategoryID) && _loc1_.CategoryID != 70 && _loc1_.CategoryID != 19 && _loc1_.CategoryID != 74)
         {
            if(_loc1_.isGold)
            {
               _strengthenLevelImage.setFrame(16);
            }
            else
            {
               _strengthenLevelImage.setFrame(_loc1_.StrengthenLevel);
            }
            addChild(_strengthenLevelImage);
            if(_boundImage.parent)
            {
               _boundImage.x = _strengthenLevelImage.x + _strengthenLevelImage.displayWidth / 2 - _boundImage.width / 2;
               _boundImage.y = _lines[0].y + 4;
            }
            _maxWidth = Math.max(_strengthenLevelImage.x + _strengthenLevelImage.displayWidth,_maxWidth);
            var _loc2_:* = _maxWidth + 8;
            _tipbackgound.width = _loc2_;
            _width = _loc2_;
            if(_ghostStartsContainer)
            {
               _ghostStartsContainer.x = _strengthenLevelImage.x + (_strengthenLevelImage.displayWidth - _ghostStartsContainer.width >> 1) - 23;
               _autoGhostWidth = _ghostStartsContainer.x + _ghostStartsContainer.width;
            }
         }
      }
      
      private function createMagicStone() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc5_:InventoryItemInfo = _info as InventoryItemInfo;
         if(!_loc5_ || !_loc5_.magicStoneAttr)
         {
            return;
         }
         var _loc4_:InventoryItemInfo = new InventoryItemInfo();
         _loc4_.TemplateID = _loc5_.magicStoneAttr.templateId;
         ItemManager.fill(_loc4_);
         _loc4_.Level = _loc5_.magicStoneAttr.level;
         _loc4_.Attack = _loc5_.magicStoneAttr.attack;
         _loc4_.Defence = _loc5_.magicStoneAttr.defence;
         _loc4_.Agility = _loc5_.magicStoneAttr.agility;
         _loc4_.Luck = _loc5_.magicStoneAttr.luck;
         _loc4_.MagicAttack = _loc5_.magicStoneAttr.magicAttack;
         _loc4_.MagicDefence = _loc5_.magicStoneAttr.magicDefence;
         _mgStoneName.text = _loc4_.Name + "Lv." + _loc4_.Level;
         _mgStoneName.textColor = 2467327;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _mgStoneName;
         switch(int(_loc4_.Quality) - 1)
         {
            case 0:
               _magicStoneIcon = ComponentFactory.Instance.creat("magicStone.smallIcon.white");
               break;
            case 1:
               _magicStoneIcon = ComponentFactory.Instance.creat("magicStone.smallIcon.green");
               break;
            case 2:
               _magicStoneIcon = ComponentFactory.Instance.creat("magicStone.smallIcon.blue");
               break;
            case 3:
               _magicStoneIcon = ComponentFactory.Instance.creat("magicStone.smallIcon.purple");
               break;
            case 4:
               _magicStoneIcon = ComponentFactory.Instance.creat("magicStone.smallIcon.yellow");
               break;
            case 5:
               _magicStoneIcon = ComponentFactory.Instance.creat("magicStone.smallIcon.red");
         }
         if(_loc4_.Attack != 0)
         {
            _loc2_ = new Sprite();
            _loc3_ = _magicStoneIcon.bitmapData.clone();
            _loc1_ = new Bitmap(_loc3_);
            _loc2_.addChild(_loc1_);
            _attackTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.fire") + "+" + String(_loc4_.Attack);
            _attackTxt2.textColor = 2467327;
            _attackTxt2.x = 20;
            _attackTxt2.y = 3;
            _loc2_.addChild(_attackTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _loc2_;
         }
         if(_loc4_.Defence != 0)
         {
            _loc2_ = new Sprite();
            _loc3_ = _magicStoneIcon.bitmapData.clone();
            _loc1_ = new Bitmap(_loc3_);
            _loc2_.addChild(_loc1_);
            _defenseTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.recovery") + "+" + String(_loc4_.Defence);
            _defenseTxt2.textColor = 2467327;
            _defenseTxt2.x = 20;
            _defenseTxt2.y = 3;
            _loc2_.addChild(_defenseTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _loc2_;
         }
         if(_loc4_.Agility != 0)
         {
            _loc2_ = new Sprite();
            _loc3_ = _magicStoneIcon.bitmapData.clone();
            _loc1_ = new Bitmap(_loc3_);
            _loc2_.addChild(_loc1_);
            _agilityTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.agility") + "+" + String(_loc4_.Agility);
            _agilityTxt2.textColor = 2467327;
            _agilityTxt2.x = 20;
            _agilityTxt2.y = 3;
            _loc2_.addChild(_agilityTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _loc2_;
         }
         if(_loc4_.Luck != 0)
         {
            _loc2_ = new Sprite();
            _loc3_ = _magicStoneIcon.bitmapData.clone();
            _loc1_ = new Bitmap(_loc3_);
            _loc2_.addChild(_loc1_);
            _luckTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.lucky") + "+" + String(_loc4_.Luck);
            _luckTxt2.textColor = 2467327;
            _luckTxt2.x = 20;
            _luckTxt2.y = 3;
            _loc2_.addChild(_luckTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _loc2_;
         }
         if(_loc4_.MagicAttack != 0)
         {
            _loc2_ = new Sprite();
            _loc3_ = _magicStoneIcon.bitmapData.clone();
            _loc1_ = new Bitmap(_loc3_);
            _loc2_.addChild(_loc1_);
            _magicAttackTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicAttack") + "+" + String(_loc4_.MagicAttack);
            _magicAttackTxt2.textColor = 2467327;
            _magicAttackTxt2.x = 20;
            _magicAttackTxt2.y = 3;
            _loc2_.addChild(_magicAttackTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _loc2_;
         }
         if(_loc4_.MagicDefence != 0)
         {
            _loc2_ = new Sprite();
            _loc3_ = _magicStoneIcon.bitmapData.clone();
            _loc1_ = new Bitmap(_loc3_);
            _loc2_.addChild(_loc1_);
            _magicDefenceTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicDefence") + "+" + String(_loc4_.MagicDefence);
            _magicDefenceTxt2.textColor = 2467327;
            _magicDefenceTxt2.x = 20;
            _magicDefenceTxt2.y = 3;
            _loc2_.addChild(_magicDefenceTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _loc2_;
         }
      }
      
      private function createEvolutionProperties() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = 0;
         var _loc1_:int = 0;
         var _loc4_:InventoryItemInfo = _info as InventoryItemInfo;
         if(_loc4_ == null)
         {
            _loc4_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc4_,_info);
         }
         if(_loc4_ && _loc4_.CategoryID == 17 && (_loc4_.Property3 == "32" || _loc4_.Property3 == "31"))
         {
            _loc3_ = FineEvolutionManager.Instance.GetEvolutionDataByExp(_loc4_.curExp);
            _loc2_ = 16777215;
            if(_loc3_)
            {
               _enchantLevelTxt.text = LanguageMgr.GetTranslation("evolutionchant.levelTxt",_loc3_.Level);
               if(_loc4_.Property3 == "32")
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.tips.addblood",_loc3_.AddBlood / 10 + "%");
               }
               else
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.tips.reducedamage",_loc3_.ReduceDamage / 10 + "%");
               }
               _loc1_ = _loc3_.Level;
               if(_loc1_ > 0)
               {
                  if(_loc1_ <= 4)
                  {
                     _loc2_ = uint(164607);
                  }
                  if(_loc1_ >= 5 && _loc1_ <= 9)
                  {
                     _loc2_ = uint(10696174);
                  }
                  if(_loc1_ >= 10 && _loc1_ <= 15)
                  {
                     _loc2_ = uint(16744448);
                  }
                  if(_loc1_ >= 16 && _loc1_ <= 20)
                  {
                     _loc2_ = uint(16711833);
                  }
               }
               var _loc5_:* = _loc2_;
               _enchantAttackTxt.textColor = _loc5_;
               _enchantLevelTxt.textColor = _loc5_;
            }
            else
            {
               _enchantLevelTxt.text = LanguageMgr.GetTranslation("evolutionchant.levelTxt","0");
               if(_loc4_.Property3 == "32")
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.tips.addblood","0%");
               }
               else
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.tips.reducedamage","0%");
               }
               _loc5_ = 164607;
               _enchantAttackTxt.textColor = _loc5_;
               _enchantLevelTxt.textColor = _loc5_;
            }
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _enchantLevelTxt;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _enchantAttackTxt;
            seperateLine();
         }
      }
      
      private function createEnchantProperties() : void
      {
         var _loc3_:InventoryItemInfo = _info as InventoryItemInfo;
         if(!_loc3_ || _loc3_.MagicLevel <= 0 || !_loc3_.isCanEnchant())
         {
            _enchantAttackPencentTxt.text = "";
            _enchantDefencePencentTxt.text = "";
            return;
         }
         var _loc1_:EnchantInfo = EnchantManager.instance.getEnchantInfoByLevel(_loc3_.MagicLevel);
         if(!_loc1_)
         {
            return;
         }
         _enchantLevelTxt.text = LanguageMgr.GetTranslation("enchant.levelTxt",int(_loc1_.Lv / 10) + 1,_loc1_.Lv % 10);
         _enchantAttackTxt.text = LanguageMgr.GetTranslation("enchant.addMagicAttackTxt") + _loc1_.MagicAttack;
         _enchantDefenceTxt.text = LanguageMgr.GetTranslation("enchant.addMagicDenfenceTxt") + _loc1_.MagicDefence;
         var _loc4_:* = int(_loc3_.Property1) < 5?11842740:13971455;
         _enchantDefenceTxt.textColor = _loc4_;
         _loc4_ = _loc4_;
         _enchantAttackTxt.textColor = _loc4_;
         _enchantLevelTxt.textColor = _loc4_;
         var _loc2_:int = _loc3_.Property1;
         switch(int(_loc2_))
         {
            case 0:
            case 1:
            case 2:
               _enchantAttackPencentTxt.text = "0%";
               _enchantDefencePencentTxt.text = "0%";
               _loc4_ = 16777215;
               _enchantDefencePencentTxt.textColor = _loc4_;
               _enchantAttackPencentTxt.textColor = _loc4_;
               break;
            case 3:
               _enchantAttackPencentTxt.text = "60%";
               _enchantDefencePencentTxt.text = "60%";
               _loc4_ = 65328;
               _enchantDefencePencentTxt.textColor = _loc4_;
               _enchantAttackPencentTxt.textColor = _loc4_;
               break;
            case 4:
               _enchantAttackPencentTxt.text = "80%";
               _enchantDefencePencentTxt.text = "80%";
               _loc4_ = 762111;
               _enchantDefencePencentTxt.textColor = _loc4_;
               _enchantAttackPencentTxt.textColor = _loc4_;
         }
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantLevelTxt;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantAttackTxt;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantDefenceTxt;
      }
      
      protected function seperateLine() : void
      {
         var _loc1_:* = null;
         _lineIdx = Number(_lineIdx) + 1;
         if(_lines.length < _lineIdx)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
            _lines.push(_loc1_);
         }
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _lines[_lineIdx - 1];
      }
      
      private function getGhostPropertyData() : GhostPropertyData
      {
         var _loc4_:GhostPropertyData = null;
         var _loc2_:InventoryItemInfo = _info as InventoryItemInfo;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         var _loc5_:* = _loc3_.ID != PlayerManager.Instance.Self.ID;
         var _loc1_:Boolean = _loc2_.BagType == 0 && _loc2_.Place <= 30;
         if(_loc5_)
         {
            _loc4_ = !!_loc1_?EquipGhostManager.getInstance().getPorpertyData(_loc2_,_loc3_):null;
         }
         else
         {
            _loc4_ = _loc2_.fromBag && (_loc1_ || EquipGhostManager.getInstance().isEquipGhosting())?EquipGhostManager.getInstance().getPorpertyData(_loc2_,_loc3_):null;
         }
         return _loc4_;
      }
   }
}
