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
      
      private function __resultConsortiaEquipContro(analyzer:ConsortionBuildingUseConditionAnalyer) : void
      {
         var i:int = 0;
         var $info:* = null;
         var len:int = analyzer.useConditionList.length;
         for(i = 0; i < len; )
         {
            $info = analyzer.useConditionList[i];
            if($info.Type == 2)
            {
               setStripTipDataRichs($info.Riches);
            }
            i++;
         }
      }
      
      private function __consortiaClubSearchResult(analyzer:ConsortionListAnalyzer) : void
      {
         var info:* = null;
         if(analyzer.consortionList.length > 0)
         {
            info = analyzer.consortionList[0];
            if(info)
            {
               _SmithLevel = info.SmithLevel;
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
      
      private function setStripTipDataRichs(riches:int) : void
      {
         _selfRich = PlayerManager.Instance.Self.RichesOffer + PlayerManager.Instance.Self.RichesRob;
         if(_selfRich < riches)
         {
            _rate = 0;
         }
         _needRich = riches;
         _loadComplete();
      }
      
      private function __onLoadErrorII(event:LoaderEvent) : void
      {
         var msg:String = event.loader.loadErrorMessage;
         if(event.loader.analyzer)
         {
            msg = event.loader.loadErrorMessage + "\n" + event.loader.analyzer.message;
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),event.loader.loadErrorMessage,LanguageMgr.GetTranslation("tank.view.bagII.baglocked.sure"));
         alert.addEventListener("response",__onAlertResponseII);
      }
      
      private function __onAlertResponseII(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         event.currentTarget.removeEventListener("response",__onAlertResponseII);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function _propertyChange(e:PlayerPropertyEvent) : void
      {
         if(e.changedProperties["SmithLevel"])
         {
            _SmithLevel = PlayerManager.Instance.Self.consortiaInfo.SmithLevel;
         }
         if(e.changedProperties["RichesOffer"] || e.changedProperties["RichesRob"])
         {
            _selfRich = PlayerManager.Instance.Self.RichesOffer + PlayerManager.Instance.Self.RichesRob;
         }
         _rate = _SmithLevel;
         _loadComplete();
      }
      
      private function _useConditionChange(e:ConsortionEvent) : void
      {
         var i:int = 0;
         var $info:* = null;
         var list:Vector.<ConsortiaAssetLevelOffer> = ConsortionModelManager.Instance.model.useConditionList;
         var len:int = list.length;
         for(i = 0; i < len; )
         {
            $info = list[i];
            if($info.Type == 2)
            {
               setStripTipDataRichs($info.Riches);
            }
            i++;
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
      
      public function getConsortiaStrengthenEx(level:int) : Number
      {
         if(level - 1 < 0)
         {
            return 0;
         }
         var arr:Array = ServerConfigManager.instance.ConsortiaStrengthenEx();
         if(arr)
         {
            return arr[level - 1];
         }
         return 0;
      }
      
      private function _loadComplete() : void
      {
         dispatchEvent(new Event("loadComplete_consortia"));
      }
      
      public function sendTransferShowLightEvent(value:ItemTemplateInfo, isShow:Boolean) : void
      {
         dispatchEvent(new StoreIIEvent("transferLight",value,isShow));
      }
      
      public function dispose() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",_propertyChange);
      }
   }
}
