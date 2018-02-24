package treasurePuzzle.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import treasurePuzzle.data.TreasurePuzzlePiceData;
   import treasurePuzzle.data.TreasurePuzzleRewardData;
   import treasurePuzzle.model.TreasurePuzzleModel;
   import treasurePuzzle.view.TreasurePuzzleMainView;
   
   public class TreasurePuzzleManager extends EventDispatcher
   {
      
      private static var _instance:TreasurePuzzleManager;
      
      public static var loadComplete:Boolean = false;
       
      
      private var _isShowIcon:Boolean;
      
      private var _treasurePuzzleView:TreasurePuzzleMainView;
      
      private var _model:TreasurePuzzleModel;
      
      public var currentPuzzle:int;
      
      public function TreasurePuzzleManager(){super();}
      
      public static function get Instance() : TreasurePuzzleManager{return null;}
      
      public function get isShowIcon() : Boolean{return false;}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      private function enterView(param1:PackageIn) : void{}
      
      private function flushData(param1:PackageIn) : void{}
      
      private function seeReward(param1:PackageIn) : void{}
      
      private function getReward(param1:PackageIn) : void{}
      
      public function addEnterIcon() : void{}
      
      private function disposeEnterIcon() : void{}
      
      public function onClickTreasurePuzzleIcon() : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      private function __completeShow(param1:UIModuleEvent) : void{}
      
      private function showTreasurePuzzleMainView() : void{}
      
      public function get model() : TreasurePuzzleModel{return null;}
      
      public function hide() : void{}
   }
}
