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
      
      public function set needPlayMc(param1:Boolean) : void
      {
         _needPlayMc = param1;
      }
      
      public function EvolutionAnalyzer(param1:EvolutionDataAnalyzer) : void
      {
         _evolutionData = param1.data;
      }
      
      public function get EvolutionDatas() : DictionaryData
      {
         return _evolutionData;
      }
      
      public function EvolutionDataByLv(param1:int) : EvolutionData
      {
         if(_evolutionData && _evolutionData.hasKey(param1))
         {
            return _evolutionData[param1];
         }
         return null;
      }
      
      public function GetNextEvolutionDataByEXP(param1:int) : EvolutionData
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:Array = _evolutionData.list;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].Exp > param1)
            {
               _loc3_ = EvolutionDataByLv(_loc2_[_loc4_].Level);
               _loc3_.isMax = false;
               return _loc3_;
            }
            if(_loc4_ == _loc2_.length - 1 && _loc2_[_loc4_].Exp == param1)
            {
               _loc3_ = EvolutionDataByLv(_loc2_[_loc4_].Level);
               _loc3_.isMax = true;
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function GetEvolutionDataByExp(param1:int) : EvolutionData
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:Array = _evolutionData.list;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(param1 < _loc2_[_loc4_].Exp && param1 > 0)
            {
               _loc3_ = EvolutionDataByLv(_loc2_[_loc4_].Level - 1);
               return _loc3_;
            }
            if(param1 == _loc2_[_loc4_].Exp)
            {
               _loc3_ = EvolutionDataByLv(_loc2_[_loc4_].Level);
               return _loc3_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function progress(param1:InventoryItemInfo) : int
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = FineEvolutionManager.Instance.GetNextEvolutionDataByEXP(int(param1.curExp));
            if(_loc3_)
            {
               _loc2_ = param1.curExp / _loc3_.Exp;
            }
         }
         return int(_loc2_ * 100);
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
      
      public function set canClickBagList(param1:Boolean) : void
      {
         _canClickBagList = param1;
      }
      
      public function eatBeHaviour(param1:InventoryItemInfo, param2:InventoryItemInfo = null) : void
      {
         var _loc3_:int = 0;
         _tagItem = param1;
         _tagTempleteItem = ItemManager.Instance.getTemplateById(param1.TemplateID);
         _quickEatInfo = param2;
         _singleNum = 1;
         if(param2 == null)
         {
            _state = "all";
            eat(_state);
         }
         else
         {
            _state = "quick";
            if(param2.TemplateID == 12572 && param2.Count >= 1)
            {
               showSelectAlert();
            }
            if(param2.CategoryID == 17)
            {
               _loc3_ = checkLevel(_quickEatInfo);
               if(_loc3_ == 0)
               {
                  materialNumSelect(_quickEatInfo.Count);
               }
               else if(_loc3_ == 1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.evolution.cannotEat"),0,true,1);
               }
               else if(_loc3_ == 2)
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
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("evolutionAler.content.text");
         _loc1_.htmlText = LanguageMgr.GetTranslation("store.frame.evolution.band.prompt");
         _loc1_.x = 62;
         _loc1_.y = 105;
         _selectNumView.addChild(_loc1_);
         _selectNumView.addEventListener("response",responseSelectHandler);
      }
      
      private function responseSelectHandler(param1:FrameEvent) : void
      {
         _selectNumView.removeEventListener("response",responseSelectHandler);
         switch(int(param1.responseCode))
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
      
      private function materialNumSelect(param1:int) : void
      {
         _singleNum = param1;
         eat(_state);
      }
      
      public function eat(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         expData = getExperienceList(_tagItem,param1);
         if(expData.length == 0)
         {
            FineEvolutionManager.Instance.canClickBagList = true;
            return;
         }
         FineEvolutionManager.Instance.canClickBagList = false;
         _loc4_ = ComponentFactory.Instance.creatComponentByStylename("evolutionAler.content.text");
         if(param1 == "all")
         {
            _loc3_ = LanguageMgr.GetTranslation("tank.view.bagII.offhand.evolution.eatAll",_tagItem.Name,_totalExp);
            PositionUtils.setPos(_loc4_,"storeFine.evolutionAlert.Pos");
         }
         else if(param1 == "quick")
         {
            _loc3_ = LanguageMgr.GetTranslation("tank.view.bagII.level1EatAll.alert",_quickEatInfo.Name,_totalExp);
         }
         _loc4_.htmlText = LanguageMgr.GetTranslation("store.frame.evolution.band.prompt");
         _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         _loc2_.addChild(_loc4_);
         _loc2_.addEventListener("response",responseEatHandler);
         if(_loc2_ && _loc2_.parent == null)
         {
            LayerManager.Instance.addToLayer(_loc2_,2,true,2);
         }
      }
      
      private function responseEatHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",responseEatHandler);
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(CallBack)
         {
            CallBack(false);
         }
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               ObjectUtils.disposeAllChildren(_loc2_);
               _loc2_ = null;
               break;
            case 2:
            case 3:
            case 4:
               sendEat();
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               ObjectUtils.disposeAllChildren(_loc2_);
               _loc2_ = null;
         }
      }
      
      private function getExperienceList(param1:InventoryItemInfo, param2:String) : Array
      {
         tagItem = param1;
         type = param2;
         search = function():void
         {
            var _loc1_:* = null;
            var _loc6_:int = 0;
            var _loc4_:int = 0;
            var _loc2_:Array = PlayerManager.Instance.Self.Bag.findItems(17,false);
            var _loc5_:Array = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(12572,false);
            _loc2_.sortOn("Place",16);
            _loc5_.sortOn("Place",16);
            var _loc3_:int = _loc2_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc1_ = _loc2_[_loc6_] as InventoryItemInfo;
               if(_loc1_.cellLocked == false && _loc1_.getRemainDate() > 0 && tagItem.Place != _loc1_.Place)
               {
                  if(!checkLevel(_loc1_))
                  {
                     obj = {};
                     obj.totalExp = _loc1_.Property2;
                     obj.bagType = _loc1_.BagType;
                     obj.place = _loc1_.Place;
                     obj.count = _loc1_.Count;
                     if(_loc1_.curExp != 0)
                     {
                        _totalExp = _totalExp + (_loc1_.curExp + int(_loc1_.Property2)) * _loc1_.Count;
                     }
                     else
                     {
                        _totalExp = _totalExp + int(_loc1_.Property2) * _loc1_.Count;
                     }
                     datas.push(obj);
                  }
               }
               _loc6_++;
            }
            _loc3_ = _loc5_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc1_ = _loc5_[_loc4_] as InventoryItemInfo;
               if(_loc1_.cellLocked == false)
               {
                  obj = {};
                  obj.totalExp = _loc1_.curExp;
                  obj.bagType = _loc1_.BagType;
                  obj.place = _loc1_.Place;
                  obj.count = _loc1_.Count;
                  datas.push(obj);
                  _totalExp = _totalExp + int(_loc1_.Property2) * _loc1_.Count;
               }
               _loc4_++;
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
      
      private function checkLevel(param1:InventoryItemInfo) : int
      {
         var _loc2_:int = 0;
         if(param1.curExp > _tagItem.curExp)
         {
            _loc2_ = 1;
         }
         else if(param1.curExp == 0 && (param1.Property2 == "" || param1.Property2 == "0"))
         {
            _loc2_ = 1;
         }
         else if(param1.StrengthenLevel > 0 || param1.StrengthenExp > 0)
         {
            _loc2_ = 2;
         }
         return _loc2_;
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
