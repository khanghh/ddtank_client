package beadSystem.views
{
   import beadSystem.model.BeadInfo;
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
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.PositionUtils;
   import ddt.view.SimpleItem;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import road7th.utils.StringHelper;
   
   public class BeadUpgradeTipView extends Component
   {
       
      
      private var _strengthenLevelImage:MovieImage;
      
      private var _fusionLevelImage:MovieImage;
      
      private var _boundImage:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _qualityItem:SimpleItem;
      
      private var _typeItem:SimpleItem;
      
      private var _expItem:SimpleItem;
      
      private var _descriptionTxt:FilterFrameText;
      
      private var _bindTypeTxt:FilterFrameText;
      
      private var _remainTimeTxt:FilterFrameText;
      
      private var _info:ItemTemplateInfo;
      
      private var _bindImageOriginalPos:Point;
      
      private var _maxWidth:int;
      
      private var _minWidth:int = 240;
      
      private var _displayList:Vector.<DisplayObject>;
      
      private var _displayIdx:int;
      
      private var _lines:Vector.<Image>;
      
      private var _lineIdx:int;
      
      private var _isReAdd:Boolean;
      
      private var _remainTimeBg:Bitmap;
      
      private var _tipbackgound:MutipleImage;
      
      private var _rightArrows:Bitmap;
      
      private var _exp:int;
      
      private var _UpExp:int;
      
      public function BeadUpgradeTipView()
      {
         super();
      }
      
      override protected function init() : void
      {
         _lines = new Vector.<Image>();
         _displayList = new Vector.<DisplayObject>();
         _rightArrows = ComponentFactory.Instance.creatBitmap("asset.ddtstore.rightArrows");
         _tipbackgound = ComponentFactory.Instance.creat("ddtstore.strengthTips.strengthenImageBG");
         _strengthenLevelImage = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameMc");
         _fusionLevelImage = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTrinketLevelMc");
         _boundImage = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.BoundImage");
         _bindImageOriginalPos = new Point(_boundImage.x,_boundImage.y);
         _expItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.EXPItem");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemNameTxt");
         _qualityItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.QualityItem");
         _typeItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.TypeItem");
         _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.DescriptionTxt");
         _bindTypeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemTxt");
         _remainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemDateTxt");
         _remainTimeBg = ComponentFactory.Instance.creatBitmap("asset.core.tip.restTime");
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
         createItemName();
         createCategoryItem();
         careteEXP();
         seperateLine();
         createDescript();
         createBindType();
         createRemainTime();
         addChildren();
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
            if(_lines.indexOf(_loc1_ as Image) < 0 && _loc1_ != _descriptionTxt)
            {
               _loc5_ = Math.max(_loc1_.width,_loc5_);
            }
            PositionUtils.setPos(_loc1_,_loc6_);
            addChild(_loc1_);
            _loc6_.y = _loc1_.y + _loc1_.height + _loc3_;
            _loc4_++;
         }
         _maxWidth = Math.max(_minWidth,_loc5_);
         _maxWidth = _maxWidth - 20;
         if(_descriptionTxt.width != _maxWidth)
         {
            _descriptionTxt.width = _maxWidth;
            _descriptionTxt.height = _descriptionTxt.textHeight + 10;
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
            var _loc7_:* = _maxWidth + 35;
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
         _rightArrows.x = 5 - _rightArrows.width;
         _rightArrows.y = (this.height - _rightArrows.height) / 2;
      }
      
      private function createItemName() : void
      {
         _nameTxt.text = _tipData.beadName;
         _nameTxt.textColor = QualityType.QUALITY_COLOR[_info.Quality];
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _nameTxt;
      }
      
      private function careteEXP() : void
      {
         var _loc1_:FilterFrameText = _expItem.foreItems[0] as FilterFrameText;
         if(EquipType.isBead(int(_info.Property1)))
         {
            _exp = ServerConfigManager.instance.getBeadUpgradeExp()[(_info as InventoryItemInfo).Hole1];
            _UpExp = ServerConfigManager.instance.getBeadUpgradeExp()[(_info as InventoryItemInfo).Hole1 + 1];
            _loc1_.text = _exp + "/" + _UpExp;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _expItem;
         }
      }
      
      private function createCategoryItem() : void
      {
         var _loc1_:FilterFrameText = _typeItem.foreItems[0] as FilterFrameText;
         var _loc2_:* = _info.Property2;
         if("1" !== _loc2_)
         {
            if("2" !== _loc2_)
            {
               if("3" === _loc2_)
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
         _loc1_.textColor = 65406;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _typeItem;
      }
      
      private function setPurpleHtmlTxt(param1:String, param2:int, param3:String) : String
      {
         return LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.setPurpleHtmlTxt",param1,param2,param3);
      }
      
      private function createDescript() : void
      {
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_info.TemplateID);
         if(_info.Description == "")
         {
            return;
         }
         _info.Description = _loc2_.Description;
         var _loc1_:InventoryItemInfo = _info as InventoryItemInfo;
         var _loc3_:BeadInfo = BeadTemplateManager.Instance.GetBeadInfobyID(_info.TemplateID);
         if(_loc3_.Attribute1 == "0" && _loc3_.Attribute2 == "0")
         {
            _descriptionTxt.text = StringHelper.format(_info.Description);
         }
         else if(_loc3_.Attribute1 == "0" && _loc3_.Attribute2 != "0")
         {
            if(_loc3_.Att2.length > 1)
            {
               if(_loc1_ && _loc1_.Hole1 > _loc3_.BaseLevel)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att2[1]);
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att2[0]);
               }
            }
            else
            {
               _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Attribute2);
            }
         }
         else if(_loc3_.Attribute1 != "0" && _loc3_.Attribute2 == "0")
         {
            if(_loc3_.Att1.length > 1)
            {
               if(_loc1_ && _loc1_.Hole1 > _loc3_.BaseLevel)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[1]);
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[0]);
               }
            }
            else
            {
               _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Attribute1);
            }
         }
         else if(_loc3_.Attribute1 != "0" && _loc3_.Attribute2 != "0" && _loc3_.Attribute3 == "0")
         {
            if(_loc3_.Att1.length > 1 && _loc3_.Att2.length == 1)
            {
               if(_loc1_ && _loc1_.Hole1 > _loc3_.BaseLevel)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[1],_loc3_.Attribute2);
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[0],_loc3_.Attribute2);
               }
            }
            else if(_loc3_.Att1.length == 1 && _loc3_.Att2.length > 1)
            {
               if(_loc1_ && _loc1_.Hole1 > _loc3_.BaseLevel)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Attribute1,_loc3_.Att2[1]);
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Attribute1,_loc3_.Att2[0]);
               }
            }
            else if(_loc1_ && _loc1_.Hole1 > _loc3_.BaseLevel)
            {
               _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[1],_loc3_.Att2[1]);
            }
            else
            {
               _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[0],_loc3_.Att2[0]);
            }
         }
         else if(_loc3_.Attribute1 != "0" && _loc3_.Attribute2 != "0" && _loc3_.Attribute3 != "0")
         {
            if(_loc3_.Att1.length != 1)
            {
               if(_loc1_ && _loc1_.Hole1 > _loc3_.BaseLevel)
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[1],_loc3_.Att2[1],_loc3_.Att3[1]);
               }
               else
               {
                  _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[0],_loc3_.Att2[0],_loc3_.Att3[0]);
               }
            }
            else
            {
               _descriptionTxt.text = StringHelper.format(_info.Description,_loc3_.Att1[0],_loc3_.Att2[0],_loc3_.Att3[0]);
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
         var _loc4_:Number = NaN;
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:* = null;
         var _loc6_:* = NaN;
         if(_remainTimeBg.parent)
         {
            _remainTimeBg.parent.removeChild(_remainTimeBg);
         }
         if(_info is InventoryItemInfo)
         {
            _loc3_ = _info as InventoryItemInfo;
            _loc2_ = _loc3_.getRemainDate();
            _loc5_ = _loc3_.getColorValidDate();
            _loc1_ = _loc3_.CategoryID == 7?LanguageMgr.GetTranslation("bag.changeColor.tips.armName"):"";
            if(_loc5_ > 0 && _loc5_ != 2147483647)
            {
               if(_loc5_ >= 1)
               {
                  _remainTimeTxt.text = (!!_loc3_.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + Math.ceil(_loc5_) + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               else
               {
                  _loc6_ = Number(Math.floor(_loc5_ * 24));
                  if(_loc6_ < 1)
                  {
                     _loc6_ = 1;
                  }
                  _remainTimeTxt.text = (!!_loc3_.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc6_ + LanguageMgr.GetTranslation("hours");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
            }
            if(_loc2_ == 2147483647)
            {
               _remainTimeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
               _remainTimeTxt.textColor = 16776960;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _remainTimeTxt;
            }
            else if(_loc2_ > 0)
            {
               if(_loc2_ >= 1)
               {
                  _loc4_ = Math.ceil(_loc2_);
                  _remainTimeTxt.text = (!!_loc3_.IsUsed?_loc1_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc4_ + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               else
               {
                  _loc4_ = Math.floor(_loc2_ * 24);
                  _loc4_ = _loc4_ < 1?1:Number(_loc4_);
                  _remainTimeTxt.text = (!!_loc3_.IsUsed?_loc1_ + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc4_ + LanguageMgr.GetTranslation("hours");
                  _remainTimeTxt.textColor = 16777215;
                  _displayIdx = Number(_displayIdx) + 1;
                  _displayList[Number(_displayIdx)] = _remainTimeTxt;
               }
               addChild(_remainTimeBg);
            }
            else if(!isNaN(_loc2_))
            {
               _remainTimeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.over");
               _remainTimeTxt.textColor = 16711680;
               _displayIdx = Number(_displayIdx) + 1;
               _displayList[Number(_displayIdx)] = _remainTimeTxt;
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
