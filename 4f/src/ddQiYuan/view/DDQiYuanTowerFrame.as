package ddQiYuan.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddQiYuan.DDQiYuanController;   import ddQiYuan.DDQiYuanManager;   import ddQiYuan.model.DDQiYuanModel;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.HelpFrameUtils;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Timer;      public class DDQiYuanTowerFrame extends Frame   {                   private var _bg:Image;            private var _btnHelp:BaseButton;            private var _leftTimeTf:FilterFrameText;            private var _model:DDQiYuanModel;            private var _btnArr:Array;            private var _timer:Timer;            public function DDQiYuanTowerFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function onTimerTick(evt:TimerEvent) : void { }
            private function onClick(evt:MouseEvent) : void { }
            private function setBtnState(index:int) : void { }
            private function responseHandler(evt:FrameEvent) : void { }
            private function onGainRewardBack(evt:CEvent) : void { }
            override public function dispose() : void { }
   }}