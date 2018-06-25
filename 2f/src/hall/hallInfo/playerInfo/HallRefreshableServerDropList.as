package hall.hallInfo.playerInfo{   import com.greensock.TweenMax;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import ddt.manager.ServerManager;   import ddt.manager.SocketManager;   import flash.events.Event;   import flash.events.MouseEvent;   import serverlist.view.ServerDropList;      public class HallRefreshableServerDropList extends ServerDropList   {                   private var _refreshBtn:SimpleBitmapButton;            public function HallRefreshableServerDropList() { super(); }
            override protected function initEvent() : void { }
            protected function __changeServerHandler(event:Event) : void { }
            override protected function initView() : void { }
            protected function onRefreshClick(e:MouseEvent) : void { }
            private function refreshBtnEnable() : void { }
            override public function dispose() : void { }
   }}