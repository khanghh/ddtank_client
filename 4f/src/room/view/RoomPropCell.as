package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.horse.HorseSkillCell;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   
   public class RoomPropCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _container:HorseSkillCell;
      
      protected var _skillId:int;
      
      protected var _isself:Boolean;
      
      protected var _place:int;
      
      private var _xyz:FilterFrameText;
      
      public function RoomPropCell(param1:Boolean, param2:int, param3:Boolean = false){super();}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function set skillId(param1:int) : void{}
      
      protected function __mouseClick(param1:MouseEvent) : void{}
      
      private function __mouseOver(param1:MouseEvent) : void{}
      
      private function __mouseOut(param1:MouseEvent) : void{}
      
      override public function get width() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
