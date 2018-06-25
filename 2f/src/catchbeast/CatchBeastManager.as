package catchbeast{   import com.pickgliss.ui.image.MovieImage;   import ddt.CoreManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import flash.events.Event;   import hall.HallStateView;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class CatchBeastManager extends CoreManager   {            public static const CATCHBEAST_OPENVIEW:String = "catchBeastOpenView";            private static var _instance:CatchBeastManager;                   public var RoomType:int = 0;            private var _isBegin:Boolean;            private var _hallView:HallStateView;            private var _catchBeastIcon:MovieImage;            public function CatchBeastManager() { super(); }
            public static function get instance() : CatchBeastManager { return null; }
            public function setup() : void { }
            protected function __addCatchBeastBtn(event:CrazyTankSocketEvent) : void { }
            private function openOrclose(pkg:PackageIn) : void { }
            private function createCatchBeastBtn() : void { }
            public function deleteCatchBeastBtn() : void { }
            override protected function start() : void { }
            public function get catchBeastIcon() : MovieImage { return null; }
            public function get isBegin() : Boolean { return false; }
            public function set isBegin(value:Boolean) : void { }
   }}