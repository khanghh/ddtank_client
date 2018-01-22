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
      
      public function initView(param1:int = 0) : void
      {
         buttonMode = true;
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("helperItem.BG");
         addChild(_itemBG);
         _fieldIndex = ComponentFactory.Instance.creatComponentByStylename("helperItem.fieldIndex");
         addChild(_fieldIndex);
         _state = param1;
         if(param1 != 0)
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
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
      
      private function initEvent() : void
      {
         _btnIsAuto.addEventListener("click",__isAutoClick);
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __cbxSeedChange(param1:ListItemEvent) : void
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
      
      private function __fertilizerChange(param1:ListItemEvent) : void
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
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _light.visible = _isSelected;
      }
      
      public function isSelelct(param1:Boolean) : void
      {
         if(_light)
         {
            _isSelected = param1;
            _light.visible = param1;
         }
      }
      
      public function getCellValue() : *
      {
         return _fieldVO;
      }
      
      public function set btnState(param1:Boolean) : void
      {
         this._btnState = param1;
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
      
      public function setCellValue(param1:*) : void
      {
         if(param1)
         {
            _fieldVO = param1;
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
      
      private function setDropListClickable(param1:Boolean) : void
      {
         _cbxSeed.enable = param1;
         _cbxFertilizer.enable = param1;
      }
      
      private function setSeedPanelData() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _seedInfos = new Dictionary();
         _cbxSeed.beginChanges();
         var _loc2_:VectorListModel = _cbxSeed.listPanel.vectorListModel;
         _loc2_.clear();
         _loc2_.append(_selectTipMsg);
         var _loc1_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc4_];
            _seedInfos[_loc3_.TemplateInfo.Name] = _loc3_.TemplateInfo.TemplateID;
            _loc2_.append(_loc3_.TemplateInfo.Name);
            _loc4_++;
         }
         _cbxSeed.commitChanges();
      }
      
      private function setFertilizerPanelData() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _fertilizerInfos = new Dictionary();
         _cbxFertilizer.beginChanges();
         var _loc2_:VectorListModel = _cbxFertilizer.listPanel.vectorListModel;
         _loc2_.clear();
         _loc2_.append(_selectTipMsg);
         var _loc1_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc4_];
            _fertilizerInfos[_loc3_.TemplateInfo.Name] = _loc3_.TemplateInfo.TemplateID;
            _loc2_.append(_loc3_.TemplateInfo.Name);
            _loc4_++;
         }
         _cbxFertilizer.commitChanges();
      }
      
      private function __seedCheck() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Boolean = true;
         if(_seedInfos.hasOwnProperty(_SeedTxt.text))
         {
            _loc2_ = _seedInfos[_SeedTxt.text];
            _loc3_ = PlayerManager.Instance.Self.getBag(13).findItems(32);
            var _loc6_:int = 0;
            var _loc5_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               if(_loc4_.TemplateID == _loc2_)
               {
                  if(_loc4_.Count > 0)
                  {
                     _loc1_ = true;
                  }
                  break;
               }
            }
         }
         return _loc1_;
      }
      
      public function set findNumState(param1:Function) : void
      {
         _findNumState = param1;
      }
      
      private function __seedItemClickCheck() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Boolean = false;
         if(_seedInfos.hasOwnProperty(_SeedTxt.text))
         {
            _loc2_ = _seedInfos[_SeedTxt.text];
            _loc3_ = PlayerManager.Instance.Self.getBag(13).findItems(32);
            var _loc6_:int = 0;
            var _loc5_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               if(_loc4_.TemplateID == _loc2_)
               {
                  if(_loc4_.Count > 0)
                  {
                     _loc1_ = true;
                  }
                  break;
               }
            }
            if(!_loc1_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.selectSeedFail"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.pleaseSelectSeed"));
         }
         return _loc1_;
      }
      
      private function __fertilizerItemClickCheck() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Boolean = false;
         if(_fertilizerInfos.hasOwnProperty(_cbxFertilizer.textField.text))
         {
            _loc2_ = _fertilizerInfos[_cbxFertilizer.textField.text];
            _loc3_ = PlayerManager.Instance.Self.getBag(13).findItems(33);
            var _loc6_:int = 0;
            var _loc5_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               if(_loc4_.TemplateID == _loc2_)
               {
                  if(_loc4_.Count > 0)
                  {
                     _loc1_ = true;
                  }
                  break;
               }
            }
            if(!_loc1_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.selectFertilizerFail"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.pleaseSelectSeedI"));
         }
         return _loc1_;
      }
      
      private function __isAutoClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helperSetView = ComponentFactory.Instance.creatComponentByStylename("farm.helperSetView.helper");
         _helperSetView.helperSetViewSelectResult = __helperSetViewSelect;
         _helperSetView.update(_SeedTxt,_SeedNumTxt,_FertilizerTxt,_FertilizerNumTxt);
         _helperSetView.findNumState = _findNumState;
         _helperSetView.show();
      }
      
      private function __helperSetViewSelect(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(param1.isSeed)
         {
            _loc2_ = param1.seedId;
            _loc5_ = param1.seedNum;
            _loc6_ = ItemManager.Instance.getTemplateById(_loc2_);
            _SeedTxt.text = _loc6_.Name;
            _SeedNumTxt.text = _loc5_.toString();
         }
         else
         {
            _SeedTxt.text = _selectTipMsg;
            _SeedNumTxt.text = "0";
         }
         if(param1.isManure)
         {
            _loc7_ = param1.manureId;
            _loc3_ = param1.manureNum;
            _loc4_ = ItemManager.Instance.getTemplateById(_loc7_);
            _FertilizerTxt.text = _loc4_.Name;
            _FertilizerNumTxt.text = _loc3_.toString();
         }
         else
         {
            _FertilizerTxt.text = _selectTipMsg;
            _FertilizerNumTxt.text = "0";
         }
      }
      
      public function get getSetViewItemData() : Object
      {
         var _loc1_:* = null;
         if(_helperSetView)
         {
            _loc1_ = {};
            _loc1_.currentSeedText = _helperSetView.getTxtId1;
            _loc1_.currentSeedNum = _helperSetView.getTxtNum1;
            _loc1_.currentFertilizerText = _helperSetView.getTxtId2;
            _loc1_.currentFertilizerNum = _helperSetView.getTxtNum2;
         }
         return _loc1_;
      }
      
      public function get getItemData() : Object
      {
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         _loc7_ = 0;
         while(_loc7_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc7_];
            _seedInfos[_loc3_.TemplateInfo.Name] = _loc3_.TemplateInfo.TemplateID;
            _loc7_++;
         }
         var _loc5_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc2_ = _loc5_[_loc6_];
            _fertilizerInfos[_loc2_.TemplateInfo.Name] = _loc2_.TemplateInfo.TemplateID;
            _loc6_++;
         }
         var _loc4_:Object = {};
         _loc4_.currentfindIndex = currentfindIndex;
         if(currentSeed == _selectTipMsg)
         {
            _loc4_.currentSeedText = 0;
         }
         else
         {
            _loc4_.currentSeedText = _seedInfos[currentSeed];
         }
         if(currentFertilizer == _selectTipMsg)
         {
            _loc4_.currentFertilizerText = 0;
         }
         else
         {
            _loc4_.currentFertilizerText = _fertilizerInfos[currentFertilizer];
         }
         _loc4_.currentSeedNum = currentSeedNum;
         _loc4_.autoFertilizerNum = currentFertilizerNum;
         return _loc4_;
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
         var _loc2_:int = int(_fieldIndex.text) - 1;
         var _loc1_:int = 0;
         if(_SeedTxt.text != _selectTipMsg && _seedInfos.hasOwnProperty(_SeedTxt.text))
         {
            _loc1_ = _seedInfos[_SeedTxt.text];
         }
         var _loc3_:int = 0;
         if(_fertilizerInfos.hasOwnProperty(_FertilizerTxt.text))
         {
            _loc3_ = _fertilizerInfos[_FertilizerTxt.text];
         }
         if(_loc1_ > 0)
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
         var _loc2_:int = int(_fieldIndex.text) - 1;
         var _loc1_:int = 0;
         if(_seedInfos.hasOwnProperty(_SeedTxt.text))
         {
            _loc1_ = _seedInfos[_SeedTxt.text];
         }
         var _loc3_:int = 0;
         if(_fertilizerInfos.hasOwnProperty(_FertilizerTxt.text))
         {
            _loc3_ = _fertilizerInfos[_FertilizerTxt.text];
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
