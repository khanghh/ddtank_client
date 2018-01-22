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
      
      public function ConsortiaRateManager(){super();}
      
      public static function get instance() : ConsortiaRateManager{return null;}
      
      private function initEvents() : void{}
      
      private function __resultConsortiaEquipContro(param1:ConsortionBuildingUseConditionAnalyer) : void{}
      
      private function __consortiaClubSearchResult(param1:ConsortionListAnalyzer) : void{}
      
      private function setStripTipData() : void{}
      
      private function setStripTipDataRichs(param1:int) : void{}
      
      private function __onLoadErrorII(param1:LoaderEvent) : void{}
      
      private function __onAlertResponseII(param1:FrameEvent) : void{}
      
      private function _propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function _useConditionChange(param1:ConsortionEvent) : void{}
      
      public function reset() : void{}
      
      public function get consortiaTipData() : String{return null;}
      
      public function get smithLevel() : int{return 0;}
      
      public function get rate() : int{return 0;}
      
      public function getConsortiaStrengthenEx(param1:int) : Number{return 0;}
      
      private function _loadComplete() : void{}
      
      public function sendTransferShowLightEvent(param1:ItemTemplateInfo, param2:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
