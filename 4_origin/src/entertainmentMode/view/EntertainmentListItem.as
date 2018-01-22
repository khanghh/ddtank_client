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
      
      public function EntertainmentListItem(param1:RoomInfo = null)
      {
         super();
         _info = param1;
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.Entertainment.mode.random");
         addChild(_bg);
         _roomPlayerNumTxt = ComponentFactory.Instance.creat("asset.entertainment.roomPlayerNum");
         addChild(_roomPlayerNumTxt);
         update();
      }
      
      public function set info(param1:RoomInfo) : void
      {
         _info = param1;
         update();
      }
      
      public function get info() : RoomInfo
      {
         return _info;
      }
      
      private function update() : void
      {
         if(info)
         {
            _roomPlayerNumTxt.text = String(_info.totalPlayer) + "/" + String(_info.placeCount);
            if(_info.isPlaying)
            {
               filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               filters = null;
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_roomPlayerNumTxt);
         _roomPlayerNumTxt = null;
      }
   }
}
