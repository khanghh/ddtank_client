package roomList.pvpRoomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class RoomLookUpView extends Sprite implements Disposeable
   {
       
      
      private var _hallType:int;
      
      private var _bg:Scale9CornerImage;
      
      private var _inputText:TextInput;
      
      private var _lookup:Bitmap;
      
      private var _enterBtn:TextButton;
      
      private var _flushBtn:TextButton;
      
      private var _dividingLine:Bitmap;
      
      private var _updateClick:Function;
      
      public function RoomLookUpView(param1:Function, param2:int){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      protected function __onKeyDown(param1:KeyboardEvent) : void{}
      
      private function __updateClick(param1:MouseEvent) : void{}
      
      protected function __onStageClick(param1:MouseEvent) : void{}
      
      protected function __textClick(param1:MouseEvent) : void{}
      
      protected function __onEnterBtnClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
