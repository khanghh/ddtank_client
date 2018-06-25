package farm.viewx.helper{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.data.player.SelfInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import farm.FarmEvent;   import farm.FarmModelController;   import farm.modelx.FieldVO;   import farm.viewx.ConfirmHelperMoneyAlertFrame;   import farm.viewx.ManureOrSeedSelectedView;   import farm.viewx.confirmStopHelperFrame;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class FarmHelperView extends Frame   {                   private var _titleBg:DisplayObject;            private var _helperFramBg1:ScaleBitmapImage;            private var _helperFramBg2:ScaleBitmapImage;            private var _onekeyStartBtn:TextButton;            private var _onekeyCloseBtn:TextButton;            private var _helperShowText2:FilterFrameText;            private var _helperShowTime:FilterFrameText;            private var _helperSelSeed:FilterFrameText;            private var _helperSelTime:FilterFrameText;            private var _needSeed:FilterFrameText;            private var _needSeedText:FilterFrameText;            private var _getSeedText:FilterFrameText;            private var _getSeed:FilterFrameText;            private var _getSeedNumOne:int;            private var _getSeedNum:int;            private var _remainTime:FilterFrameText;            private var _helpBtn:TextButton;            private var _farmChoose:ComboBox;            private var _timeChoose:ComboBox;            private var _farmNumChoose:ComboBox;            private var _listArray:Array;            private var _listArrayID:Array;            private var _listSeedNum:Array;            private var _listTimeTextArray:Array;            private var _listTimeArray:Array;            private var _currentTime:int;            private var _currentID:int;            private var _timer:Timer;            private var _timerSeed:Timer;            private var _timeText:FilterFrameText;            private var _timeDiff:int;            private var _autoTime:int;            private var _seedItemInfo:Vector.<ShopItemInfo>;            private var _beginFrame:HelperBeginFrame;            private var _typeString:String;            private var _infoList:Vector.<ShopItemInfo>;            private var _seeSeedBtn:TextButton;            private var _selectedView:ManureOrSeedSelectedView;            private var _configmPnl:ConfirmHelperMoneyAlertFrame;            private var _stopHelpeCconfigm:confirmStopHelperFrame;            private var _modelType:int;            public function FarmHelperView() { super(); }
            private function initView() : void { }
            private function setHelperTime() : void { }
            private function setComboxContent() : void { }
            private function setBtnEna(value:Boolean = true) : void { }
            private function addEvent() : void { }
            private function __onSeeSeed(e:MouseEvent) : void { }
            private function __showHelperTime(pEvent:FarmEvent) : void { }
            public function show() : void { }
            private function __closeFarmHelper(event:FrameEvent) : void { }
            private function __beginHelper(event:FarmEvent) : void { }
            private function __stopHelper(event:FarmEvent) : void { }
            private function __itemClick(event:ListItemEvent) : void { }
            private function __itemClick2(event:ListItemEvent) : void { }
            private function getseedCountByID() : int { return 0; }
            private function findSeedTimebyID(ID:int) : int { return 0; }
            private function __comBoxBtnClick(e:MouseEvent) : void { }
            private function __onekeyStartClick(e:MouseEvent) : void { }
            private function __onekeyCloseClick(e:MouseEvent) : void { }
            private function __confirmStopHelper(event:FarmEvent) : void { }
            private function setTimes() : void { }
            private function __timerSeedHandler(evnet:TimerEvent) : void { }
            private function setGetSeedCount() : void { }
            private function __timerHandler(evnet:TimerEvent) : void { }
            private function getTimeDiff(diff:int) : String { return null; }
            private function fixZero(num:uint) : String { return null; }
            private function removeEvent() : void { }
            private function removeItem() : void { }
            override public function dispose() : void { }
   }}