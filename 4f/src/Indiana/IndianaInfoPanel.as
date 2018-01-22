package Indiana
{
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.model.IndianaShowData;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import road7th.utils.DateUtils;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class IndianaInfoPanel extends Sprite implements Disposeable
   {
       
      
      private var _progressBar:IndianaProgressBar;
      
      private var _hasJoin:FilterFrameText;
      
      private var _totleJoin:FilterFrameText;
      
      private var _line:MutipleImage;
      
      private var _timesDis:FilterFrameText;
      
      private var _timesDis1:FilterFrameText;
      
      private var _timesDisII:FilterFrameText;
      
      private var _times:TextInput;
      
      private var _timesBg:ScaleBitmapImage;
      
      private var _addTimeBtn:BaseButton;
      
      private var _subtractTimeBtn:BaseButton;
      
      private var _timeHelpBtn:BaseButton;
      
      private var _indianaBtn:BaseButton;
      
      private var _indianaDis:FilterFrameText;
      
      private var _lookNumSelf:FilterFrameText;
      
      private var _indianaDisII:FilterFrameText;
      
      private var _countDown:MovieClip;
      
      private var _scoller:ScrollPanel;
      
      private var _secondNum01:NumberImage;
      
      private var _secondNum02:NumberImage;
      
      private var _minuteNum01:NumberImage;
      
      private var _minuteNum02:NumberImage;
      
      private var _hourNum01:NumberImage;
      
      private var _hourNum02:NumberImage;
      
      private var _hourNum03:NumberImage;
      
      private var _itemDisBg:Bitmap;
      
      private var _info:IndianaShopItemInfo;
      
      private var _itemInfo:IndianaGoodsItemInfo;
      
      private var _timer:TimerJuggler;
      
      private var _countDownDate:Number;
      
      private var _endtimer:Date;
      
      private var showdata:IndianaShowData;
      
      private var countDownComplete:Boolean = false;
      
      private var baseAlerFrame:BaseAlerFrame;
      
      private var time:int;
      
      public function IndianaInfoPanel(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __overTimeHandler(param1:MouseEvent) : void{}
      
      private function __outTimeHandler(param1:MouseEvent) : void{}
      
      private function __txtChangeHandler(param1:Event) : void{}
      
      private function setTimesTips() : void{}
      
      private function __outFocusHandler(param1:FocusEvent) : void{}
      
      private function __inputHandler(param1:TextEvent) : void{}
      
      private function __linkHandler(param1:TextEvent) : void{}
      
      private function __TimerHander(param1:Event) : void{}
      
      private function setDownValue(param1:int, param2:int, param3:int) : void{}
      
      private function __TimerCompleteHander(param1:Event) : void{}
      
      public function setInfo(param1:IndianaShopItemInfo) : void{}
      
      private function __indianaBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __onAlertBuyStiveFrame(param1:FrameEvent) : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      private function __subClickHandler(param1:MouseEvent) : void{}
      
      private function __addClickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
