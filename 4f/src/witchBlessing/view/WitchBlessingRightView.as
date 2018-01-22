package witchBlessing.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import witchBlessing.WitchBlessingController;
   import witchBlessing.WitchBlessingManager;
   import witchBlessing.data.WitchBlessingPackageInfo;
   
   public class WitchBlessingRightView extends Sprite implements Disposeable
   {
       
      
      private var blessingLV:int = 1;
      
      private var _rightViewMidBg:Bitmap;
      
      private var _rightViewSmallBg:Bitmap;
      
      private var _noBlessing:Bitmap;
      
      private var _AwardsView:Sprite;
      
      private var _awardsTxt:FilterFrameText;
      
      private var _awardsTxt1:FilterFrameText;
      
      private var _awardsTxt2:FilterFrameText;
      
      private var _nextTimeTxt:FilterFrameText;
      
      private var propertyArr1:Array;
      
      private var propertyArr2:Array;
      
      private var property1:Array;
      
      private var property2:Array;
      
      private var _getAwardsBtn:BaseButton;
      
      private var _getDoubleAwardsBtn:BaseButton;
      
      private var cdTime:int = 0;
      
      private var _timer:Timer;
      
      private var canGetAwardsFlag:Boolean = false;
      
      private var awardsNum:int;
      
      private var allNum:int;
      
      private var doubleMoney:int = 0;
      
      private var sec:int;
      
      private var min:int;
      
      private var hour:int;
      
      private var str:String;
      
      public function WitchBlessingRightView(param1:int, param2:int = 0, param3:int = 0){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function getAwardsFunc(param1:MouseEvent) : void{}
      
      private function getDoubleAwardsFunc(param1:MouseEvent) : void{}
      
      private function __getDoubleAwards(param1:FrameEvent) : void{}
      
      private function __onNoMoneyResponse(param1:FrameEvent) : void{}
      
      private function __timer(param1:TimerEvent) : void{}
      
      private function timeCountingFunc() : void{}
      
      public function cannotBlessing(param1:Boolean) : void{}
      
      private function isCanGetAwards(param1:Boolean) : void{}
      
      private function transSecond(param1:Number) : String{return null;}
      
      public function flushCDTime(param1:int) : void{}
      
      public function flushGetAwardsTimes(param1:int) : void{}
      
      private function initAwards() : void{}
      
      public function dispose() : void{}
   }
}
