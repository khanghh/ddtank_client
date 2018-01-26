package sevenDayTarget.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   import sevenDayTarget.model.NewPlayerRewardInfo;
   import sevenDayTarget.model.NewPlayerRewardModel;
   import sevenDayTarget.view.NewPlayerRewardMainView;
   
   public class NewPlayerRewardManager extends EventDispatcher
   {
      
      private static var _instance:NewPlayerRewardManager;
       
      
      private var _isShowIcon:Boolean;
      
      private var _model:NewPlayerRewardModel;
      
      public function NewPlayerRewardManager(){super();}
      
      public static function get Instance() : NewPlayerRewardManager{return null;}
      
      public function get isShowIcon() : Boolean{return false;}
      
      public function setup() : void{}
      
      public function get model() : NewPlayerRewardModel{return null;}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function updateView(param1:PackageIn) : void{}
      
      private function updateQuestionInfoArr(param1:int, param2:Boolean, param3:Boolean) : void{}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      public function enterView(param1:PackageIn) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      private function __completeShow(param1:UIModuleEvent) : void{}
      
      private function showNewPlayerRewardMainView() : void{}
   }
}
