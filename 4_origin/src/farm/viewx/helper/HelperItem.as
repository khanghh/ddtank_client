package farm.viewx.helper
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.modelx.FieldVO;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class HelperItem extends Sprite
   {
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _fieldVO:FieldVO;
      
      private var _fieldIndex:FilterFrameText;
      
      private var _SeedTxt:FilterFrameText;
      
      private var _SeedNumTxt:FilterFrameText;
      
      private var _FertilizerTxt:FilterFrameText;
      
      private var _FertilizerNumTxt:FilterFrameText;
      
      private var _cbxSeed:ComboBox;
      
      private var _cbxFertilizer:ComboBox;
      
      private var _btnIsAuto:BaseButton;
      
      private var _light:Scale9CornerImage;
      
      private var _seedInfos:Dictionary;
      
      private var _fertilizerInfos:Dictionary;
      
      private var _txtIsAutoArray:Array;
      
      private var _selectTipMsg:String;
      
      public var _isAutoFunction:Function;
      
      private var _btnState:Boolean;
      
      private var _currentFrame:int;
      
      private var _index:int;
      
      private var _isSelected:Boolean;
      
      private var _state:int;
      
      private var _findNumState:Function;
      
      private var _helperSetView:HelperSetView;
      
      public function HelperItem()
      {
         super();
      }
      
      public function initView(state:int = 0) : void
      {
         buttonMode = true;
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("helperItem.BG");
         addChild(_itemBG);
         _fieldIndex = ComponentFactory.Instance.creatComponentByStylename("helperItem.fieldIndex");
         addChild(_fieldIndex);
         _state = state;
         if(state != 0)
         {
            _cbxSeed = ComponentFactory.Instance.creat("asset.ddtfarm.helper.seedDropListCombo");
            _cbxFertilizer = ComponentFactory.Instance.creat("asset.ddtfarm.helper.filterFrameDropListCombo");
            _SeedTxt = ComponentFactory.Instance.creatComponentByStylename("farm.helper.SeedTxt");
            addChild(_SeedTxt);
            _SeedTxt.text = LanguageMgr.GetTranslation("ddt.fram.helperItem.Text");
            _SeedNumTxt = ComponentFactory.Instance.creatComponentByStylename("farm.helper.SeedNumTxt");
            addChild(_SeedNumTxt);
            _FertilizerTxt = ComponentFactory.Instance.creatComponentByStylename("farm.helper.SeedTxt");
            addChild(_FertilizerTxt);
            _FertilizerTxt.text = LanguageMgr.GetTranslation("ddt.fram.helperItem.Text");
            PositionUtils.setPos(_FertilizerTxt,"farm.helper.SeedTxtPos");
            _FertilizerNumTxt = ComponentFactory.Instance.creatComponentByStylename("farm.helper.SeedNumTxt");
            addChild(_FertilizerNumTxt);
            PositionUtils.setPos(_FertilizerNumTxt,"farm.helper.SeedTxtNumPos");
            _btnIsAuto = ComponentFactory.Instance.creatComponentByStylename("helperItem.isAutoBtn");
            addChild(_btnIsAuto);
            _light = ComponentFactory.Instance.creatComponentByStylename("farm.helperListItem.light");
            addChild(_light);
            var _loc2_:* = false;
            _light.visible = _loc2_;
            _loc2_ = _loc2_;
            _light.mouseEnabled = _loc2_;
            _light.mouseChildren = _loc2_;
            _txtIsAutoArray = [LanguageMgr.GetTranslation("ddt.farm.helperList.txtStart"),LanguageMgr.GetTranslation("ddt.farm.helperList.txtStop")];
            _selectTipMsg = LanguageMgr.GetTranslation("ddt.fram.helperItem.Text");
            setSeedPanelData();
            setFertilizerPanelData();
            initEvent();
         }
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
      }
      
      private function initEvent() : void
      {
         _btnIsAuto.addEventListener("click",__isAutoClick);
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __cbxSeedChange(evt:ListItemEvent) : void
      {
         if(_cbxSeed.textField.text == _selectTipMsg)
         {
            return;
         }
         if(!__seedItemClickCheck())
         {
            _cbxSeed.textField.text = _selectTipMsg;
         }
      }
      
      private function __fertilizerChange(evt:ListItemEvent) : void
      {
         if(_cbxFertilizer.textField.text == _selectTipMsg)
         {
            return;
         }
         if(!__fertilizerItemClickCheck())
         {
            _cbxFertilizer.textField.text = _selectTipMsg;
         }
      }
      
      private function __mouseOverHandler(evt:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function __mouseOutHandler(evt:MouseEvent) : void
      {
         _light.visible = _isSelected;
      }
      
      public function isSelelct(b:Boolean) : void
      {
         if(_light)
         {
            _isSelected = b;
            _light.visible = b;
         }
      }
      
      public function getCellValue() : *
      {
         return _fieldVO;
      }
      
      public function set btnState(value:Boolean) : void
      {
         this._btnState = value;
      }
      
      public function get btnState() : Boolean
      {
         return this._btnState;
      }
      
      public function get currentFertilizer() : String
      {
         return _FertilizerTxt.text;
      }
      
      public function get currentFertilizerNum() : int
      {
         return int(_FertilizerNumTxt.text);
      }
      
      public function get currentSeed() : String
      {
         return _SeedTxt.text;
      }
      
      public function get currentSeedNum() : int
      {
         return int(_SeedNumTxt.text);
      }
      
      public function get currentfindIndex() : int
      {
         return int(_fieldIndex.text) - 1;
      }
      
      public function get currentFieldID() : int
      {
         return _fieldVO.fieldID;
      }
      
      public function setCellValue(value:*) : void
      {
         if(value)
         {
            _fieldVO = value;
            _fieldIndex.text = String(_fieldVO.fieldID + 1);
            if(_SeedTxt && _FertilizerTxt)
            {
               if(_fieldVO.autoSeedID == 0)
               {
                  _SeedTxt.text = _selectTipMsg;
                  _SeedNumTxt.text = _fieldVO.autoSeedIDCount.toString();
               }
               else
               {
                  _SeedTxt.text = ItemManager.Instance.getTemplateById(_fieldVO.autoSeedID).Name;
                  _SeedNumTxt.text = _fieldVO.autoSeedIDCount.toString();
               }
               if(_fieldVO.autoFertilizerID == 0)
               {
                  _FertilizerTxt.text = _selectTipMsg;
                  _FertilizerNumTxt.text = _fieldVO.autoFertilizerCount.toString();
               }
               else
               {
                  _FertilizerTxt.text = ItemManager.Instance.getTemplateById(_fieldVO.autoFertilizerID).Name;
                  _FertilizerNumTxt.text = _fieldVO.autoFertilizerCount.toString();
               }
               btnState = !_fieldVO.isAutomatic;
               if(_fieldVO.isAutomatic)
               {
                  _currentFrame = 2;
                  _btnIsAuto.enable = false;
                  _itemBG.filters = ComponentFactory.Instance.creatFilters("grayFilter");
                  _itemBG.setFrame(1);
               }
               else
               {
                  _currentFrame = 1;
                  _btnIsAuto.enable = true;
                  _itemBG.filters = ComponentFactory.Instance.creatFilters("lightFilter");
                  _itemBG.setFrame(1);
               }
            }
         }
      }
      
      private function setDropListClickable(pIsClickable:Boolean) : void
      {
         _cbxSeed.enable = pIsClickable;
         _cbxFertilizer.enable = pIsClickable;
      }
      
      private function setSeedPanelData() : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         _seedInfos = new Dictionary();
         _cbxSeed.beginChanges();
         var listModel:VectorListModel = _cbxSeed.listPanel.vectorListModel;
         listModel.clear();
         listModel.append(_selectTipMsg);
         var arr:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         for(i = 0; i < arr.length; )
         {
            itemInfo = arr[i];
            _seedInfos[itemInfo.TemplateInfo.Name] = itemInfo.TemplateInfo.TemplateID;
            listModel.append(itemInfo.TemplateInfo.Name);
            i++;
         }
         _cbxSeed.commitChanges();
      }
      
      private function setFertilizerPanelData() : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         _fertilizerInfos = new Dictionary();
         _cbxFertilizer.beginChanges();
         var listModel:VectorListModel = _cbxFertilizer.listPanel.vectorListModel;
         listModel.clear();
         listModel.append(_selectTipMsg);
         var arr:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         for(i = 0; i < arr.length; )
         {
            itemInfo = arr[i];
            _fertilizerInfos[itemInfo.TemplateInfo.Name] = itemInfo.TemplateInfo.TemplateID;
            listModel.append(itemInfo.TemplateInfo.Name);
            i++;
         }
         _cbxFertilizer.commitChanges();
      }
      
      private function __seedCheck() : Boolean
      {
         var templateID:int = 0;
         var arr:* = null;
         var ret:Boolean = true;
         if(_seedInfos.hasOwnProperty(_SeedTxt.text))
         {
            templateID = _seedInfos[_SeedTxt.text];
            arr = PlayerManager.Instance.Self.getBag(13).findItems(32);
            var _loc6_:int = 0;
            var _loc5_:* = arr;
            for each(var item in arr)
            {
               if(item.TemplateID == templateID)
               {
                  if(item.Count > 0)
                  {
                     ret = true;
                  }
                  break;
               }
            }
         }
         return ret;
      }
      
      public function set findNumState(value:Function) : void
      {
         _findNumState = value;
      }
      
      private function __seedItemClickCheck() : Boolean
      {
         var templateID:int = 0;
         var arr:* = null;
         var ret:Boolean = false;
         if(_seedInfos.hasOwnProperty(_SeedTxt.text))
         {
            templateID = _seedInfos[_SeedTxt.text];
            arr = PlayerManager.Instance.Self.getBag(13).findItems(32);
            var _loc6_:int = 0;
            var _loc5_:* = arr;
            for each(var item in arr)
            {
               if(item.TemplateID == templateID)
               {
                  if(item.Count > 0)
                  {
                     ret = true;
                  }
                  break;
               }
            }
            if(!ret)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.selectSeedFail"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.pleaseSelectSeed"));
         }
         return ret;
      }
      
      private function __fertilizerItemClickCheck() : Boolean
      {
         var templateID:int = 0;
         var arr:* = null;
         var ret:Boolean = false;
         if(_fertilizerInfos.hasOwnProperty(_cbxFertilizer.textField.text))
         {
            templateID = _fertilizerInfos[_cbxFertilizer.textField.text];
            arr = PlayerManager.Instance.Self.getBag(13).findItems(33);
            var _loc6_:int = 0;
            var _loc5_:* = arr;
            for each(var item in arr)
            {
               if(item.TemplateID == templateID)
               {
                  if(item.Count > 0)
                  {
                     ret = true;
                  }
                  break;
               }
            }
            if(!ret)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.selectFertilizerFail"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.pleaseSelectSeedI"));
         }
         return ret;
      }
      
      private function __isAutoClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helperSetView = ComponentFactory.Instance.creatComponentByStylename("farm.helperSetView.helper");
         _helperSetView.helperSetViewSelectResult = __helperSetViewSelect;
         _helperSetView.update(_SeedTxt,_SeedNumTxt,_FertilizerTxt,_FertilizerNumTxt);
         _helperSetView.findNumState = _findNumState;
         _helperSetView.show();
      }
      
      private function __helperSetViewSelect(info:Object) : void
      {
         var _seedId:int = 0;
         var _seedNum:int = 0;
         var setInfo:* = null;
         var _manureId:int = 0;
         var _manureNum:int = 0;
         var ferInof:* = null;
         if(info.isSeed)
         {
            _seedId = info.seedId;
            _seedNum = info.seedNum;
            setInfo = ItemManager.Instance.getTemplateById(_seedId);
            _SeedTxt.text = setInfo.Name;
            _SeedNumTxt.text = _seedNum.toString();
         }
         else
         {
            _SeedTxt.text = _selectTipMsg;
            _SeedNumTxt.text = "0";
         }
         if(info.isManure)
         {
            _manureId = info.manureId;
            _manureNum = info.manureNum;
            ferInof = ItemManager.Instance.getTemplateById(_manureId);
            _FertilizerTxt.text = ferInof.Name;
            _FertilizerNumTxt.text = _manureNum.toString();
         }
         else
         {
            _FertilizerTxt.text = _selectTipMsg;
            _FertilizerNumTxt.text = "0";
         }
      }
      
      public function get getSetViewItemData() : Object
      {
         var obj:* = null;
         if(_helperSetView)
         {
            obj = {};
            obj.currentSeedText = _helperSetView.getTxtId1;
            obj.currentSeedNum = _helperSetView.getTxtNum1;
            obj.currentFertilizerText = _helperSetView.getTxtId2;
            obj.currentFertilizerNum = _helperSetView.getTxtNum2;
         }
         return obj;
      }
      
      public function get getItemData() : Object
      {
         var i:int = 0;
         var itemInfo:* = null;
         var k:int = 0;
         var itemInfo1:* = null;
         var arr:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         for(i = 0; i < arr.length; )
         {
            itemInfo = arr[i];
            _seedInfos[itemInfo.TemplateInfo.Name] = itemInfo.TemplateInfo.TemplateID;
            i++;
         }
         var arr1:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         for(k = 0; k < arr1.length; )
         {
            itemInfo1 = arr1[k];
            _fertilizerInfos[itemInfo1.TemplateInfo.Name] = itemInfo1.TemplateInfo.TemplateID;
            k++;
         }
         var obj:Object = {};
         obj.currentfindIndex = currentfindIndex;
         if(currentSeed == _selectTipMsg)
         {
            obj.currentSeedText = 0;
         }
         else
         {
            obj.currentSeedText = _seedInfos[currentSeed];
         }
         if(currentFertilizer == _selectTipMsg)
         {
            obj.currentFertilizerText = 0;
         }
         else
         {
            obj.currentFertilizerText = _fertilizerInfos[currentFertilizer];
         }
         obj.currentSeedNum = currentSeedNum;
         obj.autoFertilizerNum = currentFertilizerNum;
         return obj;
      }
      
      public function onKeyStart() : Boolean
      {
         if(!_fieldVO.isDig)
         {
            return false;
         }
         if(_state == 0 || !btnState || !__seedCheck())
         {
            return false;
         }
         var fieldIndex:int = int(_fieldIndex.text) - 1;
         var autoSeedID:int = 0;
         if(_SeedTxt.text != _selectTipMsg && _seedInfos.hasOwnProperty(_SeedTxt.text))
         {
            autoSeedID = _seedInfos[_SeedTxt.text];
         }
         var autoFertilizerID:int = 0;
         if(_fertilizerInfos.hasOwnProperty(_FertilizerTxt.text))
         {
            autoFertilizerID = _fertilizerInfos[_FertilizerTxt.text];
         }
         if(autoSeedID > 0)
         {
            return true;
         }
         return true;
      }
      
      public function onKeyStop() : Boolean
      {
         if(!_fieldVO.isDig)
         {
            return false;
         }
         if(_state == 0 || btnState)
         {
            return false;
         }
         var fieldIndex:int = int(_fieldIndex.text) - 1;
         var autoSeedID:int = 0;
         if(_seedInfos.hasOwnProperty(_SeedTxt.text))
         {
            autoSeedID = _seedInfos[_SeedTxt.text];
         }
         var autoFertilizerID:int = 0;
         if(_fertilizerInfos.hasOwnProperty(_FertilizerTxt.text))
         {
            autoFertilizerID = _fertilizerInfos[_FertilizerTxt.text];
         }
         return true;
      }
      
      private function removeEvent() : void
      {
         if(_btnIsAuto)
         {
            _btnIsAuto.removeEventListener("click",__isAutoClick);
         }
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
         if(_cbxSeed)
         {
            _cbxSeed.listPanel.list.removeEventListener("listItemClick",__cbxSeedChange);
         }
         if(_cbxFertilizer)
         {
            _cbxFertilizer.listPanel.list.removeEventListener("listItemClick",__fertilizerChange);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_itemBG)
         {
            ObjectUtils.disposeObject(_itemBG);
         }
         _itemBG = null;
         if(_fieldIndex)
         {
            ObjectUtils.disposeObject(_fieldIndex);
         }
         _fieldIndex = null;
         if(_cbxSeed)
         {
            _cbxSeed.dispose();
         }
         _cbxSeed = null;
         if(_cbxFertilizer)
         {
            _cbxFertilizer.dispose();
         }
         _cbxFertilizer = null;
         if(_btnIsAuto)
         {
            ObjectUtils.disposeObject(_btnIsAuto);
         }
         _btnIsAuto = null;
         ObjectUtils.disposeAllChildren(this);
         _findNumState = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
