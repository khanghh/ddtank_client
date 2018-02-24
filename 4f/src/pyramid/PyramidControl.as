package pyramid
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PyramidModel;
   import ddt.events.PyramidEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PyramidManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   
   public class PyramidControl extends EventDispatcher
   {
      
      private static var _instance:PyramidControl;
       
      
      private var _movieLock:Boolean = false;
      
      private var _clickRate:Number = 0;
      
      public var isShowBuyFrameSelectedCheck:Boolean = true;
      
      public var isShowReviveBuyFrameSelectedCheck:Boolean = true;
      
      public var isShowAutoOpenFrameSelectedCheck:Boolean = true;
      
      private var _isAutoOpenCard:Boolean = false;
      
      private var _hall:HallStateView;
      
      private var _tipsframe:BaseAlerFrame;
      
      private var _selectedCheckButton:SelectedCheckButton;
      
      private var _tipsType:int;
      
      private var _tipsData:Object;
      
      public var autoCount:int;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _text:FilterFrameText;
      
      public function PyramidControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : PyramidControl{return null;}
      
      public function set movieLock(param1:Boolean) : void{}
      
      public function get movieLock() : Boolean{return false;}
      
      public function get isAutoOpenCard() : Boolean{return false;}
      
      public function set isAutoOpenCard(param1:Boolean) : void{}
      
      public function get clickRateGo() : Boolean{return false;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      private function __onStartOrStop(param1:PyramidEvent) : void{}
      
      private function __onCardResult(param1:PyramidEvent) : void{}
      
      private function __onDieEvent(param1:PyramidEvent) : void{}
      
      private function __onScoreConvert(param1:PyramidEvent) : void{}
      
      public function onClickPyramidIcon(param1:MouseEvent) : void{}
      
      public function showFrame(param1:int, param2:Object = null) : void{}
      
      private function __seleterChange(param1:Event) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function __onselectedCheckButtoClick(param1:MouseEvent) : void{}
      
      private function tipsDispose() : void{}
      
      public function clearFrame() : void{}
   }
}
