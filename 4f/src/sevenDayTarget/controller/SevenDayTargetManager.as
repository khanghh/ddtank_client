package sevenDayTarget.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import godsRoads.manager.GodsRoadsManager;
   import road7th.comm.PackageIn;
   import sevenDayTarget.dataAnalyzer.SevenDayTargetDataAnalyzer;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   import sevenDayTarget.model.SevenDayTargetModel;
   import sevenDayTarget.view.SevenDayTargetMainView;
   
   public class SevenDayTargetManager extends EventDispatcher
   {
      
      private static var _instance:SevenDayTargetManager;
      
      public static var loadComplete:Boolean = false;
       
      
      private var _model:SevenDayTargetModel;
      
      private var _isShowIcon:Boolean;
      
      private var _sevenDayTargetView:SevenDayTargetMainView;
      
      public var today:int = 1;
      
      public var questionTemple:Array;
      
      public var isHallAct:Boolean = false;
      
      public function SevenDayTargetManager(){super();}
      
      public static function get Instance() : SevenDayTargetManager{return null;}
      
      public function setup() : void{}
      
      private function _dataReciver(param1:Event) : void{}
      
      public function get isShowIcon() : Boolean{return false;}
      
      public function hide() : void{}
      
      public function onClickSevenDayTargetIcon() : void{}
      
      private function __delayLoading(param1:TimerEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      private function __completeShow(param1:UIModuleEvent) : void{}
      
      private function showSevenDayTargetMainView() : void{}
      
      public function templateDataSetup(param1:DataAnalyzer) : void{}
      
      public function getQuestionInfoFromTemple(param1:NewTargetQuestionInfo) : NewTargetQuestionInfo{return null;}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      private function enterView(param1:PackageIn) : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function updateView(param1:PackageIn) : void{}
      
      private function updateQuestionInfoArr(param1:int, param2:Boolean, param3:Boolean) : void{}
      
      public function get model() : SevenDayTargetModel{return null;}
   }
}
