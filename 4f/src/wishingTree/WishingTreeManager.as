package wishingTree{   import com.pickgliss.ui.ComponentFactory;   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.IEventDispatcher;   import flash.events.MouseEvent;   import hall.HallStateView;   import road7th.comm.PackageIn;      public class WishingTreeManager extends CoreManager   {            public static const WISHING_TREE_OPEN:String = "wishingTreeOpen";            private static var _instance:WishingTreeManager;                   private var _hallStateView:HallStateView;            private var _isShowIcon:Boolean;            private var _wishingTreeIcon:MovieClip;            public function WishingTreeManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : WishingTreeManager { return null; }
            public function setup() : void { }
            protected function __wishingTreeOpen(event:PkgEvent) : void { }
            private function showEnterIcon() : void { }
            private function hideEnterIcon() : void { }
            public function addEnterIcon($hall:HallStateView) : void { }
            private function disposeEnterIcon() : void { }
            protected function __wishingTreeIconClick(event:MouseEvent) : void { }
            override protected function start() : void { }
            public function get wishingTreeIcon() : MovieClip { return null; }
   }}