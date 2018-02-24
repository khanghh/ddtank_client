package team.view.main
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import team.TeamManager;
   
   public class TeamMainFrame extends Frame
   {
       
      
      private var _infoBtn:SelectedButton;
      
      private var _recordBtn:SelectedButton;
      
      private var _governBtn:SelectedButton;
      
      private var _activeBtn:SelectedButton;
      
      private var _shopBtn:SelectedButton;
      
      private var _memberBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _hBox:HBox;
      
      private var _btnHelp:BaseButton;
      
      private var _rankBtn:BaseButton;
      
      private var _viewList:Array;
      
      public function TeamMainFrame(){super();}
      
      override protected function init() : void{}
      
      protected function __onClickRank(param1:MouseEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      override protected function addChildren() : void{}
      
      private function hideTabAllView() : void{}
      
      private function createView(param1:int) : DisplayObject{return null;}
      
      override protected function onResponse(param1:int) : void{}
      
      private function __onExitTeam(param1:PkgEvent) : void{}
      
      override public function dispose() : void{}
   }
}
