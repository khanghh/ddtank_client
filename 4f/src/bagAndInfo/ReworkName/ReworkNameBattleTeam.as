package bagAndInfo.ReworkName
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class ReworkNameBattleTeam extends Frame
   {
       
      
      private var _nameErrorTxt:FilterFrameText = null;
      
      private var _tagErrorTxt:FilterFrameText = null;
      
      private var _nameInput:FilterFrameText = null;
      
      private var _tagInput:FilterFrameText = null;
      
      private var _nameCheck:TextButton = null;
      
      private var _tagCheck:TextButton = null;
      
      private var _submit:TextButton = null;
      
      private var _tagErrorImg:ScaleFrameImage = null;
      
      private var _nameErrorImg:ScaleFrameImage = null;
      
      private var _bagType:int = -1;
      
      private var _place:int = -1;
      
      public function ReworkNameBattleTeam(){super();}
      
      public function initialize(param1:int, param2:int) : void{}
      
      private function initEvent() : void{}
      
      private function __onCheckInput(param1:PkgEvent) : void{}
      
      private function __onChangeResult(param1:PkgEvent) : void{}
      
      private function getErrorDesc(param1:int, param2:Boolean, param3:int = 0) : String{return null;}
      
      private function onClickHander(param1:MouseEvent) : void{}
      
      protected function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function initView() : void{}
      
      override public function dispose() : void{}
   }
}
