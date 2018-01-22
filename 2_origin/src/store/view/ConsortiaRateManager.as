package store.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.analyze.ConsortionBuildingUseConditionAnalyer;
   import consortion.analyze.ConsortionListAnalyzer;
   import consortion.data.ConsortiaAssetLevelOffer;
   import consortion.event.ConsortionEvent;
   import ddt.data.ConsortiaInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import store.events.StoreIIEvent;
   
   public class ConsortiaRateManager extends EventDispatcher
   {
      
      public static var _instance:ConsortiaRateManager;
      
      public static const CHANGE_CONSORTIA:String = "loadComplete_consortia";
       
      
      private var _SmithLevel:int = 0;
      
      private var _data:String;
      
      private var _rate:int;
      
      private var _selfRich:int;
      
      private var _needRich:int = 100;
      
      public function ConsortiaRateManager()
      {
         super();
         initEvents();
      }
      
      public static function get instance() : ConsortiaRateManager
      {
         if(_instance == null)
         {
            _instance = new ConsortiaRateManager();
         }
         return _instance;
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",_propertyChange);
         ConsortionModelManager.Instance.model.addEventListener("useConditionChange",_useConditionChange);
      }
      
      private function __resultConsortiaEquipContro(param1:ConsortionBuildingUseConditionAnalyer) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = param1.useConditionList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.useConditionList[_loc4_];
            if(_loc2_.Type == 2)
            {
               setStripTipDataRichs(_loc2_.Riches);
            }
            _loc4_++;
         }
      }
      
      private function __consortiaClubSearchResult(param1:ConsortionListAnalyzer) : void
      {
         var _loc2_:* = null;
         if(param1.consortionList.length > 0)
         {
            _loc2_ = param1.consortionList[0];
            if(_loc2_)
            {
               _SmithLevel = _loc2_.SmithLevel;
            }
            _rate = _SmithLevel;
            setStripTipData();
         }
      }
      
      private function setStripTipData() : void
      {
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            if(_SmithLevel <= 0)
            {
               _loadComplete();
            }
            else
            {
               ConsortionModelManager.Instance.loadUseConditionList(__resultConsortiaEquipContro,PlayerManager.Instance.Self.ConsortiaID);
            }
         }
         else
         {
            _loadComplete();
         }
      }
      
      private function setStripTipDataRichs(param1:int) : void
      {
         _selfRich = PlayerManager.Instance.Self.RichesOffer + PlayerManager.Instance.Self.RichesRob;
         if(_selfRich < param1)
         {
            _rate = 0;
         }
         _needRich = param1;
         _loadComplete();
      }
      
      private function __onLoadErrorII(param1:LoaderEvent) : void
      {
         var _loc3_:String = param1.loader.loadErrorMessage;
         if(param1.loader.analyzer)
         {
            _loc3_ = param1.loader.loadErrorMessage + "\n" + param1.loader.analyzer.message;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),param1.loader.loadErrorMessage,LanguageMgr.GetTranslation("tank.view.bagII.baglocked.sure"));
         _loc2_.addEventListener("response",__onAlertResponseII);
      }
      
      private function __onAlertResponseII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",__onAlertResponseII);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["SmithLevel"])
         {
            _SmithLevel = PlayerManager.Instance.Self.consortiaInfo.SmithLevel;
         }
         if(param1.changedProperties["RichesOffer"] || param1.changedProperties["RichesRob"])
         {
            _selfRich = PlayerManager.Instance.Self.RichesOffer + PlayerManager.Instance.Self.RichesRob;
         }
         _rate = _SmithLevel;
         _loadComplete();
      }
      
      private function _useConditionChange(param1:ConsortionEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Vector.<ConsortiaAssetLevelOffer> = ConsortionModelManager.Instance.model.useConditionList;
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc5_];
            if(_loc2_.Type == 2)
            {
               setStripTipDataRichs(_loc2_.Riches);
            }
            _loc5_++;
         }
      }
      
      public function reset() : void
      {
         _SmithLevel = PlayerManager.Instance.Self.consortiaInfo.SmithLevel;
         _selfRich = PlayerManager.Instance.Self.Riches;
         ConsortionModelManager.Instance.getConsortionList(__consortiaClubSearchResult,1,6,"",-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
      }
      
      public function get consortiaTipData() : String
      {
         _rate = PlayerManager.Instance.Self.consortiaInfo.SmithLevel;
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel <= 0)
            {
               _data = LanguageMgr.GetTranslation("tank.view.store.consortiaRateIII");
            }
            else if(PlayerManager.Instance.Self.UseOffer < _needRich)
            {
               _rate = 0;
               _data = LanguageMgr.GetTranslation("tank.view.store.consortiaRateII",PlayerManager.Instance.Self.UseOffer,_needRich);
            }
            else
            {
               _data = LanguageMgr.GetTranslation("store.StoreIIComposeBG.consortiaRate_txt",PlayerManager.Instance.Self.consortiaInfo.SmithLevel * 10);
            }
         }
         else
         {
            _rate = 0;
            _data = LanguageMgr.GetTranslation("tank.view.store.consortiaRateI");
         }
         return _data;
      }
      
      public function get smithLevel() : int
      {
         return PlayerManager.Instance.Self.consortiaInfo.SmithLevel;
      }
      
      public function get rate() : int
      {
         _rate = PlayerManager.Instance.Self.consortiaInfo.SmithLevel;
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel > 0 && PlayerManager.Instance.Self.UseOffer < _needRich)
            {
               _rate = 0;
            }
         }
         else
         {
            _rate = 0;
         }
         return _rate;
      }
      
      public function getConsortiaStrengthenEx(param1:int) : Number
      {
         if(param1 - 1 < 0)
         {
            return 0;
         }
         var _loc2_:Array = ServerConfigManager.instance.ConsortiaStrengthenEx();
         if(_loc2_)
         {
            return _loc2_[param1 - 1];
         }
         return 0;
      }
      
      private function _loadComplete() : void
      {
         dispatchEvent(new Event("loadComplete_consortia"));
      }
      
      public function sendTransferShowLightEvent(param1:ItemTemplateInfo, param2:Boolean) : void
      {
         dispatchEvent(new StoreIIEvent("transferLight",param1,param2));
      }
      
      public function dispose() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",_propertyChange);
      }
   }
}
