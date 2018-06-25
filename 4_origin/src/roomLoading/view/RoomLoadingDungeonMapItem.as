package roomLoading.view
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.GameControl;
   import room.RoomManager;
   
   public class RoomLoadingDungeonMapItem extends Sprite implements Disposeable
   {
       
      
      private var _displayMc:MovieClip;
      
      private var _itemFrame:DisplayObject;
      
      private var _item:Sprite;
      
      private var _mapLoader:DisplayLoader;
      
      public function RoomLoadingDungeonMapItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _item = new Sprite();
         _itemFrame = ComponentFactory.Instance.creat("asset.roomLoading.DungeonMapFrame");
         _displayMc = ComponentFactory.Instance.creat("asset.roomloading.displayMC");
         _mapLoader = LoadResourceManager.Instance.createLoader(solveMapPath(),0);
         _mapLoader.addEventListener("complete",__onLoadComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader);
      }
      
      private function __onLoadComplete(event:Event) : void
      {
         var content:* = null;
         if(_mapLoader.isSuccess)
         {
            _mapLoader.removeEventListener("complete",__onLoadComplete);
            content = _mapLoader.content as Bitmap;
            content.height = 365;
            _item.addChild(content);
            _item.addChild(_itemFrame);
            PositionUtils.setPos(_displayMc,"asset.roomLoading.DungeonMapLoaderPos");
            var _loc3_:int = -1;
            _item.scaleX = _loc3_;
            _displayMc.scaleX = _loc3_;
            _displayMc["character"].addChild(_item);
            _displayMc.gotoAndPlay("appear1");
            addChild(_displayMc);
         }
      }
      
      private function solveMapPath() : String
      {
         var id:int = 0;
         var result:String = PathManager.SITE_MAIN + "image/map/";
         if(GameControl.Instance.Current.gameMode == 8)
         {
            result = result + "1133/show.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 15)
         {
            id = RoomManager.Instance.current.mapId;
            if(!(int(id) - 500))
            {
               result = result + "70021/show4.png";
               return result;
            }
            result = result + "214/show1.png";
            return result;
         }
         if(RoomManager.Instance.current.type == 17)
         {
            result = result + "215/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 20)
         {
            result = result + "216/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 67)
         {
            result = result + "1511/show2.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 155)
         {
            result = result + "50000/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 31)
         {
            if(EscortManager.instance.isStart)
            {
               result = result + "1350/show1.png";
            }
            else if(DrgnBoatManager.instance.isStart)
            {
               result = result + "71002/show1.jpg";
            }
            else
            {
               result = result + "217/show1.png";
            }
            return result;
         }
         if(RoomManager.Instance.current.type == 26)
         {
            result = result + "1347/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 48)
         {
            result = result + "1498/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 51)
         {
            result = result + "1511/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 52)
         {
            result = result + "70003/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 49)
         {
            result = result + "1495/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 150)
         {
            result = result + "1217/show1.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 151)
         {
            result = result + "1276/show1.jpg";
            return result;
         }
         var pic:String = GameControl.Instance.Current.missionInfo.pic;
         var pic1:String = RoomManager.Instance.current.pic;
         if(RoomManager.Instance.current.isOpenBoss)
         {
            if(pic1 == null)
            {
               result = result + (RoomManager.Instance.current.mapId + "/show1.jpg");
            }
            else
            {
               result = result + (RoomManager.Instance.current.mapId + "/" + pic1);
            }
         }
         else if(pic == null || RoomManager.Instance.current.type == 21)
         {
            result = result + (RoomManager.Instance.current.mapId + "/show1.jpg");
         }
         else
         {
            result = result + (RoomManager.Instance.current.mapId + "/" + pic);
         }
         return result;
      }
      
      public function disappear() : void
      {
         _displayMc.gotoAndPlay("disappear1");
      }
      
      public function dispose() : void
      {
         _mapLoader.removeEventListener("complete",__onLoadComplete);
         ObjectUtils.disposeAllChildren(this);
         _mapLoader = null;
         _displayMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
