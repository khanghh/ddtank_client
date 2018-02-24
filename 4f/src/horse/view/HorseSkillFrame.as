package horse.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import horse.HorseManager;
   import road7th.data.DictionaryData;
   import room.view.RoomPropCell;
   import trainer.view.NewHandContainer;
   
   public class HorseSkillFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _upCellsContainer:HBox;
      
      private var _upCells:Vector.<RoomPropCell>;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function HorseSkillFrame(){super();}
      
      private function guideHandler() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function updateSkillStatus(param1:Event) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
