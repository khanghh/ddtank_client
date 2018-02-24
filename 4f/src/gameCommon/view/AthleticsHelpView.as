package gameCommon.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.view.smallMap.GameTurnButton;
   
   public class AthleticsHelpView extends DungeonHelpView
   {
       
      
      private var _closeRect:Rectangle;
      
      public function AthleticsHelpView(param1:GameTurnButton, param2:DungeonInfoView, param3:DisplayObjectContainer){super(null,null,null);}
      
      override protected function init() : void{}
      
      override protected function __timerComplete(param1:TimerEvent) : void{}
      
      override public function defaultClose() : void{}
      
      override protected function __closeHandler(param1:MouseEvent) : void{}
   }
}
