package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.GameControl;
   import ringStation.RingStationControl;
   import road7th.comm.PackageIn;
   import trainer.view.NewHandContainer;
   
   public class RingStationView extends Frame
   {
      
      private static var CHALLENGEPERSON_NUM:int = 4;
       
      
      private var _titleBitmap:Bitmap;
      
      private var _frameBottom:ScaleBitmapImage;
      
      private var _helpBtn:BaseButton;
      
      private var _userView:StationUserView;
      
      private var _challengeVec:Vector.<ChallengePerson>;
      
      private var _arrowSrite:Sprite;
      
      private var _nameArray:Array;
      
      public function RingStationView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      private function sendPkg() : void{}
      
      protected function __setViewInfo(param1:PkgEvent) : void{}
      
      private function readPersonInfo(param1:PackageIn) : PlayerInfo{return null;}
      
      public function show() : void{}
      
      private function removeEvent() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
