package ddt.view.im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.IMManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import im.PresentRecordInfo;
   
   public class MessageBoxItem extends Sprite implements Disposeable
   {
      
      public static const DELETE:String = "delete";
       
      
      private var _recordInfo:PresentRecordInfo;
      
      private var _hotArea:Sprite;
      
      private var _stateImg:ScaleFrameImage;
      
      private var _sex:ScaleFrameImage;
      
      private var _name:FilterFrameText;
      
      private var _delete:SimpleBitmapButton;
      
      private var _newSign:Bitmap;
      
      private var _team:Bitmap;
      
      private var _PlayerInfo:PlayerInfo;
      
      public function MessageBoxItem(){super();}
      
      override public function get height() : Number{return 0;}
      
      protected function __deleteHandler(param1:MouseEvent) : void{}
      
      protected function __outHandler(param1:MouseEvent) : void{}
      
      protected function __overHandler(param1:MouseEvent) : void{}
      
      public function set recordInfo(param1:PresentRecordInfo) : void{}
      
      protected function __infoHandler(param1:Event) : void{}
      
      public function get recordInfo() : PresentRecordInfo{return null;}
      
      public function dispose() : void{}
   }
}
