package sevenDayTarget.controller{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.comm.PackageIn;   import sevenDayTarget.model.NewPlayerRewardInfo;   import sevenDayTarget.model.NewPlayerRewardModel;   import sevenDayTarget.view.NewPlayerRewardMainView;      public class NewPlayerRewardManager extends EventDispatcher   {            private static var _instance:NewPlayerRewardManager;                   private var _isShowIcon:Boolean;            private var _model:NewPlayerRewardModel;            public function NewPlayerRewardManager() { super(); }
            public static function get Instance() : NewPlayerRewardManager { return null; }
            public function get isShowIcon() : Boolean { return false; }
            public function setup() : void { }
            public function get model() : NewPlayerRewardModel { return null; }
            private function pkgHandler(event:CrazyTankSocketEvent) : void { }
            private function updateView(pkg:PackageIn) : void { }
            private function updateQuestionInfoArr(questionID:int, success:Boolean, isComplete:Boolean) : void { }
            private function openOrclose(pkg:PackageIn) : void { }
            public function enterView(pkg:PackageIn) : void { }
            protected function __onClose(event:Event) : void { }
            private function __progressShow(event:UIModuleEvent) : void { }
            private function __completeShow(event:UIModuleEvent) : void { }
            private function showNewPlayerRewardMainView() : void { }
   }}