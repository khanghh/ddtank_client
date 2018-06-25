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
      
      protected var _isArmed:Boolean;
      
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
         var i:int = 0;
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
         for(i = 0; i < 6; )
         {
            _holes.push(ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt"));
            i++;
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
      
      override public function set tipData(data:Object) : void
      {
         var __info:* = null;
         if(data)
         {
            if(data is GoodTipInfo)
            {
               _tipData = data as GoodTipInfo;
               if(EquipType.isBead(_tipData.itemInfo.Property1) || EquipType.isMagicStone(_tipData.itemInfo.CategoryID))
               {
                  _exp = _tipData.exp;
                  _UpExp = _tipData.upExp;
               }
               else if(EquipType.canBringUp(_tipData.itemInfo))
               {
                  __info = _tipData.itemInfo as ItemTemplateInfo;
                  if(__info is InventoryItemInfo)
                  {
                     if((__info as InventoryItemInfo).curExp == 0)
                     {
                        _exp = int(ItemManager.Instance.getTemplateById(__info.TemplateID).Property2);
                     }
                     else
                     {
                        _exp = (__info as InventoryItemInfo).curExp;
                     }
                  }
                  else
                  {
                     _exp = int(__info.Property2);
                  }
                  if(__info.FusionType == 0)
                  {
                     _UpExp = 0;
                  }
                  else
                  {
                     _UpExp = int(ItemManager.Instance.getTemplateById(__info.FusionType).Property2);
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
            else if(data is ShopItemInfo)
            {
               _tipData = data as ShopItemInfo;
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
      
      public function showTip(info:ItemTemplateInfo, typeIsSecond:Boolean = false) : void
      {
         _displayIdx = 0;
         _displayList = new Vector.<DisplayObject>();
         _lineIdx = 0;
         _isReAdd = false;
         _maxWidth = 0;
         _autoGhostWidth = 0;
         _info = info;
         _ghostPropertyData = getGhostPropertyData();
         updateView();
      }
      
      public function showSuitTip(info:ItemTemplateInfo) : void
      {
         var point:* = null;
         var _info:ItemTemplateInfo = _tipData.itemInfo;
         if(_info is ItemTemplateInfo)
         {
            if(_info.SuitId != 0)
            {
               _laterEquipmentGoodView.visible = true;
               point = localToGlobal(new Point(_tipbackgound.x,_tipbackgound.y));
               if(point.x + _tipbackgound.width + _laterEquipmentGoodView.width < StageReferance.stageWidth)
               {
                  _laterEquipmentGoodView.x = _width + 5;
               }
               else
               {
                  _laterEquipmentGoodView.x = -_laterEquipmentGoodView.width - 5;
               }
               laterEquipment(_info);
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
         var point:* = null;
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
               point = localToGlobal(new Point(_tipbackgound.x,_tipbackgound.y));
               if(point.x + _tipbackgound.width + syahTip.displayWidth < StageReferance.stageWidth)
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
      
      protected function updateView() : void
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
         var tempInfo:InventoryItemInfo = _info as InventoryItemInfo;
         if(tempInfo == null || !MarkMgr.inst.checkTip(tempInfo.CategoryID,tempInfo.Place))
         {
            return;
         }
         var player:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         if(player.getMarkChipCntByPlace(tempInfo.Place) == 0)
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
         _markContainer = new MarkPropsTip(tempInfo.Place);
         _markContainer.data = player;
         _markContainer.x = this.width;
         _height = _markContainer.height > _height?_markContainer.height:Number(_height);
         _width = _width + _markContainer.width;
         addChild(_markContainer);
      }
      
      private function createRingAddition() : void
      {
         var data:* = null;
         if(_info is InventoryItemInfo && EquipType.isWeddingRing(_info))
         {
            data = BagAndInfoManager.Instance.getRingData(InventoryItemInfo(_info).RingExp);
            if(PlayerManager.Instance.Self.ID == InventoryItemInfo(_info).UserID)
            {
               data = BagAndInfoManager.Instance.getRingData(PlayerManager.Instance.Self.RingExp);
            }
            _addition = new RingSystemTip();
            _addition.setAdditiontext([_info.Attack * data.Attack,_info.Defence * data.Defence,_info.Agility * data.Agility,_info.Luck * data.Luck]);
            _addition.x = _attackTxt.x + 130;
            _addition.y = _attackTxt.y + 3;
            addChild(_addition);
         }
      }
      
      private function laterEquipment(Info:ItemTemplateInfo) : void
      {
         if(!_laterEquipmentGoodView)
         {
            _laterEquipmentGoodView = new LaterEquipmentGoodView();
         }
         _laterEquipmentGoodView.tipData = Info;
      }
      
      protected function clear() : void
      {
         var display:* = null;
         while(numChildren > 0)
         {
            display = getChildAt(0) as DisplayObject;
            if(display.parent)
            {
               display.parent.removeChild(display);
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
         var item:* = null;
         var i:int = 0;
         var len:int = _displayList.length;
         var pos:Point = new Point(4,4);
         var offset:int = 6;
         var tempMaxWidth:int = _maxWidth;
         for(i = 0; i < len; )
         {
            if(_displayList[i] as DisplayObject)
            {
               item = _displayList[i] as DisplayObject;
               if(_lines.indexOf(item as Image) < 0 && item != _descriptionTxt && item != _ghostSkillDesc)
               {
                  tempMaxWidth = Math.max(item.width,tempMaxWidth);
               }
               PositionUtils.setPos(item,pos);
               addChild(item);
               pos.y = item.y + item.height + offset;
            }
            i++;
         }
         _maxWidth = Math.max(_minWidth,tempMaxWidth);
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
            for(i = 0; i < _lines.length; )
            {
               _lines[i].width = _maxWidth;
               if(i + 1 < _lines.length && _lines[i + 1].parent != null && Math.abs(_lines[i + 1].y - _lines[i].y) <= 10)
               {
                  _displayList.splice(_displayList.indexOf(_lines[i + 1]),1);
                  _lines[i + 1].parent.removeChild(_lines[i + 1]);
                  _isReAdd = true;
               }
               i++;
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
         if(len > 0)
         {
            var _loc7_:* = _maxWidth + 8;
            _tipbackgound.width = _loc7_;
            _width = _loc7_;
            _loc7_ = item.y + item.height + 8;
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
         var tmpItemInfo:* = null;
         var valueArray:* = null;
         var i:int = 0;
         var tipItem:* = null;
         if(_info is InventoryItemInfo)
         {
            tmpItemInfo = _info as InventoryItemInfo;
            if(tmpItemInfo.isHasLatentEnergy)
            {
               valueArray = tmpItemInfo.latentEnergyCurList;
               for(i = 0; i < 4; )
               {
                  tipItem = new LatentEnergyTipItem();
                  tipItem.setView(i,valueArray[i]);
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = tipItem;
                  i++;
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
         var temInfo:* = null;
         var equipInfo:* = null;
         var petSkillSpri:* = null;
         var petTxt:* = null;
         var skill1Txt:* = null;
         var skill2Txt:* = null;
         if(_info is InventoryItemInfo)
         {
            temInfo = _info as InventoryItemInfo;
            equipInfo = PetsBagManager.instance().getAwakenEquipInfo(temInfo.ItemID.toString());
            if(equipInfo == null)
            {
               return;
            }
            petSkillSpri = new Sprite();
            petTxt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.petsSkillTxt");
            petTxt.text = equipInfo.belongPetName + LanguageMgr.GetTranslation("petsBag.petsAwaken.awakenEquipTips.petsTxt");
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = petTxt;
            if(equipInfo.skillId1 > 0)
            {
               skill1Txt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.petsSkillNameTxt");
               skill1Txt.text = equipInfo.getSkill1Info().Name;
               petSkillSpri.addChild(skill1Txt);
            }
            if(equipInfo.skillId2 > 0)
            {
               skill2Txt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.petsSkillNameTxt");
               skill2Txt.text = equipInfo.getSkill2Info().Name;
               skill2Txt.y = 25;
               petSkillSpri.addChild(skill2Txt);
            }
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = petSkillSpri;
         }
      }
      
      private function creatGemstone() : void
      {
         var t:* = null;
         var addAttackStr:* = null;
         var rdcDamageStr:* = null;
         var i:int = 0;
         var stoenTxt1:* = null;
         var tipItem:* = null;
         var level:int = 0;
         var stoneName:* = null;
         var stoneAct1:int = 0;
         var obj:* = null;
         if(_info is InventoryItemInfo)
         {
            t = _info as InventoryItemInfo;
            if(t.gemstoneList)
            {
               if(t.gemstoneList.length == 0)
               {
                  return;
               }
               addAttackStr = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.GoldenAddAttack");
               rdcDamageStr = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.GoldenReduceDamage");
               for(i = 0; i < 3; )
               {
                  if(t.gemstoneList[i].level > 0)
                  {
                     stoenTxt1 = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameTxtString");
                     tipItem = new GemstonTipItem();
                     _displayIdx = Number(_displayIdx) + 1;
                     _displayList[Number(_displayIdx)] = tipItem;
                     level = t.gemstoneList[i].level;
                     if(t.gemstoneList[i].fightSpiritId == 100001)
                     {
                        if(t.gemstoneList[i].level == 6)
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneAtc",GemstoneManager.Instance.redInfoList[level].attack + addAttackStr);
                        }
                        else
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.redGemstoneAtc",level,GemstoneManager.Instance.redInfoList[level].attack);
                        }
                        stoneAct1 = GemstoneManager.Instance.redInfoList[level].attack;
                     }
                     else if(t.gemstoneList[i].fightSpiritId == 100002)
                     {
                        if(t.gemstoneList[i].level == 6)
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneDef",GemstoneManager.Instance.bluInfoList[level].defence + rdcDamageStr);
                        }
                        else
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.bluGemstoneDef",level,GemstoneManager.Instance.bluInfoList[level].defence);
                        }
                        stoneAct1 = GemstoneManager.Instance.bluInfoList[level].defence;
                     }
                     else if(t.gemstoneList[i].fightSpiritId == 100003)
                     {
                        if(t.gemstoneList[i].level == 6)
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneAgi",GemstoneManager.Instance.greInfoList[level].agility + addAttackStr);
                        }
                        else
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.gesGemstoneAgi",level,GemstoneManager.Instance.greInfoList[level].agility);
                        }
                        stoneAct1 = GemstoneManager.Instance.greInfoList[level].agility;
                     }
                     else if(t.gemstoneList[i].fightSpiritId == 100004)
                     {
                        if(t.gemstoneList[i].level == 6)
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneLuk",GemstoneManager.Instance.yelInfoList[level].luck + rdcDamageStr);
                        }
                        else
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.yelGemstoneLuk",level,GemstoneManager.Instance.yelInfoList[level].luck);
                        }
                        stoneAct1 = GemstoneManager.Instance.yelInfoList[level].luck;
                     }
                     else if(t.gemstoneList[i].fightSpiritId == 100005)
                     {
                        if(t.gemstoneList[i].level == 6)
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstoneHp",GemstoneManager.Instance.purpleInfoList[level].blood + rdcDamageStr);
                        }
                        else
                        {
                           stoneName = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.purpleGemstoneLuk",level,GemstoneManager.Instance.purpleInfoList[level].blood);
                        }
                        stoneAct1 = GemstoneManager.Instance.purpleInfoList[level].blood;
                     }
                     obj = {};
                     obj.id = t.gemstoneList[i].fightSpiritId;
                     obj.str = stoneName;
                     tipItem.setInfo(obj);
                  }
                  i++;
               }
            }
         }
      }
      
      protected function createItemName() : void
      {
         var format:* = null;
         var info:* = null;
         var exp:int = 0;
         var minExp:int = 0;
         var vo:* = null;
         var level:int = 0;
         var order:* = null;
         var place:int = 0;
         var type:int = 0;
         if(EquipType.isBead(int(_info.Property1)) || EquipType.isMagicStone(_info.CategoryID))
         {
            _nameTxt.text = _tipData.beadName;
         }
         else
         {
            _nameTxt.text = String(_info.Name);
         }
         var tempInfo:InventoryItemInfo = _info as InventoryItemInfo;
         if(tempInfo && tempInfo.CategoryID == 70 && tempInfo.CategoryID != 74)
         {
            _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("ddtKingGrade.grade",tempInfo.StrengthenLevel);
         }
         else if(tempInfo && tempInfo.StrengthenLevel > 0 && !EquipType.isMagicStone(tempInfo.CategoryID) && tempInfo.CategoryID != 19 && tempInfo.CategoryID != 74)
         {
            if(tempInfo.isGold)
            {
               if(tempInfo.StrengthenLevel > PathManager.solveStrengthMax())
               {
                  _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("store.view.exalt.goodTips",tempInfo.StrengthenLevel - 12);
               }
               else
               {
                  _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("wishBead.StrengthenLevel");
               }
            }
            else if(tempInfo.StrengthenLevel <= PathManager.solveStrengthMax())
            {
               _nameTxt.text = _nameTxt.text + ("(+" + (_info as InventoryItemInfo).StrengthenLevel + ")");
            }
            else if(tempInfo.StrengthenLevel > PathManager.solveStrengthMax())
            {
               _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("store.view.exalt.goodTips",tempInfo.StrengthenLevel - 12);
            }
         }
         var len:int = _nameTxt.text.indexOf("+");
         if(len > 0)
         {
            format = ComponentFactory.Instance.model.getSet("core.goodTip.ItemNameNumTxtFormat");
            _nameTxt.setTextFormat(format,len,len + 1);
         }
         if(PlayerInfoViewControl.currentPlayer)
         {
            if(tempInfo && tempInfo.Place == 12 && tempInfo.UserID == PlayerInfoViewControl.currentPlayer.ID && PlayerInfoViewControl.currentPlayer.necklaceLevel > 0 && tempInfo.CategoryID == 14)
            {
               _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.goodTip",PlayerInfoViewControl.currentPlayer.necklaceLevel);
            }
         }
         _nameTxt.textColor = QualityType.QUALITY_COLOR[getInfoQuality()];
         if(_tipData is GoodTipInfo && tempInfo && tempInfo.UserID)
         {
            info = _tipData as GoodTipInfo;
            if(info.suitIcon)
            {
               if(tempInfo.CategoryID == 1 || tempInfo.CategoryID == 2 || tempInfo.CategoryID == 3 || tempInfo.CategoryID == 4 || tempInfo.CategoryID == 5 || tempInfo.CategoryID == 6 || tempInfo.CategoryID == 8 || tempInfo.CategoryID == 9 || tempInfo.CategoryID == 13 || tempInfo.CategoryID == 14 || tempInfo.CategoryID == 15)
               {
                  exp = PlayerManager.Instance.findPlayer(tempInfo.UserID).fineSuitExp;
                  minExp = FineSuitManager.Instance.getSuitVoByLevel(1).exp;
                  vo = FineSuitManager.Instance.getSuitVoByExp(exp);
                  level = vo.level;
                  if(level > 14)
                  {
                     level = int(level % 14) == 0?14:int(level % 14);
                  }
                  order = [0,1,2,3,4,5,11,13,12,16,9,10,7,8];
                  place = order.indexOf(tempInfo.Place) + 1;
                  type = vo.type;
                  if(place > level)
                  {
                     type--;
                  }
                  if(exp < minExp || type <= 0)
                  {
                     _displayIdx = Number(_displayIdx) + 1;
                     _displayList[Number(_displayIdx)] = _nameTxt;
                     return;
                  }
                  _suitIcon.setFrame(type);
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
      
      protected function createQualityItem() : void
      {
         var fft:FilterFrameText = _qualityItem.foreItems[0] as FilterFrameText;
         fft.text = QualityType.QUALITY_STRING[getInfoQuality()];
         fft.textColor = QualityType.QUALITY_COLOR[getInfoQuality()];
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
      
      protected function createCategoryItem() : void
      {
         var fft:FilterFrameText = _typeItem.foreItems[0] as FilterFrameText;
         var arr:Array = EquipType.PARTNAME;
         if(_info.CategoryID == 31)
         {
            fft.text = LanguageMgr.GetTranslation("tank.data.EquipType.tempHelp");
         }
         else if(_info.CategoryID == 222222222)
         {
            fft.text = LanguageMgr.GetTranslation("tank.data.EquipType.normal");
         }
         else if(_info.CategoryID == 80)
         {
            fft.text = LanguageMgr.GetTranslation("tank.data.EquipType.fuzhudaoju");
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
                     fft.text = LanguageMgr.GetTranslation("tank.data.EquipType.attribute");
                  }
               }
               else
               {
                  fft.text = LanguageMgr.GetTranslation("tank.data.EquipType.defent");
               }
            }
            else
            {
               fft.text = LanguageMgr.GetTranslation("tank.data.EquipType.atacckt");
            }
         }
         else
         {
            fft.text = EquipType.PARTNAME[_info.CategoryID] + "";
         }
         if(EquipType.isBead(int(_info.Property1)))
         {
            fft.textColor = 65406;
         }
         if(_info.TemplateID == 20150 || _info.TemplateID == 201266)
         {
            fft.text = EquipType.PARTNAME[23];
         }
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _typeItem;
      }
      
      private function careteEXP() : void
      {
         var fft:FilterFrameText = _expItem.foreItems[0] as FilterFrameText;
         if(EquipType.isBead(int(_info.Property1)) || EquipType.isMagicStone(_info.CategoryID) || EquipType.canBringUp(_info))
         {
            fft.text = _exp + "/" + _UpExp;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _expItem;
         }
      }
      
      private function createMainProperty() : void
      {
         var strenGold:* = NaN;
         var armValue:* = NaN;
         var space:* = null;
         var tf:* = null;
         var beginIndex:int = 0;
         var endIndex:int = 0;
         var attachedMainPropertyStr:String = "";
         var strengthenLevel:int = 0;
         var fft:FilterFrameText = _mainPropertyItem.foreItems[0] as FilterFrameText;
         var type:ScaleFrameImage = _mainPropertyItem.backItem as ScaleFrameImage;
         var ivenInfo:InventoryItemInfo = _info as InventoryItemInfo;
         GhostStarContainer(_mainPropertyItem.foreItems[1]).visible = false;
         GhostStarContainer(_armAngleItem.foreItems[1]).visible = false;
         _autoGhostWidth = 0;
         var attachedMainProperty:uint = 0;
         var player:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         if(EquipType.isArm(_info))
         {
            strenGold = 0;
            if(ivenInfo && ivenInfo.StrengthenLevel > 0)
            {
               strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
               strenGold = Number(StaticFormula.getHertAddition(int(ivenInfo.Property7),strengthenLevel));
            }
            type.setFrame(1);
            attachedMainProperty = strenGold + (!!_ghostPropertyData?_ghostPropertyData.mainProperty:0);
            attachedMainPropertyStr = attachedMainProperty > 0?"(+" + attachedMainProperty + ")":"";
            fft.text = " " + _info.Property7.toString() + attachedMainPropertyStr;
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
               _ghostStartsContainer.level = player.getGhostDataByCategoryID(_info.CategoryID).level;
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
            armValue = 0;
            if(ivenInfo && ivenInfo.StrengthenLevel > 0)
            {
               strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
               armValue = Number(StaticFormula.getDefenseAddition(int(ivenInfo.Property7),strengthenLevel));
            }
            type.setFrame(2);
            attachedMainProperty = armValue + (_ghostPropertyData != null?_ghostPropertyData.mainProperty:0);
            attachedMainPropertyStr = attachedMainProperty > 0?"(+" + attachedMainProperty + ")":"";
            fft.text = " " + _info.Property7.toString() + attachedMainPropertyStr;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
            if(ivenInfo && ivenInfo.isGold)
            {
               FilterFrameText(_otherHp.foreItems[0]).text = ivenInfo.Boold.toString();
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _otherHp;
            }
            if(_ghostPropertyData != null)
            {
               _ghostStartsContainer = _mainPropertyItem.foreItems[1] as GhostStarContainer;
               _ghostStartsContainer.maxLv = EquipGhostManager.getInstance().model.topLvDic[_info.CategoryID == 27?7:_info.CategoryID];
               _ghostStartsContainer.x = _mainPropertyItem.foreItems[0].width + _mainPropertyItem.foreItems[0].x;
               _ghostStartsContainer.y = _mainPropertyItem.foreItems[0].y + 8;
               _ghostStartsContainer.level = player.getGhostDataByCategoryID(_info.CategoryID).level;
               _ghostStartsContainer.visible = true;
               _autoGhostWidth = _ghostStartsContainer.x + _ghostStartsContainer.width;
            }
         }
         else if(StaticFormula.isDeputyWeapon(_info) || _info.CategoryID == 31)
         {
            space = " ";
            if(_info.Property3 == "32")
            {
               if(ivenInfo && ivenInfo.StrengthenLevel > 0)
               {
                  strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
                  attachedMainPropertyStr = "(+" + StaticFormula.getRecoverHPAddition(int(ivenInfo.Property7),strengthenLevel) + ")";
               }
               type.setFrame(3);
               space = "   ";
               fft.text = " " + _info.Property7.toString() + attachedMainPropertyStr;
            }
            else if(_info.Property3 == "132")
            {
               if(ivenInfo && ivenInfo.StrengthenLevel > 0)
               {
                  strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
                  attachedMainPropertyStr = "(+" + int(StaticFormula.getRecoverHPAddition(int(ivenInfo.Property7),strengthenLevel) / 2) + ")";
               }
               type.setFrame(5);
               fft.text = " " + int(_info.Property7) / 2 + attachedMainPropertyStr;
            }
            else
            {
               if(ivenInfo && ivenInfo.StrengthenLevel > 0)
               {
                  strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
                  attachedMainPropertyStr = "(+" + StaticFormula.getDefenseAddition(int(ivenInfo.Property7),strengthenLevel) + ")";
               }
               type.setFrame(4);
               fft.text = " " + _info.Property7.toString() + attachedMainPropertyStr;
               space = "            ";
            }
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
         }
         if(fft)
         {
            tf = ComponentFactory.Instance.model.getSet("ddt.store.view.exalt.LaterEquipmentViewTextTF");
            beginIndex = fft.text.indexOf("(");
            endIndex = fft.text.indexOf(")") + 1;
            if(beginIndex != -1 && endIndex != 0)
            {
               fft.setTextFormat(tf,beginIndex,endIndex);
            }
         }
      }
      
      private function createArmShellProperty() : void
      {
         var itemInfo:* = null;
         var armInfo:* = null;
         if(EquipType.isArmShell(_info))
         {
            _armShellProtertyTxts[0].text = LanguageMgr.GetTranslation("ddt.armShellClip.damageTips",LanguageMgr.GetTranslation("ddt.armShellClip.normalDamageTips"),Number(ServerConfigManager.instance.weaponShellNormalAdd / 10));
            _armShellProtertyTxts[0].textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _armShellProtertyTxts[0];
            if(_info is InventoryItemInfo)
            {
               itemInfo = InventoryItemInfo(_info);
               if(itemInfo.AttackCompose > 0 && itemInfo.DefendCompose > 0)
               {
                  armInfo = ItemManager.Instance.getTemplateById(itemInfo.AttackCompose);
                  if(armInfo)
                  {
                     _armShellProtertyTxts[1].text = LanguageMgr.GetTranslation("ddt.armShellClip.damageTips",armInfo.Name,Number(itemInfo.DefendCompose / 10));
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
         var tempInfo:* = null;
         var necklaceStrengthPlus:int = 0;
         if(_info.CategoryID == 14)
         {
            _necklaceItem.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.life") + ":" + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.advance") + _info.Property1 + "%";
            tempInfo = _info as InventoryItemInfo;
            if(tempInfo && tempInfo.Place == 12 && PlayerInfoViewControl.currentPlayer && tempInfo.UserID == PlayerInfoViewControl.currentPlayer.ID && PlayerInfoViewControl.currentPlayer.necklaceLevel > 0)
            {
               necklaceStrengthPlus = StoreEquipExperience.getNecklaceStrengthPlus(PlayerInfoViewControl.currentPlayer.necklaceLevel);
               _necklaceItem.text = _necklaceItem.text + LanguageMgr.GetTranslation("bagAndInfo.bag.NecklacePtetrochemicalView.goodTipII",necklaceStrengthPlus);
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
         var t:* = null;
         var mgStoneTxt:* = null;
         var hpText:* = null;
         var amuletHp:int = 0;
         var tat:String = "";
         var tde:String = "";
         var tag:String = "";
         var tlu:String = "";
         var gat:String = "";
         var gde:String = "";
         var gag:String = "";
         var glu:String = "";
         if(_info is InventoryItemInfo && !EquipType.isMagicStone(_info.CategoryID))
         {
            t = _info as InventoryItemInfo;
            if(t.AttackCompose > 0)
            {
               tat = "(+" + String(t.AttackCompose) + ")";
            }
            if(t.DefendCompose > 0)
            {
               tde = "(+" + String(t.DefendCompose) + ")";
            }
            if(t.AgilityCompose > 0)
            {
               tag = "(+" + String(t.AgilityCompose) + ")";
            }
            if(t.LuckCompose > 0)
            {
               tlu = "(+" + String(t.LuckCompose) + ")";
            }
         }
         if(_ghostPropertyData != null)
         {
            if(_ghostPropertyData.attack > 0)
            {
               gat = LanguageMgr.GetTranslation("equipGhost.tip",_ghostPropertyData.attack);
            }
            if(_ghostPropertyData.defend > 0)
            {
               gde = LanguageMgr.GetTranslation("equipGhost.tip",_ghostPropertyData.defend);
            }
            if(_ghostPropertyData.lucky > 0)
            {
               glu = LanguageMgr.GetTranslation("equipGhost.tip",_ghostPropertyData.lucky);
            }
            if(_ghostPropertyData.agility > 0)
            {
               gag = LanguageMgr.GetTranslation("equipGhost.tip",_ghostPropertyData.agility);
            }
         }
         if(_info.Attack != 0)
         {
            _attackTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.fire") + ":" + String(_info.Attack) + tat) + gat;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _attackTxt;
         }
         if(_info.Defence != 0)
         {
            _defenseTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.recovery") + ":" + String(_info.Defence) + tde) + gde;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _defenseTxt;
         }
         if(_info.Agility != 0)
         {
            _agilityTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.agility") + ":" + String(_info.Agility) + tag) + gag;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _agilityTxt;
         }
         if(_info.Luck != 0)
         {
            _luckTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.lucky") + ":" + String(_info.Luck) + tlu) + glu;
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
         var item:InventoryItemInfo = _info as InventoryItemInfo;
         if(!item && EquipType.isMagicStone(_info.CategoryID))
         {
            mgStoneTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
            switch(int(int(_info.Property3)) - 2)
            {
               case 0:
                  mgStoneTxt.text = LanguageMgr.GetTranslation("magicStone.canGetTwoAbove");
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = mgStoneTxt;
                  break;
               case 1:
                  mgStoneTxt.text = LanguageMgr.GetTranslation("magicStone.canGetThreeAbove");
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = mgStoneTxt;
                  break;
               case 2:
                  mgStoneTxt.text = LanguageMgr.GetTranslation("magicStone.canGetFourAbove");
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = mgStoneTxt;
            }
            mgStoneTxt.textColor = 16777215;
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
            hpText = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
            if(item)
            {
               amuletHp = EquipAmuletManager.Instance.getAmuletHpByGrade(item.StrengthenLevel);
               hpText.text = LanguageMgr.GetTranslation("MaxHp") + ":" + amuletHp;
               hpText.textColor = 16750899;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = hpText;
               if(item.Hole1 > 0)
               {
                  _attackTxt.text = HorseAmuletManager.instance.getByExtendType(item.Hole1) + ":" + item.equipAmuletProperty1;
                  _attackTxt.textColor = 16750899;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _attackTxt;
                  _defenseTxt.text = HorseAmuletManager.instance.getByExtendType(item.Hole2) + ":" + item.equipAmuletProperty2;
                  _defenseTxt.textColor = 16750899;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _defenseTxt;
                  _agilityTxt.text = HorseAmuletManager.instance.getByExtendType(item.Hole3) + ":" + item.equipAmuletProperty3;
                  _agilityTxt.textColor = 16750899;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _agilityTxt;
                  _luckTxt.text = HorseAmuletManager.instance.getByExtendType(item.Hole4) + ":" + item.equipAmuletProperty4;
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
               amuletHp = EquipAmuletManager.Instance.getAmuletHpByGrade(1);
               hpText.text = LanguageMgr.GetTranslation("MaxHp") + ":" + amuletHp;
               hpText.textColor = 16750899;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = hpText;
               _attackTxt.text = LanguageMgr.GetTranslation("tank.equipAmulet.notActivateAmulet");
               _attackTxt.textColor = 16750899;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _attackTxt;
            }
         }
      }
      
      private function createGhostSkillitem() : void
      {
         var ghostData:* = null;
         if(!_ghostPropertyData)
         {
            return;
         }
         var player:PlayerInfo = !!PlayerInfoViewControl.currentPlayer?PlayerInfoViewControl.currentPlayer:PlayerManager.Instance.Self;
         var equipGhostData:EquipGhostData = player.getGhostDataByCategoryID(_info.CategoryID);
         if(equipGhostData)
         {
            ghostData = EquipGhostManager.getInstance().model.getGhostData(_info.CategoryID == 27?7:_info.CategoryID,equipGhostData.level);
            if(ghostData)
            {
               _ghostSkillDesc.text = StringHelper.format(PetSkillManager.getSkillByID(ghostData.skillId).Description);
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _ghostSkillDesc;
            }
         }
      }
      
      private function createHoleItem() : void
      {
         var holeList:* = null;
         var strHoleList:* = null;
         var inventoryInfo:* = null;
         var i:int = 0;
         var str:* = null;
         var tmpArr:* = null;
         var simpleItem:* = null;
         var requireStrengthenLevel:int = 0;
         if(!StringHelper.isNullOrEmpty(_info.Hole))
         {
            holeList = [];
            strHoleList = _info.Hole.split("|");
            inventoryInfo = _info as InventoryItemInfo;
            if(strHoleList.length > 0 && String(strHoleList[0]) != "" && inventoryInfo != null)
            {
               i = 0;
               while(i < strHoleList.length)
               {
                  str = String(strHoleList[i]);
                  tmpArr = str.split(",");
                  if(i < 4)
                  {
                     if(int(tmpArr[0]) > 0 && int(tmpArr[0]) - inventoryInfo.StrengthenLevel <= 3 || getHole(inventoryInfo,i + 1) >= 0)
                     {
                        requireStrengthenLevel = tmpArr[0];
                        simpleItem = createSingleHole(inventoryInfo,i,requireStrengthenLevel,tmpArr[1]);
                        _displayIdx = Number(_displayIdx) + 1;
                        _displayList[Number(_displayIdx)] = simpleItem;
                     }
                  }
                  else if(inventoryInfo["Hole" + (i + 1) + "Level"] >= 1 || inventoryInfo["Hole" + (i + 1)] > 0)
                  {
                     simpleItem = createSingleHole(inventoryInfo,i,2147483647,tmpArr[1]);
                     _displayIdx = Number(_displayIdx) + 1;
                     _displayList[Number(_displayIdx)] = simpleItem;
                  }
                  i++;
               }
            }
         }
      }
      
      private function createSingleHole(inventoryInfo:InventoryItemInfo, index:int, strengthLevel:int, holeType:int) : FilterFrameText
      {
         var goodsTemplateInfos:* = null;
         var holeLv:int = 0;
         var item:FilterFrameText = _holes[index];
         var holeState:int = getHole(inventoryInfo,index + 1);
         if(inventoryInfo.StrengthenLevel >= strengthLevel)
         {
            if(holeState <= 0)
            {
               item.text = getHoleType(holeType) + ":" + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holeenable");
               item.textColor = 16777215;
            }
            else
            {
               goodsTemplateInfos = ItemManager.Instance.getTemplateById(holeState);
               if(goodsTemplateInfos)
               {
                  item.text = goodsTemplateInfos.Data;
                  item.textColor = 16776960;
               }
            }
         }
         else if(index >= 4)
         {
            holeLv = inventoryInfo["Hole" + (index + 1) + "Level"];
            if(holeState > 0)
            {
               goodsTemplateInfos = ItemManager.Instance.getTemplateById(holeState);
               item.text = goodsTemplateInfos.Data + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holeLv",inventoryInfo["Hole" + (index + 1) + "Level"]);
               if(Math.floor(goodsTemplateInfos.Level + 1 >> 1) <= holeLv)
               {
                  item.textColor = 16776960;
               }
               else
               {
                  item.textColor = 6710886;
               }
            }
            else
            {
               item.text = getHoleType(holeType) + StringHelper.format(LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holeLv",inventoryInfo["Hole" + (index + 1) + "Level"]));
               item.textColor = 16777215;
            }
         }
         else if(holeState <= 0)
         {
            item.text = getHoleType(holeType) + StringHelper.format(LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holerequire"),strengthLevel.toString());
            item.textColor = 6710886;
         }
         else
         {
            goodsTemplateInfos = ItemManager.Instance.getTemplateById(holeState);
            if(goodsTemplateInfos)
            {
               item.text = goodsTemplateInfos.Data + StringHelper.format(LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.holerequire"),strengthLevel.toString());
               item.textColor = 6710886;
            }
         }
         return item;
      }
      
      public function getHole(inventoryInfo:InventoryItemInfo, index:int) : int
      {
         return int(inventoryInfo["Hole" + index.toString()]);
      }
      
      private function getHoleType(type:int) : String
      {
         switch(int(type) - 1)
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
         var tc:int = 0;
         if(_info.NeedLevel > 1 && _info.TemplateID != 20150 && _info.TemplateID != 201266)
         {
            if(PlayerManager.Instance.Self.Grade >= _info.NeedLevel)
            {
               tc = 13421772;
            }
            else
            {
               tc = 16711680;
            }
            _needLevelTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.need") + ":" + String(_info.NeedLevel);
            _needLevelTxt.textColor = tc;
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
         var tipSmith:String = "";
         if(_info.CanStrengthen && _info.CanCompose && _info.CategoryID != 27)
         {
            tipSmith = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.may");
            if(EquipType.isRongLing(_info))
            {
               tipSmith = tipSmith + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.melting");
            }
            _upgradeType.text = tipSmith;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(_info.CanCompose && !EquipType.isMagicStone(_info.CategoryID) && _info.CategoryID != 27)
         {
            tipSmith = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.compose");
            if((_info.CategoryID == 8 || _info.CategoryID == 9) && !EquipType.isWeddingRing(_info))
            {
               tipSmith = tipSmith + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.bringUp");
            }
            else if(EquipType.isRongLing(_info))
            {
               tipSmith = tipSmith + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.melting");
            }
            _upgradeType.text = tipSmith;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(_info.CanStrengthen && _info.CategoryID != 27)
         {
            tipSmith = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.strong");
            if(EquipType.isRongLing(_info))
            {
               tipSmith = tipSmith + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.melting");
            }
            _upgradeType.text = tipSmith;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(EquipType.isRongLing(_info))
         {
            tipSmith = tipSmith + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.canmelting");
            _upgradeType.text = tipSmith;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(_info.CategoryID == 31 || _info.CategoryID == 31)
         {
            tipSmith = tipSmith + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.strong");
            _upgradeType.text = "   ";
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
      }
      
      private function createArmShellName() : void
      {
         var itemInfo:* = null;
         var armShellName:* = null;
         var armShellInfo:* = null;
         if(EquipType.isArm(_info) && _info is InventoryItemInfo && PlayerInfoViewControl.currentPlayer)
         {
            itemInfo = InventoryItemInfo(_info);
            if(itemInfo.Place == 6)
            {
               armShellName = LanguageMgr.GetTranslation("tank.room.difficulty.none");
               armShellInfo = PlayerInfoViewControl.currentPlayer.Bag.getItemAt(20);
               if(armShellInfo)
               {
                  armShellName = armShellInfo.Name;
               }
               _armShellNameTxt.text = LanguageMgr.GetTranslation("tank.data.EquipType.armShell") + ":" + armShellName;
               _armShellNameTxt.textColor = 16711680;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _armShellNameTxt;
            }
         }
      }
      
      protected function createDescript() : void
      {
         var tempItemInfo:* = null;
         var itemEveryDayRecordData:* = null;
         var tempDesArr:* = null;
         var amuletVo:* = null;
         var infoItem:* = null;
         var beadInfo:* = null;
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
            tempItemInfo = _info as InventoryItemInfo;
            itemEveryDayRecordData = ItemActivityGiftManager.instance.model.itemEveryDayRecord[tempItemInfo.TemplateID + "," + tempItemInfo.ItemID];
            if(itemEveryDayRecordData)
            {
               tempDesArr = _info.Description.split("|");
               if(tempDesArr.length > 1)
               {
                  _descriptionTxt.text = tempDesArr[itemEveryDayRecordData.OpenIndex] + "";
               }
               else
               {
                  _descriptionTxt.text = tempDesArr[0] + "";
               }
            }
         }
         else if(_info.CategoryID == 69)
         {
            amuletVo = HorseAmuletManager.instance.data[_info.TemplateID];
            _descriptionTxt.text = StringHelper.format(amuletVo.Desc,amuletVo.BaseType1Value,(_info as InventoryItemInfo).Hole1);
         }
         else if(_info.Property1 != "31")
         {
            _descriptionTxt.text = _info.Description + "";
         }
         else
         {
            infoItem = _info as InventoryItemInfo;
            beadInfo = BeadTemplateManager.Instance.GetBeadInfobyID(_info.TemplateID);
            if(beadInfo.Attribute1 == "0" && beadInfo.Attribute2 == "0")
            {
               _descriptionTxt.text = StringHelper.format(_info.Description);
            }
            else if(beadInfo.Attribute1 == "0" && beadInfo.Attribute2 != "0")
            {
               if(beadInfo.Att2.length > 1)
               {
                  if(infoItem && infoItem.Hole1 > beadInfo.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att2[1],beadInfo.Att3[1]);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att2[0]);
                  }
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Attribute2);
               }
            }
            else if(beadInfo.Attribute1 != "0" && beadInfo.Attribute2 == "0")
            {
               if(beadInfo.Att1.length > 1)
               {
                  if(infoItem && infoItem.Hole1 > beadInfo.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[1]);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[0]);
                  }
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Attribute1);
               }
            }
            else if(beadInfo.Attribute1 != "0" && beadInfo.Attribute2 != "0" && beadInfo.Attribute3 == "0")
            {
               if(beadInfo.Att1.length > 1 && beadInfo.Att2.length == 1)
               {
                  if(infoItem && infoItem.Hole1 > beadInfo.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[1],beadInfo.Attribute2);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[0],beadInfo.Attribute2);
                  }
               }
               else if(beadInfo.Att1.length == 1 && beadInfo.Att2.length > 1)
               {
                  if(infoItem && infoItem.Hole1 > beadInfo.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Attribute1,beadInfo.Att2[1]);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Attribute1,beadInfo.Att2[0]);
                  }
               }
               else if(infoItem && infoItem.Hole1 > beadInfo.BaseLevel)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[1],beadInfo.Att2[1],beadInfo.Att3[1]);
               }
               else if(beadInfo.Type3 > 0)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[0],beadInfo.Att2[0],beadInfo.Att3[0]);
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[0],beadInfo.Att2[0]);
               }
            }
            else if(beadInfo.Attribute1 != "0" && beadInfo.Attribute2 != "0" && beadInfo.Attribute3 != "0")
            {
               if(beadInfo.Att1.length != 1)
               {
                  if(infoItem && infoItem.Hole1 > beadInfo.BaseLevel)
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[1],beadInfo.Att2[1],beadInfo.Att3[1]);
                  }
                  else
                  {
                     _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[0],beadInfo.Att2[0],beadInfo.Att3[0]);
                  }
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[0],beadInfo.Att2[0],beadInfo.Att3[0]);
               }
            }
         }
         _descriptionTxt.height = _descriptionTxt.textHeight + 10;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _descriptionTxt;
      }
      
      private function ShowBound(info:InventoryItemInfo) : Boolean
      {
         return info.CategoryID != 32 && info.CategoryID != 33 && info.CategoryID != 36;
      }
      
      private function createBindType() : void
      {
         var ttf:* = null;
         if(SyahManager.Instance.inView)
         {
            return;
         }
         var tempInfo:InventoryItemInfo = _info as InventoryItemInfo;
         if(tempInfo && ShowBound(tempInfo) && tempInfo.isShowBind)
         {
            _boundImage.setFrame(!!tempInfo.IsBinds?1:uint(2));
            ttf = _typeItem.foreItems[0] as FilterFrameText;
            _bindImageOriginalPos.x = ttf.x + ttf.width + 50;
            PositionUtils.setPos(_boundImage,_bindImageOriginalPos);
            _minWidth = _boundImage.x + _boundImage.width > _minWidth?_boundImage.x + _boundImage.width:_minWidth;
            addChild(_boundImage);
            if(!tempInfo.IsBinds)
            {
               if(tempInfo.BindType == 3)
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
         var tempReman:Number = NaN;
         var tempInfo:* = null;
         var remain:Number = NaN;
         var colorDate:Number = NaN;
         var str:* = null;
         var hour:* = NaN;
         var latentEnergyRemainStr:* = null;
         var tmpStr:* = null;
         var tmpTxtColor:* = 0;
         if(_remainTimeBg.parent)
         {
            _remainTimeBg.parent.removeChild(_remainTimeBg);
         }
         if(_info is InventoryItemInfo)
         {
            tempInfo = _info as InventoryItemInfo;
            remain = tempInfo.getRemainDate();
            colorDate = tempInfo.getColorValidDate();
            str = tempInfo.CategoryID == 7?LanguageMgr.GetTranslation("bag.changeColor.tips.armName"):"";
            if(colorDate > 0 && colorDate != 2147483647)
            {
               if(colorDate >= 1)
               {
                  _remainTimeTxt.text = (!!tempInfo.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + Math.ceil(colorDate) + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               else
               {
                  hour = Number(Math.floor(colorDate * 24));
                  if(hour < 1)
                  {
                     hour = 1;
                  }
                  _remainTimeTxt.text = (!!tempInfo.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + hour + LanguageMgr.GetTranslation("hours");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
            }
            if(remain == 2147483647)
            {
               _remainTimeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
               _remainTimeTxt.textColor = 16776960;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _remainTimeTxt;
            }
            else if(remain > 0)
            {
               if(remain >= 1)
               {
                  tempReman = Math.ceil(remain);
                  _remainTimeTxt.text = (!!tempInfo.IsUsed?str + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + tempReman + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               else if(remain * 24 >= 1)
               {
                  tempReman = Math.floor(remain * 24);
                  tempReman = tempReman < 1?1:Number(tempReman);
                  _remainTimeTxt.text = (!!tempInfo.IsUsed?str + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + tempReman + LanguageMgr.GetTranslation("hours");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               else if(remain * 24 * 60 >= 1)
               {
                  tempReman = Math.floor(remain * 24 * 60);
                  tempReman = tempReman < 1?1:Number(tempReman);
                  _remainTimeTxt.text = (!!tempInfo.IsUsed?str + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + tempReman + LanguageMgr.GetTranslation("minute");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               addChild(_remainTimeBg);
            }
            else if(!isNaN(remain))
            {
               _remainTimeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.over");
               _remainTimeTxt.textColor = 16711680;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _remainTimeTxt;
            }
            if(tempInfo.isHasLatentEnergy)
            {
               latentEnergyRemainStr = TimeManager.Instance.getMaxRemainDateStr(tempInfo.latentEnergyEndTime,2);
               tmpStr = _remainTimeTxt.text;
               tmpStr = tmpStr + LanguageMgr.GetTranslation("ddt.latentEnergy.tipRemainDateTxt",latentEnergyRemainStr);
               tmpTxtColor = uint(_remainTimeTxt.textColor);
               _remainTimeTxt.text = tmpStr;
               _remainTimeTxt.textColor = tmpTxtColor;
            }
         }
      }
      
      private function createGoldRemainTime() : void
      {
         var goldTempReman:Number = NaN;
         var tempInfo:* = null;
         var goldRemain:Number = NaN;
         var goldValidDate:Number = NaN;
         var goldBeginTime:* = null;
         if(SyahManager.Instance.inView)
         {
            return;
         }
         if(_info is InventoryItemInfo)
         {
            tempInfo = _info as InventoryItemInfo;
            goldRemain = tempInfo.getGoldRemainDate();
            goldValidDate = tempInfo.goldValidDate;
            goldBeginTime = tempInfo.goldBeginTime;
            if((_info as InventoryItemInfo).isGold)
            {
               if(goldRemain >= 1)
               {
                  goldTempReman = Math.ceil(goldRemain);
                  _goldRemainTimeTxt.text = LanguageMgr.GetTranslation("wishBead.GoodsTipPanel.txt1") + goldTempReman + LanguageMgr.GetTranslation("wishBead.GoodsTipPanel.txt2");
               }
               else
               {
                  goldTempReman = Math.floor(goldRemain * 24);
                  goldTempReman = goldTempReman < 1?1:Number(goldTempReman);
                  _goldRemainTimeTxt.text = LanguageMgr.GetTranslation("wishBead.GoodsTipPanel.txt1") + goldTempReman + LanguageMgr.GetTranslation("wishBead.GoodsTipPanel.txt3");
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
         var bg:* = null;
         var leftTime:int = 0;
         var h:int = 0;
         var m:int = 0;
         if(EquipType.isTimeBox(_info))
         {
            bg = DateUtils.getDateByStr((_info as InventoryItemInfo).BeginDate);
            leftTime = int(_info.Property3) * 60 - (TimeManager.Instance.Now().getTime() - bg.getTime()) / 1000;
            if(leftTime > 0)
            {
               h = leftTime / 3600;
               m = leftTime % 3600 / 60;
               m = m > 0?m:1;
               _boxTimeTxt.text = LanguageMgr.GetTranslation("ddt.userGuild.boxTip",h,m);
               _boxTimeTxt.textColor = 16777215;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _boxTimeTxt;
            }
         }
      }
      
      private function createStrenthLevel() : void
      {
         var tempInfo:InventoryItemInfo = _info as InventoryItemInfo;
         if(tempInfo && tempInfo.StrengthenLevel > 0 && !EquipType.isMagicStone(_info.CategoryID) && tempInfo.CategoryID != 70 && tempInfo.CategoryID != 19 && tempInfo.CategoryID != 74)
         {
            if(tempInfo.isGold)
            {
               _strengthenLevelImage.setFrame(16);
            }
            else
            {
               _strengthenLevelImage.setFrame(tempInfo.StrengthenLevel);
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
         var container:* = null;
         var bd:* = null;
         var bitmap:* = null;
         var info:InventoryItemInfo = _info as InventoryItemInfo;
         if(!info || !info.magicStoneAttr)
         {
            return;
         }
         var tempMgStone:InventoryItemInfo = new InventoryItemInfo();
         tempMgStone.TemplateID = info.magicStoneAttr.templateId;
         ItemManager.fill(tempMgStone);
         tempMgStone.Level = info.magicStoneAttr.level;
         tempMgStone.Attack = info.magicStoneAttr.attack;
         tempMgStone.Defence = info.magicStoneAttr.defence;
         tempMgStone.Agility = info.magicStoneAttr.agility;
         tempMgStone.Luck = info.magicStoneAttr.luck;
         tempMgStone.MagicAttack = info.magicStoneAttr.magicAttack;
         tempMgStone.MagicDefence = info.magicStoneAttr.magicDefence;
         _mgStoneName.text = tempMgStone.Name + "Lv." + tempMgStone.Level;
         _mgStoneName.textColor = 2467327;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _mgStoneName;
         switch(int(tempMgStone.Quality) - 1)
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
         if(tempMgStone.Attack != 0)
         {
            container = new Sprite();
            bd = _magicStoneIcon.bitmapData.clone();
            bitmap = new Bitmap(bd);
            container.addChild(bitmap);
            _attackTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.fire") + "+" + String(tempMgStone.Attack);
            _attackTxt2.textColor = 2467327;
            _attackTxt2.x = 20;
            _attackTxt2.y = 3;
            container.addChild(_attackTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = container;
         }
         if(tempMgStone.Defence != 0)
         {
            container = new Sprite();
            bd = _magicStoneIcon.bitmapData.clone();
            bitmap = new Bitmap(bd);
            container.addChild(bitmap);
            _defenseTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.recovery") + "+" + String(tempMgStone.Defence);
            _defenseTxt2.textColor = 2467327;
            _defenseTxt2.x = 20;
            _defenseTxt2.y = 3;
            container.addChild(_defenseTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = container;
         }
         if(tempMgStone.Agility != 0)
         {
            container = new Sprite();
            bd = _magicStoneIcon.bitmapData.clone();
            bitmap = new Bitmap(bd);
            container.addChild(bitmap);
            _agilityTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.agility") + "+" + String(tempMgStone.Agility);
            _agilityTxt2.textColor = 2467327;
            _agilityTxt2.x = 20;
            _agilityTxt2.y = 3;
            container.addChild(_agilityTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = container;
         }
         if(tempMgStone.Luck != 0)
         {
            container = new Sprite();
            bd = _magicStoneIcon.bitmapData.clone();
            bitmap = new Bitmap(bd);
            container.addChild(bitmap);
            _luckTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.lucky") + "+" + String(tempMgStone.Luck);
            _luckTxt2.textColor = 2467327;
            _luckTxt2.x = 20;
            _luckTxt2.y = 3;
            container.addChild(_luckTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = container;
         }
         if(tempMgStone.MagicAttack != 0)
         {
            container = new Sprite();
            bd = _magicStoneIcon.bitmapData.clone();
            bitmap = new Bitmap(bd);
            container.addChild(bitmap);
            _magicAttackTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicAttack") + "+" + String(tempMgStone.MagicAttack);
            _magicAttackTxt2.textColor = 2467327;
            _magicAttackTxt2.x = 20;
            _magicAttackTxt2.y = 3;
            container.addChild(_magicAttackTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = container;
         }
         if(tempMgStone.MagicDefence != 0)
         {
            container = new Sprite();
            bd = _magicStoneIcon.bitmapData.clone();
            bitmap = new Bitmap(bd);
            container.addChild(bitmap);
            _magicDefenceTxt2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicDefence") + "+" + String(tempMgStone.MagicDefence);
            _magicDefenceTxt2.textColor = 2467327;
            _magicDefenceTxt2.x = 20;
            _magicDefenceTxt2.y = 3;
            container.addChild(_magicDefenceTxt2);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = container;
         }
      }
      
      private function createEvolutionProperties() : void
      {
         var data:* = null;
         var color:* = 0;
         var mcLevel:int = 0;
         var info:InventoryItemInfo = _info as InventoryItemInfo;
         if(info == null)
         {
            info = new InventoryItemInfo();
            ObjectUtils.copyProperties(info,_info);
         }
         if(info && info.CategoryID == 17 && (info.Property3 == "32" || info.Property3 == "31" || info.Property3 == "132"))
         {
            data = FineEvolutionManager.Instance.GetEvolutionDataByExp(info.curExp);
            color = 16777215;
            if(data)
            {
               _enchantLevelTxt.text = LanguageMgr.GetTranslation("evolutionchant.levelTxt",data.Level);
               if(info.Property3 == "32")
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.tips.addblood",data.AddBlood / 10 + "%");
               }
               else if(info.Property3 == "132")
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.reduceRander",data.ReduceDander / 10 + "%");
               }
               else
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.tips.reducedamage",data.ReduceDamage / 10 + "%");
               }
               mcLevel = data.Level;
               if(mcLevel > 0)
               {
                  if(mcLevel <= 4)
                  {
                     color = uint(164607);
                  }
                  if(mcLevel >= 5 && mcLevel <= 9)
                  {
                     color = uint(10696174);
                  }
                  if(mcLevel >= 10 && mcLevel <= 15)
                  {
                     color = uint(16744448);
                  }
                  if(mcLevel >= 16 && mcLevel <= 20)
                  {
                     color = uint(16711833);
                  }
               }
               var _loc5_:* = color;
               _enchantAttackTxt.textColor = _loc5_;
               _enchantLevelTxt.textColor = _loc5_;
            }
            else
            {
               _enchantLevelTxt.text = LanguageMgr.GetTranslation("evolutionchant.levelTxt","0");
               if(info.Property3 == "32")
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.tips.addblood","0%");
               }
               else if(info.Property3 == "132")
               {
                  _enchantAttackTxt.text = LanguageMgr.GetTranslation("store.evolution.reduceRander","0%");
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
         var info:InventoryItemInfo = _info as InventoryItemInfo;
         if(!info || info.MagicLevel <= 0 || !info.isCanEnchant())
         {
            _enchantAttackPencentTxt.text = "";
            _enchantDefencePencentTxt.text = "";
            return;
         }
         var enchantInfo:EnchantInfo = EnchantManager.instance.getEnchantInfoByLevel(info.MagicLevel);
         if(!enchantInfo)
         {
            return;
         }
         _enchantLevelTxt.text = LanguageMgr.GetTranslation("enchant.levelTxt",int(enchantInfo.Lv / 10) + 1,enchantInfo.Lv % 10);
         _enchantAttackTxt.text = LanguageMgr.GetTranslation("enchant.addMagicAttackTxt") + enchantInfo.MagicAttack;
         _enchantDefenceTxt.text = LanguageMgr.GetTranslation("enchant.addMagicDenfenceTxt") + enchantInfo.MagicDefence;
         var _loc4_:* = int(info.Property1) < 5?11842740:13971455;
         _enchantDefenceTxt.textColor = _loc4_;
         _loc4_ = _loc4_;
         _enchantAttackTxt.textColor = _loc4_;
         _enchantLevelTxt.textColor = _loc4_;
         var _level:int = info.Property1;
         switch(int(_level))
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
         var prop:* = null;
         _lineIdx = Number(_lineIdx) + 1;
         if(_lines.length < _lineIdx)
         {
            prop = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
            _lines.push(prop);
         }
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _lines[_lineIdx - 1];
      }
      
      private function getGhostPropertyData() : GhostPropertyData
      {
         var ghostPropertyData:GhostPropertyData = null;
         var ivenInfo:InventoryItemInfo = _info as InventoryItemInfo;
         if(ivenInfo == null)
         {
            return null;
         }
         var player:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         var isOther:* = player.ID != PlayerManager.Instance.Self.ID;
         var isWearedEquip:Boolean = ivenInfo.BagType == 0 && ivenInfo.Place <= 30;
         if(isOther)
         {
            ghostPropertyData = !!isWearedEquip?EquipGhostManager.getInstance().getPorpertyData(ivenInfo,player):null;
         }
         else
         {
            ghostPropertyData = ivenInfo.fromBag && (isWearedEquip || EquipGhostManager.getInstance().isEquipGhosting())?EquipGhostManager.getInstance().getPorpertyData(ivenInfo,player):null;
         }
         return ghostPropertyData;
      }
   }
}
