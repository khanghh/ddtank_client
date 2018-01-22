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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _holes.push(ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt"));
            _loc1_++;
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
      
      override public function set tipData(param1:Object) : void
      {
         if(param1)
         {
            if(param1 is GoodTipInfo)
            {
               _tipData = param1 as GoodTipInfo;
               showTip(_tipData.itemInfo,_tipData.typeIsSecond);
            }
            else if(param1 is ShopItemInfo)
            {
               _tipData = param1 as ShopItemInfo;
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
      
      public function showTip(param1:ItemTemplateInfo, param2:Boolean = false) : void
      {
         _displayIdx = 0;
         _displayList = new Vector.<DisplayObject>();
         _lineIdx = 0;
         _isReAdd = false;
         _maxWidth = 0;
         _autoGhostWidth = 0;
         _info = param1;
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
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:InventoryItemInfo = _info as InventoryItemInfo;
         var _loc7_:Boolean = _loc3_ != null && (_loc3_.BagType == 0 && _loc3_.Place <= 30 || EquipGhostManager.getInstance().isEquipGhosting());
         if(!_loc7_)
         {
            return;
         }
         var _loc1_:int = -1;
         var _loc2_:GoodTipInfo = _tipData as GoodTipInfo;
         var _loc6_:GhostData = null;
         if(_loc2_ && _loc2_.ghostLv > 0)
         {
            _loc6_ = EquipGhostManager.getInstance().model.getGhostData(_loc2_.itemInfo.CategoryID,_loc2_.ghostLv);
            if(_loc6_)
            {
               _ghostSkillDesc.text = StringHelper.format(PetSkillManager.getSkillByID(_loc6_.skillId).Description);
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _ghostSkillDesc;
            }
         }
         else
         {
            _loc4_ = !!PlayerInfoViewControl.currentPlayer?PlayerInfoViewControl.currentPlayer:PlayerManager.Instance.Self;
            _loc5_ = _loc4_.getGhostDataByCategoryID(_info.CategoryID);
            if(_loc5_)
            {
               _loc6_ = EquipGhostManager.getInstance().model.getGhostData(_info.CategoryID,_loc5_.level);
               if(_loc6_)
               {
                  _ghostSkillDesc.text = StringHelper.format(PetSkillManager.getSkillByID(_loc6_.skillId).Description);
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _ghostSkillDesc;
               }
            }
         }
      }
      
      private function createEnchantProperties() : void
      {
         var _loc4_:InventoryItemInfo = _info as InventoryItemInfo;
         if(!_loc4_ || _loc4_.MagicLevel <= 0)
         {
            return;
         }
         var _loc1_:EnchantInfo = EnchantManager.instance.getEnchantInfoByLevel(_loc4_.MagicLevel);
         if(!_loc1_)
         {
            return;
         }
         _enchantLevelTxt.text = LanguageMgr.GetTranslation("enchant.levelTxt",int(_loc1_.Lv / 10) + 1,_loc1_.Lv % 10);
         _enchantAttackTxt.text = LanguageMgr.GetTranslation("enchant.addMagicAttackTxt") + _loc1_.MagicAttack;
         _enchantDefenceTxt.text = LanguageMgr.GetTranslation("enchant.addMagicDenfenceTxt") + _loc1_.MagicDefence;
         _enchantLevelTxt.textColor = 13971455;
         _enchantAttackTxt.textColor = 13971455;
         _enchantDefenceTxt.textColor = 13971455;
         var _loc2_:TextFormat = ComponentFactory.Instance.model.getSet("ddt.store.view.exalt.LaterEquipmentViewTextTF");
         _enchantAttackTxt.setTextFormat(_loc2_,3,_enchantAttackTxt.text.length);
         _enchantDefenceTxt.setTextFormat(_loc2_,3,_enchantAttackTxt.text.length);
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantLevelTxt;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantAttackTxt;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _enchantDefenceTxt;
         var _loc3_:int = _loc4_.Property1;
         switch(int(_loc3_))
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
         var _loc1_:* = null;
         while(numChildren > 0)
         {
            _loc1_ = getChildAt(0) as DisplayObject;
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
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
            _loc1_ = _displayList[_loc4_] as DisplayObject;
            if(_lines.indexOf(_loc1_ as Image) < 0 && _loc1_ != _descriptionTxt && _loc1_ != _ghostSkillDesc)
            {
               _loc5_ = Math.max(_loc1_.width,_loc5_);
            }
            PositionUtils.setPos(_loc1_,_loc6_);
            addChild(_loc1_);
            _loc6_.y = _loc1_.y + _loc1_.height + _loc3_;
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
         if(_ghostSkillDesc.width != _maxWidth - 5)
         {
            _ghostSkillDesc.width = _maxWidth - 5;
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
         if(_rightArrows)
         {
            addChildAt(_rightArrows,0);
         }
         if(_loc2_ > 0)
         {
            _tipbackgound.y = -5;
            var _loc7_:* = _maxWidth + 8;
            _tipbackgound.width = _loc7_;
            _width = _loc7_;
            _loc7_ = _loc1_.y + _loc1_.height + 18;
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
      
      private function createItemName() : void
      {
         var _loc2_:* = null;
         _nameTxt.text = String(_info.Name);
         var _loc1_:InventoryItemInfo = _info as InventoryItemInfo;
         if(_loc1_ && _loc1_.StrengthenLevel > 0)
         {
            if(_loc1_.isGold)
            {
               if(_loc1_.StrengthenLevel > PathManager.solveStrengthMax())
               {
                  _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("store.view.exalt.goodTips",_loc1_.StrengthenLevel - 12);
               }
               else
               {
                  _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("wishBead.StrengthenLevel");
               }
            }
            else if(_loc1_.StrengthenLevel <= PathManager.solveStrengthMax())
            {
               _nameTxt.text = _nameTxt.text + ("(+" + (_info as InventoryItemInfo).StrengthenLevel + ")");
            }
            else if(_loc1_.StrengthenLevel > PathManager.solveStrengthMax())
            {
               _nameTxt.text = _nameTxt.text + LanguageMgr.GetTranslation("store.view.exalt.goodTips",_loc1_.StrengthenLevel - 12);
            }
         }
         var _loc3_:int = _nameTxt.text.indexOf("+");
         if(_loc3_ > 0)
         {
            _loc2_ = ComponentFactory.Instance.model.getSet("core.goodTip.ItemNameNumTxtFormat");
            _nameTxt.setTextFormat(_loc2_,_loc3_,_loc3_ + 1);
         }
         _nameTxt.textColor = QualityType.QUALITY_COLOR[_info.Quality];
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _nameTxt;
      }
      
      private function createQualityItem() : void
      {
         var _loc1_:FilterFrameText = _qualityItem.foreItems[0] as FilterFrameText;
         _loc1_.text = QualityType.QUALITY_STRING[_info.Quality];
         _loc1_.textColor = QualityType.QUALITY_COLOR[_info.Quality];
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _qualityItem;
      }
      
      private function createCategoryItem() : void
      {
         var _loc1_:FilterFrameText = _typeItem.foreItems[0] as FilterFrameText;
         var _loc2_:Array = EquipType.PARTNAME;
         _loc1_.text = !EquipType.PARTNAME[_info.CategoryID]?"":EquipType.PARTNAME[_info.CategoryID];
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _typeItem;
      }
      
      private function createMainProperty() : void
      {
         var _loc12_:* = NaN;
         var _loc10_:* = NaN;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:String = "";
         var _loc2_:String = "";
         var _loc6_:int = 0;
         var _loc1_:FilterFrameText = _mainPropertyItem.foreItems[0] as FilterFrameText;
         var _loc9_:ScaleFrameImage = _mainPropertyItem.backItem as ScaleFrameImage;
         var _loc14_:InventoryItemInfo = _info as InventoryItemInfo;
         GhostStarContainer(_mainPropertyItem.foreItems[1]).visible = false;
         GhostStarContainer(_armAngleItem.foreItems[1]).visible = false;
         _autoGhostWidth = 0;
         var _loc11_:uint = 0;
         var _loc3_:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         var _loc15_:GhostPropertyData = _loc14_ == null || _loc14_.Place > 30 || !EquipGhostManager.getInstance().isEquipGhosting()?null:EquipGhostManager.getInstance().getPorpertyData(_loc14_,PlayerInfoViewControl.currentPlayer);
         var _loc5_:GoodTipInfo = _tipData as GoodTipInfo;
         if(_loc5_ && EquipGhostManager.getInstance().isEquipGhosting())
         {
            if(_loc5_.ghostLv > 0 && _loc14_ && _loc14_.Place <= 30)
            {
               _loc15_ = EquipGhostManager.getInstance().getPropertyDataByLv(_loc14_,_loc5_.ghostLv);
            }
         }
         if(EquipType.isArm(_info))
         {
            _loc12_ = 0;
            if(_loc14_ && _loc14_.StrengthenLevel > 0)
            {
               _loc6_ = !!_loc14_.isGold?_loc14_.StrengthenLevel + 1:_loc14_.StrengthenLevel;
               _loc12_ = Number(StaticFormula.getHertAddition(int(_loc14_.Property7),_loc6_));
            }
            _loc9_.setFrame(1);
            _loc11_ = _loc12_ + (!!_loc15_?_loc15_.mainProperty:0);
            _loc13_ = _loc11_ > 0?"(+" + _loc11_ + ")":"";
            _loc1_.text = " " + _info.Property7.toString() + _loc13_;
            FilterFrameText(_armAngleItem.foreItems[0]).text = " " + _info.Property5 + "°~" + _info.Property6 + "°";
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _armAngleItem;
            if(_loc15_ != null)
            {
               _ghostStartsContainer = _armAngleItem.foreItems[1] as GhostStarContainer;
               _ghostStartsContainer.x = _armAngleItem.foreItems[0].width + _armAngleItem.foreItems[0].x;
               _ghostStartsContainer.y = _armAngleItem.foreItems[0].y + 8;
               _ghostStartsContainer.maxLv = EquipGhostManager.getInstance().model.topLvDic[_info.CategoryID];
               _ghostStartsContainer.level = _loc5_.ghostLv;
               _ghostStartsContainer.visible = true;
               _autoGhostWidth = _ghostStartsContainer.x + _ghostStartsContainer.width;
            }
         }
         else if(EquipType.isHead(_info) || EquipType.isCloth(_info))
         {
            _loc10_ = 0;
            if(_loc14_ && _loc14_.StrengthenLevel > 0)
            {
               _loc6_ = !!_loc14_.isGold?_loc14_.StrengthenLevel + 1:_loc14_.StrengthenLevel;
               _loc10_ = Number(StaticFormula.getDefenseAddition(int(_loc14_.Property7),_loc6_));
            }
            _loc9_.setFrame(2);
            _loc11_ = _loc10_ + (_loc15_ != null?_loc15_.mainProperty:0);
            _loc13_ = _loc11_ > 0?"(+" + _loc11_ + ")":"";
            _loc1_.text = " " + _info.Property7.toString() + _loc13_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
            if(_loc14_ && _loc14_.isGold)
            {
               FilterFrameText(_otherHp.foreItems[0]).text = _loc14_.Boold.toString();
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _otherHp;
            }
            if(_loc15_ != null)
            {
               _ghostStartsContainer = _mainPropertyItem.foreItems[1] as GhostStarContainer;
               _ghostStartsContainer.maxLv = EquipGhostManager.getInstance().model.topLvDic[_info.CategoryID];
               _ghostStartsContainer.x = _mainPropertyItem.foreItems[0].width + _mainPropertyItem.foreItems[0].x;
               _ghostStartsContainer.y = _mainPropertyItem.foreItems[0].y + 8;
               _ghostStartsContainer.level = _loc5_.ghostLv;
               _ghostStartsContainer.visible = true;
               _autoGhostWidth = _ghostStartsContainer.x + _ghostStartsContainer.width;
            }
         }
         else if(StaticFormula.isDeputyWeapon(_info) || _info.CategoryID == 31)
         {
            if(_info.Property3 == "32")
            {
               if(_loc14_ && _loc14_.StrengthenLevel > 0)
               {
                  _loc6_ = !!_loc14_.isGold?_loc14_.StrengthenLevel + 1:_loc14_.StrengthenLevel;
                  _loc2_ = "(+" + StaticFormula.getRecoverHPAddition(int(_loc14_.Property7),_loc6_) + ")";
               }
               _loc9_.setFrame(3);
            }
            else
            {
               if(_loc14_ && _loc14_.StrengthenLevel > 0)
               {
                  _loc6_ = !!_loc14_.isGold?_loc14_.StrengthenLevel + 1:_loc14_.StrengthenLevel;
                  _loc2_ = "(+" + StaticFormula.getDefenseAddition(int(_loc14_.Property7),_loc6_) + ")";
               }
               _loc9_.setFrame(4);
            }
            _loc1_.text = " " + _info.Property7.toString() + _loc2_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _mainPropertyItem;
         }
         if(_loc1_ && _loc1_.text != "")
         {
            _loc7_ = ComponentFactory.Instance.model.getSet("ddt.store.view.exalt.LaterEquipmentViewTextTF");
            _loc4_ = _loc1_.text.indexOf("(");
            _loc8_ = _loc1_.text.indexOf(")") + 1;
            if(_loc4_ > -1)
            {
               _loc1_.setTextFormat(_loc7_,_loc4_,_loc8_);
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
      
      private function setPurpleHtmlTxt(param1:String, param2:int, param3:String) : String
      {
         return LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.setPurpleHtmlTxt",param1,param2,param3);
      }
      
      private function createProperties() : void
      {
         var _loc2_:* = null;
         var _loc8_:String = "";
         var _loc12_:String = "";
         var _loc6_:String = "";
         var _loc11_:String = "";
         var _loc3_:String = "";
         var _loc10_:String = "";
         var _loc5_:String = "";
         var _loc9_:String = "";
         if(_info is InventoryItemInfo && !EquipType.isMagicStone(_info.CategoryID))
         {
            _loc2_ = _info as InventoryItemInfo;
            if(_loc2_.AttackCompose > 0)
            {
               _loc8_ = "(+" + String(_loc2_.AttackCompose) + ")";
            }
            if(_loc2_.DefendCompose > 0)
            {
               _loc12_ = "(+" + String(_loc2_.DefendCompose) + ")";
            }
            if(_loc2_.AgilityCompose > 0)
            {
               _loc6_ = "(+" + String(_loc2_.AgilityCompose) + ")";
            }
            if(_loc2_.LuckCompose > 0)
            {
               _loc11_ = "(+" + String(_loc2_.LuckCompose) + ")";
            }
         }
         var _loc1_:InventoryItemInfo = _info as InventoryItemInfo;
         var _loc4_:GhostPropertyData = _loc1_ == null || _loc1_.Place > 30 || !EquipGhostManager.getInstance().isEquipGhosting()?null:EquipGhostManager.getInstance().getPorpertyData(_loc1_,PlayerInfoViewControl.currentPlayer);
         var _loc7_:GoodTipInfo = _tipData as GoodTipInfo;
         if(_loc7_)
         {
            if(_loc7_.ghostLv > 0 && (_loc1_ != null && _loc1_.Place <= 30) && EquipGhostManager.getInstance().isEquipGhosting())
            {
               _loc4_ = EquipGhostManager.getInstance().getPropertyDataByLv(_loc1_,_loc7_.ghostLv);
            }
         }
         if(_loc4_ != null)
         {
            if(_loc4_.attack > 0)
            {
               _loc3_ = LanguageMgr.GetTranslation("equipGhost.tip",_loc4_.attack);
            }
            if(_loc4_.defend > 0)
            {
               _loc10_ = LanguageMgr.GetTranslation("equipGhost.tip",_loc4_.defend);
            }
            if(_loc4_.lucky > 0)
            {
               _loc9_ = LanguageMgr.GetTranslation("equipGhost.tip",_loc4_.lucky);
            }
            if(_loc4_.agility > 0)
            {
               _loc5_ = LanguageMgr.GetTranslation("equipGhost.tip",_loc4_.agility);
            }
         }
         if(_info.Attack != 0)
         {
            _attackTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.fire") + ":" + String(_info.Attack) + _loc8_) + _loc3_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _attackTxt;
         }
         if(_info.Defence != 0)
         {
            _defenseTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.recovery") + ":" + String(_info.Defence) + _loc12_) + _loc10_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _defenseTxt;
         }
         if(_info.Agility != 0)
         {
            _agilityTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.agility") + ":" + String(_info.Agility) + _loc6_) + _loc5_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _agilityTxt;
         }
         if(_info.Luck != 0)
         {
            _luckTxt.htmlText = LanguageMgr.GetTranslation("goodTip.propertyStr",LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.lucky") + ":" + String(_info.Luck) + _loc11_) + _loc9_;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _luckTxt;
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
         if(_info.NeedLevel > 1)
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
         if(_info.CanStrengthen && _info.CanCompose)
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
         else if(_info.CanCompose)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.compose");
            if(EquipType.isRongLing(_info))
            {
               _loc2_ = _loc2_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.melting");
            }
            _upgradeType.text = _loc2_;
            _upgradeType.textColor = 10092339;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _upgradeType;
         }
         else if(_info.CanStrengthen)
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
      
      private function createShopItemLimitGrade(param1:ShopItemInfo) : void
      {
         if(param1 && param1.LimitGrade > PlayerManager.Instance.Self.Grade)
         {
            _limitGradeTxt.text = LanguageMgr.GetTranslation("ddt.shop.LimitGradeBuy",param1.LimitGrade);
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _limitGradeTxt;
         }
      }
      
      private function ShowBound(param1:InventoryItemInfo) : Boolean
      {
         return param1.CategoryID != 32 && param1.CategoryID != 33 && param1.CategoryID != 36;
      }
      
      private function createBindType() : void
      {
         var _loc1_:InventoryItemInfo = _info as InventoryItemInfo;
         if(_loc1_ && ShowBound(_loc1_))
         {
            _boundImage.setFrame(!!_loc1_.IsBinds?1:uint(2));
            PositionUtils.setPos(_boundImage,_bindImageOriginalPos);
            addChild(_boundImage);
            if(!_loc1_.IsBinds)
            {
               if(_loc1_.BindType == 3)
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
               else
               {
                  _loc7_ = Math.floor(_loc4_ * 24);
                  _loc7_ = _loc7_ < 1?1:Number(_loc7_);
                  _remainTimeTxt.text = (!!_loc6_.IsUsed?_loc3_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc7_ + LanguageMgr.GetTranslation("hours");
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
         if(_remainTimeBg.parent)
         {
            _remainTimeBg.parent.removeChild(_remainTimeBg);
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
         if(_loc1_ && _loc1_.StrengthenLevel > 0)
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
      
      private function seperateLine() : void
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
