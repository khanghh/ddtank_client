package nationDay{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.MovieImage;   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.IEventDispatcher;   import flash.events.MouseEvent;   import hall.HallStateView;   import nationDay.model.NationModel;   import road7th.comm.PackageIn;      public class NationDayManager extends CoreManager   {            public static const LETTERS_NATIONAL_DAY:String = "lt_nation_day";            public static const LETTERS_DDT_KING:String = "lt_ddt_king";            public static const NATION_OPENVIEW:String = "nationOpenView";            public static var WordInfo:Array = [[1,2,3,4],[5,6,7,8],[9,5,10,11],[12,2,13,14]];            public static var WordRes:Array = [["1","2","3","4"],["5","6","7","8"],["9","10","11","12"],["13","14","15","16"]];            private static var _instance:NationDayManager;                   private var _nationModel:NationModel;            private var _openFlag:Boolean;            private var _nationDayIcon:MovieImage;            private var _hallView:HallStateView;            public function NationDayManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : NationDayManager { return null; }
            public function get curActivity() : String { return null; }
            public function setup() : void { }
            override protected function start() : void { }
            protected function __onGetHideTitleFlag(event:PkgEvent) : void { }
            private function showNationIcon() : void { }
            private function createNationBtn() : void { }
            public function setIconFrame() : void { }
            private function getExchangeNum(index:int) : int { return 0; }
            protected function __onNationDayClick(event:MouseEvent) : void { }
            public function addNationBtn(hall:HallStateView) : void { }
            public function deleteNaitonBtn() : void { }
            public function get nationDayIcon() : MovieImage { return null; }
            public function get nationModel() : NationModel { return null; }
            public function set nationModel(value:NationModel) : void { }
   }}