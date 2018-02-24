package farm.viewx.poultry
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   
   public class FarmTreeUpgrade extends BaseAlerFrame
   {
       
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _bg:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _titleImage:MutipleImage;
      
      private var _loveBg:BaseButton;
      
      private var _loveNum:FilterFrameText;
      
      private var _callBtn:BaseButton;
      
      private var _levelNum:int;
      
      private var _control:DisplayObject;
      
      private var _upgradingFlag:Boolean;
      
      public function FarmTreeUpgrade(){super();}
      
      private function sendPkg() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onUpgrading(param1:FarmEvent) : void{}
      
      protected function __onSetCallBtnEnable(param1:FarmEvent) : void{}
      
      protected function __onInitData(param1:PkgEvent) : void{}
      
      protected function __onCallBtnClick(param1:MouseEvent) : void{}
      
      protected function __onHelpBtnClick(param1:MouseEvent) : void{}
      
      private function __closeFarm(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
