package luckStar{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import luckStar.event.LuckStarEvent;   import luckStar.manager.LuckStarManager;   import luckStar.view.LuckStarFrame;      public class LuckStarController   {            private static var _instance:LuckStarController;                   private var _frame:LuckStarFrame;            public function LuckStarController(pct:PrivateClass) { super(); }
            public static function get Instance() : LuckStarController { return null; }
            public function setup() : void { }
            private function __onLoaderLuckStarIcon(evt:Event) : void { }
            private function __onOpenLuckStarFrame(evt:Event) : void { }
            private function __onFrameClose(e:FrameEvent) : void { }
            private function _onLuckyStarEvent(e:LuckStarEvent) : void { }
            private function __onUpdateReward(evt:Event) : void { }
            private function __onTurnGoodsInfo(evt:Event) : void { }
            private function __onAllGoodsInfo(evt:Event) : void { }
            public function updateLuckyStarRank(value:Object) : void { }
            public function get openState() : Boolean { return false; }
   }}class PrivateClass{          function PrivateClass() { super(); }
}