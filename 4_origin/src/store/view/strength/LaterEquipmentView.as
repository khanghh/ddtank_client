package store.view.strength
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.utils.StaticFormula;
   import ddt.view.SimpleItem;
   import ddt.view.tips.GhostStarContainer;
   import ddt.view.tips.GoodTipInfo;
   import enchant.EnchantManager;
   import enchant.data.EnchantInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import latentEnergy.LatentEnergyTipItem;
   import road7th.utils.DateUtils;
   import road7th.utils.StringHelper;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.EquipGhostData;
   import store.equipGhost.data.GhostData;
   import store.equipGhost.data.GhostPropertyData;
   
   public class LaterEquipmentView extends Component
   {
      
      public static const ITEM_ENCHANT_COLOR:uint = 13971455;
       
      
      private var _strengthenLevelImage:MovieImage;
      
      private var _fusionLevelImage:MovieImage;
      
      private var _boundImage:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _qualityItem:SimpleItem;
      
      private var _typeItem:SimpleItem;
      
      private var _mainPropertyItem:SimpleItem;
      
      private var _armAngleItem:SimpleItem;
      
      private var _otherHp:SimpleItem;
      
      private var _necklaceItem:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _defenseTxt:FilterFrameText;
      
      private var _agilityTxt:FilterFrameText;
      
      private var _luckTxt:FilterFrameText;
      
      private var _enchantLevelTxt:FilterFrameText;
      
      private var _enchantAttackTxt:FilterFrameText;
      
      private var _enchantDefenceTxt:FilterFrameText;
      
      private var _enchantAttackPencentTxt:FilterFrameText;
      
      private var _enchantDefencePencentTxt:FilterFrameText;
      
      private var _needLevelTxt:FilterFrameText;
      
      private var _needSexTxt:FilterFrameText;
      
      private var _holes:Vector.<FilterFrameText>;
      
      private var _upgradeType:FilterFrameText;
      
      private var _ghostSkillDesc:FilterFrameText;
      
      private var _descriptionTxt:FilterFrameText;
      
      private var _bindTypeTxt:FilterFrameText;
      
      private var _remainTimeTxt:FilterFrameText;
      
      private var _goldRemainTimeTxt:FilterFrameText;
      
      private var _fightPropConsumeTxt:FilterFrameText;
      
      private var _boxTimeTxt:FilterFrameText;
      
      private var _limitGradeTxt:FilterFrameText;
      
      private var _info:ItemTemplateInfo;
      
      private var _bindImageOriginalPos:Point;
      
      private var _maxWidth:int;
      
      private var _minWidth:int = 196;
      
      private var _autoGhostWidth:int;
      
      private var _isArmed:Boolean;
      
      private var _displayList:Vector.<DisplayObject>;
      
      private var _displayIdx:int;
      
      private var _lines:Vector.<Image>;
      
      private var _lineIdx:int;
      
      private var _isReAdd:Boolean;
      
      private var _remainTimeBg:Bitmap;
      
      private var _tipbackgound:MutipleImage;
      
      private var _rightArrows:Bitmap;
      
      private var _ghostLV:int = -1;
      
      private var _ghostStartsContainer:GhostStarContainer = null;
      
      public function LaterEquipmentView()
      {
         _holes = new Vector.<FilterFrameText>();
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         _lines = new Vector.<Image>();
         _displayList = new Vector.<DisplayObject>();
         _rightArrows = ComponentFactory.Instance.creatBitmap("asset.ddtstore.rightArrows");
         _tipbackgound = ComponentFactory.Instance.creat("ddtstore.strengthTips.strengthenImageBG");
         _strengthenLevelImage = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameMc");
         _fusionLevelImage = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTrinketLevelMc");
         _boundImage = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.BoundImage");
         _bindImageOriginalPos = new Point(_boundImage.x,_boundImage.y);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameTxt");
         _qualityItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.QualityItem");
         _typeItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.TypeItem");
         _mainPropertyItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.MainPropertyItem");
         _armAngleItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.armAngleItem");
         _otherHp = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.otherHp");
         _necklaceItem = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _defenseTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _agilityTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _luckTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantLevelTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantAttackTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantDefenceTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantAttackPencentTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _enchantDefencePencentTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _holes = new Vector.<FilterFrameText>();
         for(i = 0; i < 6; )
         {
            _holes.push(ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt"));
            i++;
         }
         _needLevelTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _needSexTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _upgradeType = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.DescriptionTxt");
         _ghostSkillDesc = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.ghostDescTxt");
         _bindTypeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _remainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemDateTxt");
         _goldRemainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipGoldItemDateTxt");
         _remainTimeBg = ComponentFactory.Instance.creatBitmap("asset.core.tip.restTime");
         _fightPropConsumeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _boxTimeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _limitGradeTxt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.LimitGradeTxt");
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data)
         {
            if(data is GoodTipInfo)
            {
               _tipData = data as GoodTipInfo;
               showTip(_tipData.itemInfo,_tipData.typeIsSecond);
            }
            else if(data is ShopItemInfo)
            {
               _tipData = data as ShopItemInfo;
               showTip(_tipData.TemplateInfo);
            }
            visible = true;
         }
         else
         {
            _tipData = null;
            visible = false;
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
         updateView();
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
         createMainProperty();
         seperateLine();
         createNecklaceItem();
         createProperties();
         seperateLine();
         createEnchantProperties();
         seperateLine();
         createLatentEnergy();
         seperateLine();
         createOperationItem();
         seperateLine();
         createGhostSkillitem();
         createDescript();
         createBindType();
         createRemainTime();
         createGoldRemainTime();
         createFightPropConsume();
         createBoxTimeItem();
         createShopItemLimitGrade(_tipData as ShopItemInfo);
         addChildren();
         createStrenthLevel();
      }
      
      private function createGhostSkillitem() : void
      {
         var player:* = null;
         var equipGhostData:* = null;
         var ivenInfo:InventoryItemInfo = _info as InventoryItemInfo;
         var needShow:Boolean = ivenInfo != null && (ivenInfo.BagType == 0 && ivenInfo.Place <= 30 || EquipGhostManager.getInstance().isEquipGhosting());
         if(!needShow)
         {
            return;
         }
         var ghostLv:int = -1;
         var tipInfo:GoodTipInfo = _tipData as GoodTipInfo;
         var ghostData:GhostData = null;
         if(tipInfo && tipInfo.ghostLv > 0)
         {
            ghostData = EquipGhostManager.getInstance().model.getGhostData(tipInfo.itemInfo.CategoryID,tipInfo.ghostLv);
            if(ghostData)
            {
               _ghostSkillDesc.text = StringHelper.format(PetSkillManager.getSkillByID(ghostData.skillId).Description);
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _ghostSkillDesc;
            }
         }
         else
         {
            player = !!PlayerInfoViewControl.currentPlayer?PlayerInfoViewControl.currentPlayer:PlayerManager.Instance.Self;
            equipGhostData = player.getGhostDataByCategoryID(_info.CategoryID);
            if(equipGhostData)
            {
               ghostData = EquipGhostManager.getInstance().model.getGhostData(_info.CategoryID,equipGhostData.level);
               if(ghostData)
               {
                  _ghostSkillDesc.text = StringHelper.format(PetSkillManager.getSkillByID(ghostData.skillId).Description);
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _ghostSkillDesc;
               }
            }
         }
      }
      
      private function createEnchantProperties() : void
      {
         var info:InventoryItemInfo = _info as InventoryItemInfo;
         if(!info || info.MagicLevel <= 0)
         {
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
         _enchantLevelTxt.textColor = 13971455;
         _enchantAttackTxt.textColor = 13971455;
         _enchantDefenceTxt.textColor = 13971455;
         var tf:TextFormat = ComponentFactory.Instance.model.getSet("ddt.store.view.exalt.LaterEquipmentViewTextTF");
         _enchantAttackTxt.setTextFormat(tf,3,_enchantAttackTxt.text.length);
         _enchantDefenceTxt.setTextFormat(tf,3,_enchantAttackTxt.text.length);
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantLevelTxt;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantAttackTxt;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantDefenceTxt;
         var _level:int = info.Property1;
         switch(int(_level))
         {
            case 0:
            case 1:
            case 2:
               _enchantAttackPencentTxt.text = "0%";
               _enchantDefencePencentTxt.text = "0%";
               var _loc5_:int = 16777215;
               _enchantDefencePencentTxt.textColor = _loc5_;
               _enchantAttackPencentTxt.textColor = _loc5_;
               break;
            case 3:
               _enchantAttackPencentTxt.text = "60%";
               _enchantDefencePencentTxt.text = "60%";
               _loc5_ = 65328;
               _enchantDefencePencentTxt.textColor = _loc5_;
               _enchantAttackPencentTxt.textColor = _loc5_;
               break;
            case 4:
               _enchantAttackPencentTxt.text = "80%";
               _enchantDefencePencentTxt.text = "80%";
               _loc5_ = 762111;
               _enchantDefencePencentTxt.textColor = _loc5_;
               _enchantAttackPencentTxt.textColor = _loc5_;
         }
      }
      
      private function clear() : void
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
            item = _displayList[i] as DisplayObject;
            if(_lines.indexOf(item as Image) < 0 && item != _descriptionTxt && item != _ghostSkillDesc)
            {
               tempMaxWidth = Math.max(item.width,tempMaxWidth);
            }
            PositionUtils.setPos(item,pos);
            addChild(item);
            pos.y = item.y + item.height + offset;
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
         if(_ghostSkillDesc.width != _maxWidth - 5)
         {
            _ghostSkillDesc.width = _maxWidth - 5;
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
         if(_rightArrows)
         {
            addChildAt(_rightArrows,0);
         }
         if(len > 0)
         {
            _tipbackgound.y = -5;
            var _loc7_:* = _maxWidth + 8;
            _tipbackgound.width = _loc7_;
            _width = _loc7_;
            _loc7_ = item.y + item.height + 18;
            _tipbackgound.height = _loc7_;
            _height = _loc7_;
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
         if(_remainTimeBg.parent)
         {
            _goldRemainTimeTxt.x = _remainTimeTxt.x + 2;
            _goldRemainTimeTxt.y = _remainTimeTxt.y + 22;
            _remainTimeBg.parent.addChildAt(_goldRemainTimeTxt,1);
         }
         _rightArrows.x = 5 - _rightArrows.width;
         _rightArrows.y = (this.height - _rightArrows.height) / 2;
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
      
      private function createItemName() : void
      {
         var format:* = null;
         _nameTxt.text = String(_info.Name);
         var tempInfo:InventoryItemInfo = _info as InventoryItemInfo;
         if(tempInfo && tempInfo.StrengthenLevel > 0)
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
         _nameTxt.textColor = QualityType.QUALITY_COLOR[_info.Quality];
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _nameTxt;
      }
      
      private function createQualityItem() : void
      {
         var fft:FilterFrameText = _qualityItem.foreItems[0] as FilterFrameText;
         fft.text = QualityType.QUALITY_STRING[_info.Quality];
         fft.textColor = QualityType.QUALITY_COLOR[_info.Quality];
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _qualityItem;
      }
      
      private function createCategoryItem() : void
      {
         var fft:FilterFrameText = _typeItem.foreItems[0] as FilterFrameText;
         var arr:Array = EquipType.PARTNAME;
         fft.text = !EquipType.PARTNAME[_info.CategoryID]?"":EquipType.PARTNAME[_info.CategoryID];
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _typeItem;
      }
      
      private function createMainProperty() : void
      {
         var strenGold:* = NaN;
         var armValue:* = NaN;
         var tf:* = null;
         var beginIndex:int = 0;
         var endIndex:int = 0;
         var attachedMainPropertyStr:String = "";
         var strengthenedStr:String = "";
         var strengthenLevel:int = 0;
         var fft:FilterFrameText = _mainPropertyItem.foreItems[0] as FilterFrameText;
         var type:ScaleFrameImage = _mainPropertyItem.backItem as ScaleFrameImage;
         var ivenInfo:InventoryItemInfo = _info as InventoryItemInfo;
         GhostStarContainer(_mainPropertyItem.foreItems[1]).visible = false;
         GhostStarContainer(_armAngleItem.foreItems[1]).visible = false;
         _autoGhostWidth = 0;
         var attachedMainProperty:uint = 0;
         var player:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         var ghostPropertyData:GhostPropertyData = ivenInfo == null || ivenInfo.Place > 30 || !EquipGhostManager.getInstance().isEquipGhosting()?null:EquipGhostManager.getInstance().getPorpertyData(ivenInfo,PlayerInfoViewControl.currentPlayer);
         var goodTipInfo:GoodTipInfo = _tipData as GoodTipInfo;
         if(goodTipInfo && EquipGhostManager.getInstance().isEquipGhosting())
         {
            if(goodTipInfo.ghostLv > 0 && ivenInfo && ivenInfo.Place <= 30)
            {
               ghostPropertyData = EquipGhostManager.getInstance().getPropertyDataByLv(ivenInfo,goodTipInfo.ghostLv);
            }
         }
         if(EquipType.isArm(_info))
         {
            strenGold = 0;
            if(ivenInfo && ivenInfo.StrengthenLevel > 0)
            {
               strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
               strenGold = Number(StaticFormula.getHertAddition(int(ivenInfo.Property7),strengthenLevel));
            }
            type.setFrame(1);
            attachedMainProperty = strenGold + (!!ghostPropertyData?ghostPropertyData.mainProperty:0);
            attachedMainPropertyStr = attachedMainProperty > 0?"(+" + attachedMainProperty + ")":"";
            fft.text = " " + _info.Property7.toString() + attachedMainPropertyStr;
            FilterFrameText(_armAngleItem.foreItems[0]).text = " " + _info.Property5 + "°~" + _info.Property6 + "°";
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _armAngleItem;
            if(ghostPropertyData != null)
            {
               _ghostStartsContainer = _armAngleItem.foreItems[1] as GhostStarContainer;
               _ghostStartsContainer.x = _armAngleItem.foreItems[0].width + _armAngleItem.foreItems[0].x;
               _ghostStartsContainer.y = _armAngleItem.foreItems[0].y + 8;
               _ghostStartsContainer.maxLv = EquipGhostManager.getInstance().model.topLvDic[_info.CategoryID];
               _ghostStartsContainer.level = goodTipInfo.ghostLv;
               _ghostStartsContainer.visible = true;
               _autoGhostWidth = _ghostStartsContainer.x + _ghostStartsContainer.width;
            }
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
            attachedMainProperty = armValue + (ghostPropertyData != null?ghostPropertyData.mainProperty:0);
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
            if(ghostPropertyData != null)
            {
               _ghostStartsContainer = _mainPropertyItem.foreItems[1] as GhostStarContainer;
               _ghostStartsContainer.maxLv = EquipGhostManager.getInstance().model.topLvDic[_info.CategoryID];
               _ghostStartsContainer.x = _mainPropertyItem.foreItems[0].width + _mainPropertyItem.foreItems[0].x;
               _ghostStartsContainer.y = _mainPropertyItem.foreItems[0].y + 8;
               _ghostStartsContainer.level = goodTipInfo.ghostLv;
               _ghostStartsContainer.visible = true;
               _autoGhostWidth = _ghostStartsContainer.x + _ghostStartsContainer.width;
            }
         }
         else if(StaticFormula.isDeputyWeapon(_info) || _info.CategoryID == 31)
         {
            if(_info.Property3 == "32")
            {
               if(ivenInfo && ivenInfo.StrengthenLevel > 0)
               {
                  strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
                  strengthenedStr = "(+" + StaticFormula.getRecoverHPAddition(int(ivenInfo.Property7),strengthenLevel) + ")";
               }
               type.setFrame(3);
               fft.text = " " + _info.Property7.toString() + strengthenedStr;
            }
            else if(_info.Property3 == "132")
            {
               if(ivenInfo && ivenInfo.StrengthenLevel > 0)
               {
                  strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
                  strengthenedStr = "(+" + int(StaticFormula.getRecoverHPAddition(int(ivenInfo.Property7),strengthenLevel) / 2) + ")";
               }
               type.setFrame(5);
               fft.text = " " + (int(_info.Property7) / 2).toString() + strengthenedStr;
            }
            else
            {
               if(ivenInfo && ivenInfo.StrengthenLevel > 0)
               {
                  strengthenLevel = !!ivenInfo.isGold?ivenInfo.StrengthenLevel + 1:ivenInfo.StrengthenLevel;
                  strengthenedStr = "(+" + StaticFormula.getDefenseAddition(int(ivenInfo.Property7),strengthenLevel) + ")";
               }
               type.setFrame(4);
               fft.text = " " + _info.Property7.toString() + strengthenedStr;
            }
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
         }
         if(fft && fft.text != "")
         {
            tf = ComponentFactory.Instance.model.getSet("ddt.store.view.exalt.LaterEquipmentViewTextTF");
            beginIndex = fft.text.indexOf("(");
            endIndex = fft.text.indexOf(")") + 1;
            if(beginIndex > -1)
            {
               fft.setTextFormat(tf,beginIndex,endIndex);
            }
         }
      }
      
      private function createNecklaceItem() : void
      {
         if(_info.CategoryID == 14)
         {
            _necklaceItem.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.life") + ":" + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.advance") + _info.Property1 + "%";
            _necklaceItem.textColor = 16750899;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _necklaceItem;
         }
         else if(_info.CategoryID == 70)
         {
         }
      }
      
      private function setPurpleHtmlTxt(title:String, value:int, add:String) : String
      {
         return LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.setPurpleHtmlTxt",title,value,add);
      }
      
      private function createProperties() : void
      {
         var t:* = null;
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
         var ivenInfo:InventoryItemInfo = _info as InventoryItemInfo;
         var ghostPropertyData:GhostPropertyData = ivenInfo == null || ivenInfo.Place > 30 || !EquipGhostManager.getInstance().isEquipGhosting()?null:EquipGhostManager.getInstance().getPorpertyData(ivenInfo,PlayerInfoViewControl.currentPlayer);
         var goodTipInfo:GoodTipInfo = _tipData as GoodTipInfo;
         if(goodTipInfo)
         {
            if(goodTipInfo.ghostLv > 0 && (ivenInfo != null && ivenInfo.Place <= 30) && EquipGhostManager.getInstance().isEquipGhosting())
            {
               ghostPropertyData = EquipGhostManager.getInstance().getPropertyDataByLv(ivenInfo,goodTipInfo.ghostLv);
            }
         }
         if(ghostPropertyData != null)
         {
            if(ghostPropertyData.attack > 0)
            {
               gat = LanguageMgr.GetTranslation("equipGhost.tip",ghostPropertyData.attack);
            }
            if(ghostPropertyData.defend > 0)
            {
               gde = LanguageMgr.GetTranslation("equipGhost.tip",ghostPropertyData.defend);
            }
            if(ghostPropertyData.lucky > 0)
            {
               glu = LanguageMgr.GetTranslation("equipGhost.tip",ghostPropertyData.lucky);
            }
            if(ghostPropertyData.agility > 0)
            {
               gag = LanguageMgr.GetTranslation("equipGhost.tip",ghostPropertyData.agility);
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
         if(_info.NeedLevel > 1)
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
         if(_info.CanStrengthen && _info.CanCompose)
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
         else if(_info.CanCompose)
         {
            tipSmith = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.compose");
            if(EquipType.isRongLing(_info))
            {
               tipSmith = tipSmith + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.melting");
            }
            _upgradeType.text = tipSmith;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(_info.CanStrengthen)
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
      }
      
      private function createDescript() : void
      {
         if(_info.Description == "")
         {
            return;
         }
         _descriptionTxt.text = _info.Description;
         _descriptionTxt.height = _descriptionTxt.textHeight + 10;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _descriptionTxt;
      }
      
      private function createShopItemLimitGrade(itemInfo:ShopItemInfo) : void
      {
         if(itemInfo && itemInfo.LimitGrade > PlayerManager.Instance.Self.Grade)
         {
            _limitGradeTxt.text = LanguageMgr.GetTranslation("ddt.shop.LimitGradeBuy",itemInfo.LimitGrade);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _limitGradeTxt;
         }
      }
      
      private function ShowBound(info:InventoryItemInfo) : Boolean
      {
         return info.CategoryID != 32 && info.CategoryID != 33 && info.CategoryID != 36;
      }
      
      private function createBindType() : void
      {
         var tempInfo:InventoryItemInfo = _info as InventoryItemInfo;
         if(tempInfo && ShowBound(tempInfo))
         {
            _boundImage.setFrame(!!tempInfo.IsBinds?1:uint(2));
            PositionUtils.setPos(_boundImage,_bindImageOriginalPos);
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
      }
      
      private function createRemainTime() : void
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
               else
               {
                  tempReman = Math.floor(remain * 24);
                  tempReman = tempReman < 1?1:Number(tempReman);
                  _remainTimeTxt.text = (!!tempInfo.IsUsed?str + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + tempReman + LanguageMgr.GetTranslation("hours");
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
         if(_remainTimeBg.parent)
         {
            _remainTimeBg.parent.removeChild(_remainTimeBg);
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
         if(tempInfo && tempInfo.StrengthenLevel > 0)
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
      
      private function seperateLine() : void
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
      
      override public function dispose() : void
      {
         super.dispose();
         if(_rightArrows)
         {
            ObjectUtils.disposeObject(_rightArrows);
         }
         _rightArrows = null;
         if(_tipbackgound)
         {
            ObjectUtils.disposeObject(_tipbackgound);
         }
         _tipbackgound = null;
         if(_strengthenLevelImage)
         {
            ObjectUtils.disposeObject(_strengthenLevelImage);
         }
         _strengthenLevelImage = null;
         if(_fusionLevelImage)
         {
            ObjectUtils.disposeObject(_fusionLevelImage);
         }
         _fusionLevelImage = null;
         if(_boundImage)
         {
            ObjectUtils.disposeObject(_boundImage);
         }
         _boundImage = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_qualityItem)
         {
            ObjectUtils.disposeObject(_qualityItem);
         }
         _qualityItem = null;
         if(_typeItem)
         {
            ObjectUtils.disposeObject(_typeItem);
         }
         _typeItem = null;
         if(_mainPropertyItem)
         {
            ObjectUtils.disposeObject(_mainPropertyItem);
         }
         _mainPropertyItem = null;
         if(_armAngleItem)
         {
            ObjectUtils.disposeObject(_armAngleItem);
         }
         _armAngleItem = null;
         if(_otherHp)
         {
            ObjectUtils.disposeObject(_otherHp);
         }
         _otherHp = null;
         if(_necklaceItem)
         {
            ObjectUtils.disposeObject(_necklaceItem);
         }
         _necklaceItem = null;
         if(_attackTxt)
         {
            ObjectUtils.disposeObject(_attackTxt);
         }
         _attackTxt = null;
         if(_defenseTxt)
         {
            ObjectUtils.disposeObject(_defenseTxt);
         }
         _defenseTxt = null;
         if(_agilityTxt)
         {
            ObjectUtils.disposeObject(_agilityTxt);
         }
         _agilityTxt = null;
         if(_luckTxt)
         {
            ObjectUtils.disposeObject(_luckTxt);
         }
         _luckTxt = null;
         ObjectUtils.disposeObject(_enchantLevelTxt);
         _enchantLevelTxt = null;
         ObjectUtils.disposeObject(_enchantAttackTxt);
         _enchantAttackTxt = null;
         ObjectUtils.disposeObject(_enchantDefenceTxt);
         _enchantDefenceTxt = null;
         ObjectUtils.disposeObject(_enchantDefencePencentTxt);
         _enchantDefencePencentTxt = null;
         ObjectUtils.disposeObject(_enchantAttackPencentTxt);
         _enchantAttackPencentTxt = null;
         if(_needLevelTxt)
         {
            ObjectUtils.disposeObject(_needLevelTxt);
         }
         _needLevelTxt = null;
         if(_needSexTxt)
         {
            ObjectUtils.disposeObject(_needSexTxt);
         }
         _needSexTxt = null;
         if(_upgradeType)
         {
            ObjectUtils.disposeObject(_upgradeType);
         }
         _upgradeType = null;
         if(_descriptionTxt)
         {
            ObjectUtils.disposeObject(_descriptionTxt);
         }
         _descriptionTxt = null;
         if(_bindTypeTxt)
         {
            ObjectUtils.disposeObject(_bindTypeTxt);
         }
         _bindTypeTxt = null;
         if(_remainTimeTxt)
         {
            ObjectUtils.disposeObject(_remainTimeTxt);
         }
         _remainTimeTxt = null;
         if(_goldRemainTimeTxt)
         {
            ObjectUtils.disposeObject(_goldRemainTimeTxt);
         }
         _goldRemainTimeTxt = null;
         if(_fightPropConsumeTxt)
         {
            ObjectUtils.disposeObject(_fightPropConsumeTxt);
         }
         _fightPropConsumeTxt = null;
         if(_boxTimeTxt)
         {
            ObjectUtils.disposeObject(_boxTimeTxt);
         }
         _boxTimeTxt = null;
         if(_limitGradeTxt)
         {
            ObjectUtils.disposeObject(_limitGradeTxt);
         }
         _limitGradeTxt = null;
         if(_remainTimeBg)
         {
            ObjectUtils.disposeObject(_remainTimeBg);
         }
         _remainTimeBg = null;
         if(_tipbackgound)
         {
            ObjectUtils.disposeObject(_tipbackgound);
         }
         _tipbackgound = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
