package entertainmentMode.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import room.model.RoomInfo;
   
   public class EntertainmentListItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _roomPlayerNumTxt:FilterFrameText;
      
      private var _info:RoomInfo;
      
      public function EntertainmentListItem(param1:RoomInfo = null){super();}
      
      private function init() : void{}
      
      public function set info(param1:RoomInfo) : void{}
      
      public function get info() : RoomInfo{return null;}
      
      private function update() : void{}
      
      public function dispose() : void{}
   }
}
