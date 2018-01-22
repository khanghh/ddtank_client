package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import labyrinth.data.RankingInfo;
   import road7th.comm.PackageIn;
   
   public class ArmoryView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBg:ScaleBitmapImage;
      
      private var _closeBtn:BaseButton;
      
      private var _list:ListPanel;
      
      public function ArmoryView(){super();}
      
      private function initView() : void{}
      
      private function sendPkg() : void{}
      
      private function initEvent() : void{}
      
      protected function __getArmoryInfo(param1:PkgEvent) : void{}
      
      public function show() : void{}
      
      private function removeEvent() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
