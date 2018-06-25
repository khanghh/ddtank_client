package flowerGiving{   import com.pickgliss.ui.image.MovieImage;   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import flash.utils.Dictionary;   import flowerGiving.events.FlowerGiveEvent;   import hall.HallStateView;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.data.GmActivityInfo;      public class FlowerGivingManager extends CoreManager   {            private static var _ins:FlowerGivingManager;                   public var hallView:HallStateView;            public var isShowIcon:Boolean;            public var actId:String;            public var xmlData:GmActivityInfo;            private var _flowerGivingIcon:MovieImage;            public var flowerTempleteId:int;            public function FlowerGivingManager(single:inner) { super(); }
            public static function get instance() : FlowerGivingManager { return null; }
            public function get flowerGivingIcon() : MovieImage { return null; }
            public function addEvents() : void { }
            public function removeEvents() : void { }
            public function checkOpen() : void { }
            protected function __flowerGivingOpenHandler(event:PkgEvent) : void { }
            protected function __flowerFallHandler(event:PkgEvent) : void { }
            private function createFlowerIcon() : void { }
            public function deleteFlowerIcon() : void { }
            override protected function start() : void { }
   }}class inner{          function inner() { super(); }
}