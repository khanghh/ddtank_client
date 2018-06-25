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
      
      private function setTip(btn:BaseButton, value:String) : void
      {
         btn.tipStyle = "ddt.view.tips.OneLineTip";
         btn.tipDirctions = "0";
         btn.tipData = value;
      }
      
      public function get helperItemList() : Array
      {
         return _helperItemList;
      }
      
      private function findNumState(seedId:int, fertilizerId:int) : int
      {
         var obj:* = null;
         var id1:int = 0;
         var id2:int = 0;
         var state:int = 0;
         var count1:int = 0;
         var count2:int = 0;
         var _loc13_:int = 0;
         var _loc12_:* = _helperItemList;
         for each(var item in _helperItemList)
         {
            obj = item.getSetViewItemData;
            if(!obj)
            {
               obj = item.getItemData;
            }
            id1 = obj.currentSeedText;
            if(seedId > 0 && id1 == seedId)
            {
               count1 = count1 + int(obj.currentSeedNum);
            }
            id2 = obj.currentFertilizerText;
            if(fertilizerId > 0 && id2 == fertilizerId)
            {
               count2 = count2 + int(obj.currentFertilizerNum);
            }
         }
         var seedinfo:InventoryItemInfo = FarmModelController.instance.model.findItemInfo(32,seedId);
         if(seedinfo && count1 > seedinfo.Count)
         {
            state = 1;
         }
         var fertilireInfo:InventoryItemInfo = FarmModelController.instance.model.findItemInfo(33,fertilizerId);
         if(fertilireInfo && count2 > fertilireInfo.Count)
         {
            state = 2;
         }
         return state;
      }
      
      private function setListData() : void
      {
         var i:int = 0;
         var helperItem:* = null;
         var fieldVO:* = null;
         var m:int = 0;
         var itemInfo:* = null;
         var k:int = 0;
         var itemInfo1:* = null;
         _vbox.disposeAllChildren();
         _helperItemList = [];
         var fieldsInfo:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         var length:int = !!fieldsInfo?fieldsInfo.length:0;
         for(i = 0; i < length; )
         {
            helperItem = new HelperItem();
            helperItem.addEventListener("click",__onItemClickHandler);
            helperItem.findNumState = findNumState;
            helperItem.index = i;
            fieldVO = null;
            fieldVO = fieldsInfo[i];
            if(fieldVO.isDig)
            {
               helperItem.initView(1);
               helperItem.setCellValue(fieldVO);
               _helperItemList.push(helperItem);
               _vbox.addChild(helperItem);
            }
            i++;
         }
         _scrollPanel.invalidateViewport();
         _seedInfos = new Dictionary();
         _fertilizerInfos = new Dictionary();
         var arr:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         var autoFertilizer:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         for(m = 0; m < arr.length; )
         {
            itemInfo = arr[m];
            _seedInfos[itemInfo.TemplateInfo.Name] = itemInfo.TemplateInfo.TemplateID;
            m++;
         }
         for(k = 0; k < autoFertilizer.length; )
         {
            itemInfo1 = autoFertilizer[k];
            _fertilizerInfos[itemInfo1.TemplateInfo.Name] = itemInfo1.TemplateInfo.TemplateID;
            k++;
         }
      }
      
      public function onKeyStart() : void
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _helperItemList;
         for each(var item in _helperItemList)
         {
            if(item.onKeyStart())
            {
               temp.push(item.getItemData);
            }
         }
         if(temp.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.onKeyStartFail"));
         }
         else
         {
            FarmModelController.instance.farmHelperSetSwitch(temp,true);
         }
      }
      
      public function onKeyStop() : void
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _helperItemList;
         for each(var item in _helperItemList)
         {
            if(item.onKeyStop())
            {
               temp.push(item.getItemData);
            }
         }
         if(temp.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helperItem.onKeyStopFail"));
         }
         else
         {
            FarmModelController.instance.farmHelperSetSwitch(temp,false);
         }
      }
      
      private function __onItemClickHandler(event:MouseEvent) : void
      {
         var helperItem:HelperItem = HelperItem(event.currentTarget);
         helperItem.isSelelct(true);
         if(_currentSelectHelperItem && _currentSelectHelperItem != helperItem)
         {
            _currentSelectHelperItem.isSelelct(false);
         }
         _currentSelectHelperItem = helperItem;
      }
      
      private function initEvent() : void
      {
         FarmModelController.instance.addEventListener("helperSwitchField",__helperSwitchHandler);
         FarmModelController.instance.addEventListener("helperkeyfield",__helperKeyHandler);
      }
      
      private function __helperSwitchHandler(e:FarmEvent) : void
      {
         var field1:FieldVO = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.isAutoId);
         if(field1.isDig)
         {
            HelperItem(getHelperItem(field1.fieldID)).setCellValue(field1);
         }
         FarmModelController.instance.model.dispatchEvent(new FarmEvent("updateHelperIsAuto"));
      }
      
      private function __helperKeyHandler(e:FarmEvent) : void
      {
         var i:int = 0;
         var field1:* = null;
         for(i = 0; i < FarmModelController.instance.model.batchFieldIDArray.length; )
         {
            field1 = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.batchFieldIDArray[i]);
            if(field1.isDig)
            {
               HelperItem(getHelperItem(field1.fieldID)).setCellValue(field1);
            }
            i++;
         }
         FarmModelController.instance.model.dispatchEvent(new FarmEvent("updateHelperIsAuto"));
      }
      
      public function getHelperItem(pFieldID:int) : HelperItem
      {
         var _loc4_:int = 0;
         var _loc3_:* = _helperItemList;
         for each(var helpItem in _helperItemList)
         {
            if(helpItem.currentFieldID == pFieldID)
            {
               return helpItem;
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
            for each(var helperItem in _helperItemList)
            {
               helperItem.removeEventListener("click",__onItemClickHandler);
               helperItem.dispose();
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
