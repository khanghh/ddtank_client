package ddtKingLettersCollect{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import flash.display.MovieClip;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import hall.IHallStateView;   import nationDay.NationDayManager;   import road7th.comm.PackageIn;      public class DdtKingLettersCollectManager extends CoreManager   {            public static const SHOW:String = "dklc_show";            public static const UPDATE:String = "dklc_update";            public static const ComposedItemTempleteID:int = 1120370;            private static var instance:DdtKingLettersCollectManager;                   private var _hall:IHallStateView;            private var _icon:MovieClip;            private var _isOpen:Boolean = false;            public var WordArray:Dictionary;            public function DdtKingLettersCollectManager(single:inner) { super(); }
            public static function getInstance() : DdtKingLettersCollectManager { return null; }
            public function setup() : void { }
            protected function __onGetHideTitleFlag(event:PkgEvent) : void { }
            public function showIcon($hall:IHallStateView) : void { }
            public function hideIcon($hall:IHallStateView) : void { }
            protected function onIconClick(e:MouseEvent) : void { }
            override protected function start() : void { }
            public function sendCompose($templeteID:int) : void { }
   }}class inner{          function inner() { super(); }
}