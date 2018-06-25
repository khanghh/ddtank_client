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
      
      override public function set tipData(data:Object) : void
      {
         if(data)
         {
            if(data is GoodTipInfo)
            {
               _tipData = data as GoodTipInfo;
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
      
      public function showTip(info:ItemTemplateInfo, typeIsSecond:Boolean = false) : void
      {
         _displayIdx = 0;
         _displayList = new Vector.<DisplayObject>();
         _lineIdx = 0;
         _isReAdd = false;
         _maxWidth = 0;
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
            if(_lines.indexOf(item as Image) < 0 && item != _descriptionTxt)
            {
               tempMaxWidth = Math.max(item.width,tempMaxWidth);
            }
            PositionUtils.setPos(item,pos);
            addChild(item);
            pos.y = item.y + item.height + offset;
            i++;
         }
         _maxWidth = Math.max(_minWidth,tempMaxWidth);
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
            var _loc7_:* = _maxWidth + 35;
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
         var fft:FilterFrameText = _expItem.foreItems[0] as FilterFrameText;
         if(EquipType.isBead(int(_info.Property1)))
         {
            _exp = ServerConfigManager.instance.getBeadUpgradeExp()[(_info as InventoryItemInfo).Hole1];
            _UpExp = ServerConfigManager.instance.getBeadUpgradeExp()[(_info as InventoryItemInfo).Hole1 + 1];
            fft.text = _exp + "/" + _UpExp;
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _expItem;
         }
      }
      
      private function createCategoryItem() : void
      {
         var fft:FilterFrameText = _typeItem.foreItems[0] as FilterFrameText;
         var _loc2_:* = _info.Property2;
         if("1" !== _loc2_)
         {
            if("2" !== _loc2_)
            {
               if("3" === _loc2_)
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
         fft.textColor = 65406;
         _displayIdx = Number(_displayIdx) + 1;
         _displayList[Number(_displayIdx)] = _typeItem;
      }
      
      private function setPurpleHtmlTxt(title:String, value:int, add:String) : String
      {
         return LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.setPurpleHtmlTxt",title,value,add);
      }
      
      private function createDescript() : void
      {
         var infoTemplate:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_info.TemplateID);
         if(_info.Description == "")
         {
            return;
         }
         _info.Description = infoTemplate.Description;
         var infoItem:InventoryItemInfo = _info as InventoryItemInfo;
         var beadInfo:BeadInfo = BeadTemplateManager.Instance.GetBeadInfobyID(_info.TemplateID);
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
                  _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att2[1]);
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
               _descriptionTxt.text = StringHelper.format(_info.Description,beadInfo.Att1[1],beadInfo.Att2[1]);
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
