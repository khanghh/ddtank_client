package store
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.loader.LoaderCreate;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.PositionUtils;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   import store.analyze.EvolutionDataAnalyzer;
   import store.data.EvolutionData;
   
   public class FineEvolutionManager extends EventDispatcher
   {
      
      private static var _instance:FineEvolutionManager;
      
      protected static const All:String = "all";
      
      protected static const FIRST_ONE:String = "one";
      
      protected static const QUICK:String = "quick";
      
      protected static const ALL_LOW:String = "all_Low";
      
      protected static const ALL_REMAIN:String = "all_remain";
       
      
      private var _evolutionData:DictionaryData;
      
      private var _needPlayMc:Boolean = false;
      
      public var CallBack:Function;
      
      private var _canClickBagList:Boolean = true;
      
      private var _tagItem:InventoryItemInfo;
      
      private var _tagTempleteItem:ItemTemplateInfo;
      
      private var _quickEatInfo:InventoryItemInfo;
      
      private var _state:String;
      
      private var expData:Array;
      
      private var _firstConfirm:Boolean = true;
      
      private var _selectNumView:SelectNumBatchAlerFrame;
      
      private var _singleNum:int;
      
      private var _totalExp:int;
      
      public function FineEvolutionManager()
      {
         super();
      }
      
      public static function get Instance() : FineEvolutionManager
      {
         if(_instance == null)
         {
            _instance = new FineEvolutionManager();
         }
         return _instance;
      }
      
      public function get needPlayMc() : Boolean
      {
         return _needPlayMc;
      }
      
      public function set needPlayMc(value:Boolean) : void
      {
         _needPlayMc = value;
      }
      
      public function EvolutionAnalyzer(data:EvolutionDataAnalyzer) : void
      {
         _evolutionData = data.data;
      }
      
      public function get EvolutionDatas() : DictionaryData
      {
         return _evolutionData;
      }
      
      public function EvolutionDataByLv(lv:int) : EvolutionData
      {
         if(_evolutionData && _evolutionData.hasKey(lv))
         {
            return _evolutionData[lv];
         }
         return null;
      }
      
      public function GetNextEvolutionDataByEXP(exp:int) : EvolutionData
      {
         var data:* = null;
         var i:int = 0;
         var arr:Array = _evolutionData.list;
         for(i = 0; i < arr.length; )
         {
            if(arr[i].Exp > exp)
            {
               data = EvolutionDataByLv(arr[i].Level);
               data.isMax = false;
               return data;
            }
            if(i == arr.length - 1 && arr[i].Exp == exp)
            {
               data = EvolutionDataByLv(arr[i].Level);
               data.isMax = true;
               return data;
            }
            i++;
         }
         return null;
      }
      
      public function GetEvolutionDataByExp(exp:int) : EvolutionData
      {
         var data:* = null;
         var i:int = 0;
         var arr:Array = _evolutionData.list;
         for(i = 0; i < arr.length; )
         {
            if(exp < arr[i].Exp && exp > 0)
            {
               data = EvolutionDataByLv(arr[i].Level - 1);
               return data;
            }
            if(exp == arr[i].Exp)
            {
               data = EvolutionDataByLv(arr[i].Level);
               return data;
            }
            i++;
         }
         return data;
      }
      
      public function progress(info:InventoryItemInfo) : int
      {
         var num:Number = NaN;
         var data:* = null;
         if(info)
         {
            data = FineEvolutionManager.Instance.GetNextEvolutionDataByEXP(int(info.curExp));
            if(data)
            {
               num = info.curExp / data.Exp;
            }
         }
         return int(num * 100);
      }
      
      public function LoadEvolutionData() : void
      {
         if(_evolutionData == null)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createEvolutionData],function():void
            {
            },null,true);
         }
      }
      
      public function get canClickBagList() : Boolean
      {
         return _canClickBagList;
      }
      
      public function set canClickBagList(value:Boolean) : void
      {
         _canClickBagList = value;
      }
      
      public function eatBeHaviour($info:InventoryItemInfo, $eatenInfo:InventoryItemInfo = null) : void
      {
         var state:int = 0;
         _tagItem = $info;
         _tagTempleteItem = ItemManager.Instance.getTemplateById($info.TemplateID);
         _quickEatInfo = $eatenInfo;
         _singleNum = 1;
         if($eatenInfo == null)
         {
            _state = "all";
            eat(_state);
         }
         else
         {
            _state = "quick";
            if($eatenInfo.TemplateID == 12572 && $eatenInfo.Count >= 1)
            {
               showSelectAlert();
            }
            if($eatenInfo.CategoryID == 17)
            {
               state = checkLevel(_quickEatInfo);
               if(state == 0)
               {
                  materialNumSelect(_quickEatInfo.Count);
               }
               else if(state == 1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.evolution.cannotEat"),0,true,1);
               }
               else if(state == 2)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.evolution.notStrengthen"));
               }
            }
         }
      }
      
      private function showSelectAlert() : void
      {
         if(_selectNumView == null)
         {
            _selectNumView = ComponentFactory.Instance.creatComponentByStylename("store.selectNumView");
            LayerManager.Instance.addToLayer(_selectNumView,2,true,2);
         }
         _selectNumView.item = _quickEatInfo;
         _selectNumView.TitleTxt = LanguageMgr.GetTranslation("store.view.evolution.alter.title");
         _selectNumView.ContentTxt = LanguageMgr.GetTranslation("stor.view.evolution.alter.selectNum");
         _selectNumView.callback = materialNumSelect;
         var txt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("evolutionAler.content.text");
         txt.htmlText = LanguageMgr.GetTranslation("store.frame.evolution.band.prompt");
         txt.x = 62;
         txt.y = 105;
         _selectNumView.addChild(txt);
         _selectNumView.addEventListener("response",responseSelectHandler);
      }
      
      private function responseSelectHandler(evt:FrameEvent) : void
      {
         _selectNumView.removeEventListener("response",responseSelectHandler);
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
            case 4:
               materialNumSelect(_selectNumView.Count);
         }
         if(_selectNumView.parent)
         {
            _selectNumView.parent.removeChild(_selectNumView);
         }
         ObjectUtils.disposeAllChildren(_selectNumView);
         _selectNumView = null;
      }
      
      private function materialNumSelect(num:int) : void
      {
         _singleNum = num;
         eat(_state);
      }
      
      public function eat($state:String) : void
      {
         var alert:* = null;
         var msg:* = null;
         var txt:* = null;
         expData = getExperienceList(_tagItem,$state);
         if(expData.length == 0)
         {
            FineEvolutionManager.Instance.canClickBagList = true;
            return;
         }
         FineEvolutionManager.Instance.canClickBagList = false;
         txt = ComponentFactory.Instance.creatComponentByStylename("evolutionAler.content.text");
         if($state == "all")
         {
            msg = LanguageMgr.GetTranslation("tank.view.bagII.offhand.evolution.eatAll",_tagItem.Name,_totalExp);
            PositionUtils.setPos(txt,"storeFine.evolutionAlert.Pos");
         }
         else if($state == "quick")
         {
            msg = LanguageMgr.GetTranslation("tank.view.bagII.level1EatAll.alert",_quickEatInfo.Name,_totalExp);
         }
         txt.htmlText = LanguageMgr.GetTranslation("store.frame.evolution.band.prompt");
         alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         alert.addChild(txt);
         alert.addEventListener("response",responseEatHandler);
         if(alert && alert.parent == null)
         {
            LayerManager.Instance.addToLayer(alert,2,true,2);
         }
      }
      
      private function responseEatHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",responseEatHandler);
         var alter:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         if(CallBack)
         {
            CallBack(false);
         }
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               if(alter.parent)
               {
                  alter.parent.removeChild(alter);
               }
               ObjectUtils.disposeAllChildren(alter);
               alter = null;
               break;
            case 2:
            case 3:
            case 4:
               sendEat();
               if(alter.parent)
               {
                  alter.parent.removeChild(alter);
               }
               ObjectUtils.disposeAllChildren(alter);
               alter = null;
         }
      }
      
      private function getExperienceList(tagItem:InventoryItemInfo, type:String) : Array
      {
         tagItem = tagItem;
         type = type;
         search = function():void
         {
            var item:* = null;
            var i:int = 0;
            var j:int = 0;
            var list:Array = PlayerManager.Instance.Self.Bag.findItems(17,false);
            var material:Array = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(12572,false);
            list.sortOn("Place",16);
            material.sortOn("Place",16);
            var len:int = list.length;
            for(i = 0; i < len; )
            {
               item = list[i] as InventoryItemInfo;
               if(item.cellLocked == false && item.getRemainDate() > 0 && tagItem.Place != item.Place)
               {
                  if(!checkLevel(item))
                  {
                     obj = {};
                     obj.totalExp = item.Property2;
                     obj.bagType = item.BagType;
                     obj.place = item.Place;
                     obj.count = item.Count;
                     if(item.curExp != 0)
                     {
                        _totalExp = _totalExp + (item.curExp + int(item.Property2)) * item.Count;
                     }
                     else
                     {
                        _totalExp = _totalExp + int(item.Property2) * item.Count;
                     }
                     datas.push(obj);
                  }
               }
               i++;
            }
            len = material.length;
            for(j = 0; j < len; )
            {
               item = material[j] as InventoryItemInfo;
               if(item.cellLocked == false)
               {
                  obj = {};
                  obj.totalExp = item.curExp;
                  obj.bagType = item.BagType;
                  obj.place = item.Place;
                  obj.count = item.Count;
                  datas.push(obj);
                  _totalExp = _totalExp + int(item.Property2) * item.Count;
               }
               j++;
            }
         };
         var tagItemTempleteID:int = tagItem.TemplateID;
         var datas:Array = [];
         _totalExp = 0;
         if(type == "quick")
         {
            var obj:Object = {};
            obj.totalExp = _quickEatInfo.Property2;
            obj.bagType = _quickEatInfo.BagType;
            obj.place = _quickEatInfo.Place;
            obj.count = _singleNum;
            if(_quickEatInfo.TemplateID == 12572)
            {
               _totalExp = int(_quickEatInfo.Property2) * _singleNum;
               datas.push(obj);
            }
            else if(_quickEatInfo.curExp == 0)
            {
               if(_quickEatInfo.Property2 != "")
               {
                  _totalExp = int(_quickEatInfo.Property2) * _singleNum;
                  datas.push(obj);
               }
               else
               {
                  if(_quickEatInfo.StrengthenLevel > 0 || _quickEatInfo.StrengthenExp > 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.evolution.notStrengthen"));
                     return datas;
                  }
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.canNotEatLockedCellIII"));
                  return datas;
               }
            }
            else
            {
               _totalExp = (_quickEatInfo.curExp + int(_quickEatInfo.Property2)) * _singleNum;
               datas.push(obj);
            }
            return datas;
         }
         search();
         if(datas.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.evolution.noneCanEat"),0,true,1);
         }
         return datas;
      }
      
      private function checkLevel(value:InventoryItemInfo) : int
      {
         var state:int = 0;
         if(value.curExp > _tagItem.curExp)
         {
            state = 1;
         }
         else if(value.curExp == 0 && (value.Property2 == "" || value.Property2 == "0"))
         {
            state = 1;
         }
         else if(value.StrengthenLevel > 0 || value.StrengthenExp > 0)
         {
            state = 2;
         }
         return state;
      }
      
      private function sendEat() : void
      {
         if(expData != null && expData.length > 0)
         {
            needPlayMc = true;
            GameInSocketOut.sendEvolutionMaterials(expData);
            expData = null;
            _state = "";
         }
      }
   }
}
