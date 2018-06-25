package roomList.pveRoomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import roomList.pvpRoomList.RoomListPlayerListView;
   
   public class DungeonRoomListPlayerListView extends RoomListPlayerListView implements Disposeable
   {
       
      
      public function DungeonRoomListPlayerListView(data:DictionaryData)
      {
         super(data);
      }
      
      override protected function initbg() : void
      {
         var i:int = 0;
         _characterBg = ClassUtils.CreatInstance("asset.ddtroomlist.pve.characterbg") as MovieClip;
         PositionUtils.setPos(_characterBg,"asset.ddtRoomlist.pvp.left.characterbgpos");
         addChild(_characterBg);
         _propbg = ClassUtils.CreatInstance("asset.ddtroomlist.pve.proprbg") as MovieClip;
         PositionUtils.setPos(_propbg,"asset.ddtRoomlist.pvp.left.propbgpos");
         addChild(_propbg);
         _listbg2 = ClassUtils.CreatInstance("asset.ddtroomlist.pve.playerListbg") as MovieClip;
         addChild(_listbg2);
         PositionUtils.setPos(_listbg2,"asset.ddtRoomlist.pve.listbgPos");
         _buffbgVec = new Vector.<Bitmap>(6);
         var startPos:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtRoomlist.pvp.buffbgpos");
         for(i = 0; i < 6; )
         {
            _buffbgVec[i] = ComponentFactory.Instance.creatBitmap("asset.ddtroomlist.pve.propCellBg");
            _buffbgVec[i].x = startPos.x + (_buffbgVec[i].width - 1) * i;
            _buffbgVec[i].y = startPos.y;
            addChild(_buffbgVec[i]);
            i++;
         }
      }
      
      override protected function initView() : void
      {
         super.initView();
         PositionUtils.setPos(_level,"asset.ddtRoomlist.pve.Pos1");
         PositionUtils.setPos(_sex,"asset.ddtRoomlist.pve.Pos2");
      }
   }
}
