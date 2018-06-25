package demonChiYou.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import demonChiYou.DemonChiYouManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class WorldBossRoomTotalInfoView extends Sprite implements Disposeable   {                   private var _totalInfoBg:ScaleBitmapImage;            private var _totalInfo_time:FilterFrameText;            private var _totalInfo_yourSelf:FilterFrameText;            private var _totalInfo_timeTxt:FilterFrameText;            private var _totalInfo_yourSelfTxt:FilterFrameText;            private var _txtArr:Array;            private var _show_totalInfoBtnIMG:ScaleFrameImage;            private var _open_show:Boolean = true;            private var _show_totalInfoBtn:SimpleBitmapButton;            private var _mgr:DemonChiYouManager;            private var _getRankTimer:Timer;            private var _leftTimeTimer:Timer;            private var _leftSec:int;            public function WorldBossRoomTotalInfoView() { super(); }
            private function initView() : void { }
            private function onGetRankTimer(evt:TimerEvent) : void { }
            private function onUpdateLeftTime(evt:TimerEvent) : void { }
            private function creatTxtInfo() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function onBossEnd(evt:Event) : void { }
            private function onGetRankInfoBack(evt:Event) : void { }
            private function formatName(name:String) : String { return null; }
            private function __showTotalInfo(evt:MouseEvent) : void { }
            private function __totalViewShowOrHide(evt:Event) : void { }
            public function setRightDown() : void { }
            private function setFormat(value:int) : String { return null; }
            public function dispose() : void { }
   }}