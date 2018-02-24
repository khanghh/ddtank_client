package roomList.pvpRoomList
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import roomList.RoomListEnumerate;
   
   public class RoomListCreateRoomView extends BaseAlerFrame implements Disposeable
   {
       
      
      protected var _athleticsBg:Bitmap;
      
      protected var _athleticsBtn:SimpleBitmapButton;
      
      protected var _bg:Bitmap;
      
      protected var _checkBox:SelectedCheckButton;
      
      protected var _createRoomBitmap:Bitmap;
      
      protected var _explainTxt:FilterFrameText;
      
      protected var _exploreBtn:SimpleBitmapButton;
      
      protected var _passBtn:SimpleBitmapButton;
      
      protected var _passTxt:TextInput;
      
      protected var _roomModelBitmap:Bitmap;
      
      protected var _textBG:ScaleFrameImage;
      
      protected var _textbg:Bitmap;
      
      protected var _alertInfo:AlertInfo;
      
      public function RoomListCreateRoomView(){super();}
      
      protected function initContainer() : void{}
      
      private function initEvent() : void{}
      
      private function __btnClick(param1:MouseEvent) : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      protected function __passBtnClick(param1:MouseEvent) : void{}
      
      private function __checkBoxClick(param1:MouseEvent) : void{}
      
      private function __passKeyDown(param1:KeyboardEvent) : void{}
      
      private function upadtePassTextBg() : void{}
      
      protected function submit() : void{}
      
      protected function hide() : void{}
      
      override public function dispose() : void{}
   }
}
