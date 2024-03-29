package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ChatFacePanel extends ChatBasePanel
   {
      
      public static const FIGHT_FACE_ID_START:int = 49;
      
      public static const FIGHT_FACE_ID_END:int = 74;
      
      private static const MAX_FACE_CNT:uint = 72;
      
      private static const COLUMN_LENGTH:uint = 10;
      
      private static const FACE_SPAN:uint = 25;
       
      
      protected var _bg:ScaleBitmapImage;
      
      private var _faceBtns:Vector.<BaseButton>;
      
      private var _inGame:Boolean;
      
      private var _selected:int;
      
      public function ChatFacePanel(param1:Boolean = false){super();}
      
      public function dispose() : void{}
      
      public function get selected() : int{return 0;}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      protected function createBg() : void{}
      
      override protected function init() : void{}
   }
}
