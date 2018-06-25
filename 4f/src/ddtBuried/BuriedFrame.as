package ddtBuried{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddtBuried.event.BuriedEvent;   import ddtBuried.views.BuriedRewardsProgressBar;   import ddtBuried.views.BuriedView;   import ddtBuried.views.DiceView;   import trainer.view.NewHandContainer;      public class BuriedFrame extends Frame   {            private static const MAP1:int = 1;            private static const MAP2:int = 2;            private static const MAP3:int = 3;                   private var _buriedView:BuriedView;            private var _diceView:DiceView;            private var _rewardsProgressBar:BuriedRewardsProgressBar;            private var _type:int;            public function BuriedFrame() { super(); }
            private function initView() : void { }
            public function addRewardsProgressBar() : void { }
            public function updateProgressBar() : void { }
            public function updatePlayGainedAnimation(index:int) : void { }
            public function updateShowGetRewardBoxAnimation(index:int) : void { }
            public function addDiceView(type:int) : void { }
            public function setStarList(num:int) : void { }
            public function updataStarLevel(num:int) : void { }
            public function setCrFrame(str:String) : void { }
            public function setTxt(str:String, $visible:Boolean = true) : void { }
            public function play() : void { }
            public function upDataBtn() : void { }
            private function addEvent() : void { }
            private function removeEvents() : void { }
            private function openBuriedHander(e:BuriedEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}