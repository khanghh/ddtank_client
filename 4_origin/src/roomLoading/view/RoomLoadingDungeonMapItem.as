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
      
      private function __onLoadComplete(param1:Event) : void
      {
         var _loc2_:* = null;
         if(_mapLoader.isSuccess)
         {
            _mapLoader.removeEventListener("complete",__onLoadComplete);
            _loc2_ = _mapLoader.content as Bitmap;
            _loc2_.height = 365;
            _item.addChild(_loc2_);
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
         var _loc2_:int = 0;
         var _loc3_:String = PathManager.SITE_MAIN + "image/map/";
         if(GameControl.Instance.Current.gameMode == 8)
         {
            _loc3_ = _loc3_ + "1133/show.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 15)
         {
            _loc2_ = RoomManager.Instance.current.mapId;
            if(!(int(_loc2_) - 500))
            {
               _loc3_ = _loc3_ + "70021/show4.png";
               return _loc3_;
            }
            _loc3_ = _loc3_ + "214/show1.png";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 17)
         {
            _loc3_ = _loc3_ + "215/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 20)
         {
            _loc3_ = _loc3_ + "216/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 67)
         {
            _loc3_ = _loc3_ + "1511/show2.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 155)
         {
            _loc3_ = _loc3_ + "50000/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 31)
         {
            if(EscortManager.instance.isStart)
            {
               _loc3_ = _loc3_ + "1350/show1.png";
            }
            else if(DrgnBoatManager.instance.isStart)
            {
               _loc3_ = _loc3_ + "71002/show1.jpg";
            }
            else
            {
               _loc3_ = _loc3_ + "217/show1.png";
            }
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 26)
         {
            _loc3_ = _loc3_ + "1347/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 48)
         {
            _loc3_ = _loc3_ + "1498/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 51)
         {
            _loc3_ = _loc3_ + "1511/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 52)
         {
            _loc3_ = _loc3_ + "70003/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 49)
         {
            _loc3_ = _loc3_ + "1495/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 150)
         {
            _loc3_ = _loc3_ + "1217/show1.jpg";
            return _loc3_;
         }
         if(RoomManager.Instance.current.type == 151)
         {
            _loc3_ = _loc3_ + "1276/show1.jpg";
            return _loc3_;
         }
         var _loc4_:String = GameControl.Instance.Current.missionInfo.pic;
         var _loc1_:String = RoomManager.Instance.current.pic;
         if(RoomManager.Instance.current.isOpenBoss)
         {
            if(_loc1_ == null)
            {
               _loc3_ = _loc3_ + (RoomManager.Instance.current.mapId + "/show1.jpg");
            }
            else
            {
               _loc3_ = _loc3_ + (RoomManager.Instance.current.mapId + "/" + _loc1_);
            }
         }
         else if(_loc4_ == null || RoomManager.Instance.current.type == 21)
         {
            _loc3_ = _loc3_ + (RoomManager.Instance.current.mapId + "/show1.jpg");
         }
         else
         {
            _loc3_ = _loc3_ + (RoomManager.Instance.current.mapId + "/" + _loc4_);
         }
         return _loc3_;
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
