package roomLoading.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.StateManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.TimerEvent;   import gameCommon.GameControl;   import gameCommon.model.GameInfo;      public class SingleBattleMatchingView extends RoomLoadingView   {                   private var _matchTxt:Bitmap;            private var _playerArr:Array;            public function SingleBattleMatchingView($info:GameInfo) { super(null); }
            override protected function init() : void { }
            override protected function __countDownTick(evt:TimerEvent) : void { }
            override protected function initRoomItem(item:RoomLoadingCharacterItem) : void { }
            protected function __onStartLoad(event:Event) : void { }
            override public function dispose() : void { }
   }}