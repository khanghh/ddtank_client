package farm.viewx.helper
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ShopManager;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class HelperList extends Sprite implements Disposeable
   {
       
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _helperListBG:MovieClip;
      
      private var _helperListVLine:MutipleImage;
      
      private var _fieldIndex:BaseButton;
      
      private var _seedID:BaseButton;
      
      private var _fertilizerID:BaseButton;
      
      private var _isAuto:BaseButton;
      
      private var _fieldIndexText:FilterFrameText;
      
      private var _seedIDText:FilterFrameText;
      
      private var _fertilizerIDText:FilterFrameText;
      
      private var _isAutoText:FilterFrameText;
      
      private var _seedInfos:Dictionary;
      
      private var _fertilizerInfos:Dictionary;
      
      private var _helperItemList:Array;
      
      private var _currentSelectHelperItem:HelperItem;
      
      public function HelperList()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _helperListBG = ClassUtils.CreatInstance("assets.farm.helperPanelBg");
         _helperListVLine = ComponentFactory.Instance.creatComponentByStylename("farm.helperListVLine");
         _fieldIndex = ComponentFactory.Instance.creatComponentByStylename("helperList.fieldIndex");
         _seedID = ComponentFactory.Instance.creatComponentByStylename("helperList.seedID");
         _fertilizerID = ComponentFactory.Instance.creatComponentByStylename("helperList.fertilizerID");
         _isAuto = ComponentFactory.Instance.creatComponentByStylename("helperList.isAuto");
         _fieldIndexText = ComponentFactory.Instance.creatComponentByStylename("helperList.fieldIndexText");
         _seedIDText = ComponentFactory.Instance.creatComponentByStylename("helperList.seedIDText");
         _fertilizerIDText = ComponentFactory.Instance.creatComponentByStylename("helperList.fertilizerIDText");
         _isAutoText = ComponentFactory.Instance.creatComponentByStylename("helperList.isAutoText");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("farm.farmHelperList.listVbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("farm.farmHelperList.listScrollPanel");
         _scrollPanel.setView(_vbox);
         addChild(_helperListBG);
         addChild(_helperListVLine);
         addChild(_fieldIndex);
         addChild(_seedID);
         addChild(_fertilizerID);
         addChild(_isAuto);
         addChild(_fieldIndexText);
         addChild(_seedIDText);
         addChild(_fertilizerIDText);
         addChild(_isAutoText);
         addChild(_vbox);
         addChild(_scrollPanel);
         _fieldIndexText.text = LanguageMgr.GetTranslation("ddt.farm.helperList.fieldIndexText");
         _seedIDText.text = LanguageMgr.GetTranslation("ddt.farm.helperList.seedIDText");
         _fertilizerIDText.text = LanguageMgr.GetTranslation("ddt.farm.helperList.fertilizerIDText");
         _isAutoText.text = LanguageMgr.GetTranslation("ddt.farm.helperList.isAutoText");
         setTip(_fieldIndex,_fieldIndexText.text);
         setTip(_seedID,_seedIDText.text);
         setTip(_fertilizerID,_fertilizerIDText.text);
         setTip(_isAuto,_isAutoText.text);
         setListData();
      }
      
      private function setTip(param1:BaseButton, param2:String) : void
      {
         param1.tipStyle = "ddt.view.tips.OneLineTip";
         param1.tipDirctions = "0";
         param1.tipData = param2;
      }
      
      public function get helperItemList() : Array
      {
         return _helperItemList;
      }
      
      private function findNumState(param1:int, param2:int) : int
      {
         var _loc10_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:* = _helperItemList;
         for each(var _loc6_ in _helperItemList)
         {
            _loc10_ = _loc6_.getSetViewItemData;
            if(!_loc10_)
            {
               _loc10_ = _loc6_.getItemData;
            }
            _loc5_ = _loc10_.currentSeedText;
            if(param1 > 0 && _loc5_ == param1)
            {
               _loc9_ = _loc9_ + int(_loc10_.currentSeedNum);
            }
            _loc3_ = _loc10_.currentFertilizerText;
            if(param2 > 0 && _loc3_ == param2)
            {
               _loc7_ = _loc7_ + int(_loc10_.currentFertilizerNum);
            }
         }
         var _loc11_:InventoryItemInfo = FarmModelController.instance.model.findItemInfo(32,param1);
         if(_loc11_ && _loc9_ > _loc11_.Count)
         {
            _loc8_ = 1;
         }
         var _loc4_:InventoryItemInfo = FarmModelController.instance.model.findItemInfo(33,param2);
         if(_loc4_ && _loc7_ > _loc4_.Count)
         {
            _loc8_ = 2;
         }
         return _loc8_;
      }
      
      private function setListData() : void
      {
         var _loc11_:int = 0;
         var _loc2_:* = null;
         var _loc10_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc5_:* = null;
         _vbox.disposeAllChildren();
         _helperItemList = [];
         var _loc1_:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         var _loc6_:int = !!_loc1_?_loc1_.length:0;
         _loc11_ = 0;
         while(_loc11_ < _loc6_)
         {
            _loc2_ = new HelperItem();
            _loc2_.addEventListener("click",__onItemClickHandler);
            _loc2_.findNumState = findNumState;
            _loc2_.index = _loc11_;
            _loc10_ = null;
            _loc10_ = _loc1_[_loc11_];
            if(_loc10_.isDig)
            {
               _loc2_.initView(1);
               _loc2_.setCellValue(_loc10_);
               _helperItemList.push(_loc2_);
               _vbox.addChild(_loc2_);
            }
            _loc11_++;
         }
         _scrollPanel.invalidateViewport();
         _seedInfos = new Dictionary();
         _fertilizerInfos = new Dictionary();
         var _loc4_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         var _loc3_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         _loc8_ = 0;
         while(_loc8_ < _loc4_.length)
         {
            _loc7_ = _loc4_[_loc8_];
            _seedInfos[_loc7_.TemplateInfo.Name] = _loc7_.TemplateInfo.TemplateID;
            _loc8_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc9_];
            _fertilizerInfos[_loc5_.TemplateInfo.Name] = _loc5_.TemplateInfo.TemplateID;
            _loc9_++;
         }
      }
      
      public function onKeyStart() : void
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _helperItemList;
         for each(var _loc1_ in _helperItemList)
         {
            if(_loc1_.onKeyStart())
            {
               _loc2_.push(_loc1_.getItemData);
            }
         }
         if(_loc2_.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.onKeyStartFail"));
         }
         else
         {
            FarmModelController.instance.farmHelperSetSwitch(_loc2_,true);
         }
      }
      
      public function onKeyStop() : void
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _helperItemList;
         for each(var _loc1_ in _helperItemList)
         {
            if(_loc1_.onKeyStop())
            {
               _loc2_.push(_loc1_.getItemData);
            }
         }
         if(_loc2_.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.onKeyStopFail"));
         }
         else
         {
            FarmModelController.instance.farmHelperSetSwitch(_loc2_,false);
         }
      }
      
      private function __onItemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:HelperItem = HelperItem(param1.currentTarget);
         _loc2_.isSelelct(true);
         if(_currentSelectHelperItem && _currentSelectHelperItem != _loc2_)
         {
            _currentSelectHelperItem.isSelelct(false);
         }
         _currentSelectHelperItem = _loc2_;
      }
      
      private function initEvent() : void
      {
         FarmModelController.instance.addEventListener("helperSwitchField",__helperSwitchHandler);
         FarmModelController.instance.addEventListener("helperkeyfield",__helperKeyHandler);
      }
      
      private function __helperSwitchHandler(param1:FarmEvent) : void
      {
         var _loc2_:FieldVO = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.isAutoId);
         if(_loc2_.isDig)
         {
            HelperItem(getHelperItem(_loc2_.fieldID)).setCellValue(_loc2_);
         }
         FarmModelController.instance.model.dispatchEvent(new FarmEvent("updateHelperIsAuto"));
      }
      
      private function __helperKeyHandler(param1:FarmEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < FarmModelController.instance.model.batchFieldIDArray.length)
         {
            _loc2_ = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.batchFieldIDArray[_loc3_]);
            if(_loc2_.isDig)
            {
               HelperItem(getHelperItem(_loc2_.fieldID)).setCellValue(_loc2_);
            }
            _loc3_++;
         }
         FarmModelController.instance.model.dispatchEvent(new FarmEvent("updateHelperIsAuto"));
      }
      
      public function getHelperItem(param1:int) : HelperItem
      {
         var _loc4_:int = 0;
         var _loc3_:* = _helperItemList;
         for each(var _loc2_ in _helperItemList)
         {
            if(_loc2_.currentFieldID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function dispose() : void
      {
         FarmModelController.instance.removeEventListener("helperSwitchField",__helperSwitchHandler);
         FarmModelController.instance.removeEventListener("helperkeyfield",__helperKeyHandler);
         if(_helperItemList)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _helperItemList;
            for each(var _loc1_ in _helperItemList)
            {
               _loc1_.removeEventListener("click",__onItemClickHandler);
               _loc1_.dispose();
            }
            _helperItemList = null;
         }
         if(_vbox)
         {
            _vbox.disposeAllChildren();
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_helperListBG)
         {
            ObjectUtils.disposeObject(_helperListBG);
         }
         _helperListBG = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         if(_fieldIndex)
         {
            ObjectUtils.disposeObject(_fieldIndex);
         }
         _fieldIndex = null;
         if(_seedID)
         {
            ObjectUtils.disposeObject(_seedID);
         }
         _seedID = null;
         if(_fertilizerID)
         {
            ObjectUtils.disposeObject(_fertilizerID);
         }
         _fertilizerID = null;
         if(_isAuto)
         {
            ObjectUtils.disposeObject(_isAuto);
         }
         _isAuto = null;
         if(_fieldIndexText)
         {
            ObjectUtils.disposeObject(_fieldIndexText);
         }
         _fieldIndexText = null;
         if(_seedIDText)
         {
            ObjectUtils.disposeObject(_seedIDText);
         }
         _seedIDText = null;
         if(_fertilizerIDText)
         {
            ObjectUtils.disposeObject(_fertilizerIDText);
         }
         _fertilizerIDText = null;
         if(_isAutoText)
         {
            ObjectUtils.disposeObject(_isAutoText);
         }
         _isAutoText = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
