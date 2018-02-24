package memoryGame.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import memoryGame.MemoryGameManager;
   
   public class MemoryGameCell extends Sprite implements Disposeable
   {
      
      private static const TURN_EVENT:String = "turnComplete";
      
      private static const PLAY_OPEN_COMPLETE:String = "playOpenComplete";
      
      private static const PLAY_CLOSE_COMPLETE:String = "playCloseComplete";
       
      
      private var _index:int = 0;
      
      private var _isOpen:Boolean;
      
      private var _turnMC:MovieClip;
      
      private var _cell:BagCell;
      
      public function MemoryGameCell(param1:int){super();}
      
      private function init() : void{}
      
      public function open(param1:int, param2:int) : void{}
      
      public function close() : void{}
      
      public function openDefault(param1:int, param2:int) : void{}
      
      public function closeDefault() : void{}
      
      public function shine() : void{}
      
      private function setInfo(param1:int, param2:int) : void{}
      
      private function __onTurnComplete(param1:Event) : void{}
      
      private function __onPlayOpenComplete(param1:Event) : void{}
      
      private function __onPlayCloseComplete(param1:Event) : void{}
      
      private function createCell(param1:int = 11096) : BagCell{return null;}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function get index() : int{return 0;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function dispose() : void{}
   }
}
