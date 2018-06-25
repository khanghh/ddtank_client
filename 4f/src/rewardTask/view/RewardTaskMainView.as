package rewardTask.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.NumberImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.HelpFrameUtils;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import magicStone.components.MagicStoneConfirmView;   import rewardTask.RewardTaskControl;      public class RewardTaskMainView extends Frame   {                   private var _bg:Bitmap;            private var _btnHelp:BaseButton;            private var _questView:RewardTaskItem;            private var _multiplemax:Bitmap;            private var _multipleX:Bitmap;            private var _number:NumberImage;            private var _refreshRewardBtn:SimpleBitmapButton;            private var _refreshTaskBtn:SimpleBitmapButton;            private var _taskNumberText:FilterFrameText;            private var _addTaskNumberBtn:SimpleBitmapButton;            private var _vipBuyNumText:FilterFrameText;            private var _multipleStatus:Boolean;            private var _addNumberStatus:Boolean;            private var _taskStatus:Boolean;            private var _clickTime:Number;            public function RewardTaskMainView() { super(); }
            public function show() : void { }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            private function __addTaskNumberClick(e:MouseEvent) : void { }
            private function __onAddTaskNumber(e:FrameEvent) : void { }
            private function __onClickrefreshReward(e:MouseEvent) : void { }
            private function __onRefreshRewardResponse(e:FrameEvent) : void { }
            private function __onClickRefreshTask(e:MouseEvent) : void { }
            private function __onRefreshTaskResponse(e:FrameEvent) : void { }
            private function __onRefreshQuest(e:PkgEvent) : void { }
            private function __onAddTimes(e:PkgEvent) : void { }
            private function __onRefreshReward(e:PkgEvent) : void { }
            private function __onUpdateItems(e:PkgEvent) : void { }
            private function __onAceptQuest(e:PkgEvent) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function updateView() : void { }
            override protected function onFrameClose() : void { }
            override public function dispose() : void { }
   }}