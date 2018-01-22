package roomLoading.view
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   import room.RoomManager;
   
   public class RoomLoadingBattleFieldItem extends Sprite implements Disposeable
   {
       
      
      private var _mapId:int;
      
      private var _bg:Image;
      
      private var _mapLoader:DisplayLoader;
      
      private var _fieldBg:Bitmap;
      
      private var _fieldNameLoader:DisplayLoader;
      
      private var _map:Bitmap;
      
      private var _fieldName:Bitmap;
      
      public function RoomLoadingBattleFieldItem(param1:int = -1)
      {
         super();
         if(RoomManager.Instance.current.mapId > 0)
         {
            param1 = RoomManager.Instance.current.mapId;
         }
         _mapId = param1;
         try
         {
            init();
            return;
         }
         catch(error:Error)
         {
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onScaleBitmapLoaded);
            UIModuleLoader.Instance.addUIModuleImp("ddtcorescalebitmap");
            return;
         }
      }
      
      private function __onScaleBitmapLoaded(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtcorescalebitmap")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onScaleBitmapLoaded);
            init();
         }
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("roomloading.MapFrameBg");
         _fieldBg = ComponentFactory.Instance.creatBitmap("asset.roomloading.battleItemTxt");
         addChild(_bg);
         _mapLoader = LoadResourceManager.Instance.createLoader(solveMapPath(1),0);
         _mapLoader.addEventListener("complete",__onLoadComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader);
         _fieldNameLoader = LoadResourceManager.Instance.createLoader(solveMapPath(2),0);
         _fieldNameLoader.addEventListener("complete",__onLoadComplete);
         LoadResourceManager.Instance.startLoad(_fieldNameLoader);
      }
      
      private function __onLoadComplete(param1:LoaderEvent) : void
      {
         if(param1.currentTarget.isSuccess)
         {
            if(param1.currentTarget == _mapLoader)
            {
               _map = PositionUtils.setPos(Bitmap(_mapLoader.content),"roomLoading.BattleFieldItemMapPos");
               _map = Bitmap(_mapLoader.content);
            }
            else if(param1.currentTarget == _fieldNameLoader)
            {
               _fieldName = PositionUtils.setPos(Bitmap(_fieldNameLoader.content),"roomLoading.BattleFieldItemNamePos");
               _fieldName = Bitmap(_fieldNameLoader.content);
            }
         }
         if(_map)
         {
            addChild(_map);
         }
         addChild(_fieldBg);
         if(_fieldName)
         {
            addChild(_fieldName);
         }
      }
      
      private function solveMapPath(param1:int) : String
      {
         var _loc3_:String = "samll_map";
         if(RoomManager.Instance.current.dungeonType == 4)
         {
            _loc3_ = _loc3_ + "_e";
         }
         if(param1 == 2)
         {
            _loc3_ = "icon";
         }
         var _loc2_:String = PathManager.SITE_MAIN + "image/map/";
         if(GameControl.Instance.Current && GameControl.Instance.Current.gameMode == 8)
         {
            _loc2_ = _loc2_ + ("1133/" + _loc3_ + ".png");
            return _loc2_;
         }
         if(RoomManager.Instance.current.type == 15 && param1 != 2)
         {
            if(!(int(RoomManager.Instance.current.mapId) - 500))
            {
               _loc2_ = _loc2_ + "70021/samll_map.png";
            }
            else
            {
               _loc2_ = _loc2_ + "214/samll_map.png";
            }
            return _loc2_;
         }
         if(RoomManager.Instance.current.type == 20 && param1 != 2 && GameControl.Instance.Current.gameMode == 24)
         {
            _loc2_ = _loc2_ + "216/samll_map.jpg";
            return _loc2_;
         }
         if(RoomManager.Instance.current.type == 49 && param1 != 2)
         {
            _loc2_ = _loc2_ + "1495/samll_map.png";
            return _loc2_;
         }
         if(RoomManager.Instance.current.type == 155 && param1 != 2)
         {
            _loc2_ = _loc2_ + "50000/samll_map.png";
            return _loc2_;
         }
         if(RoomManager.Instance.current.type == 31 && param1 != 2)
         {
            if(EscortManager.instance.isStart)
            {
               _loc2_ = _loc2_ + "1350/samll_map.png";
            }
            else if(DrgnBoatManager.instance.isStart)
            {
               _loc2_ = _loc2_ + "71002/samll_map.png";
            }
            else
            {
               _loc2_ = _loc2_ + "217/samll_map.png";
            }
            return _loc2_;
         }
         if(RoomManager.Instance.current.type == 52)
         {
            _loc2_ = _loc2_ + ("70003/" + _loc3_ + ".png");
            return _loc2_;
         }
         _loc2_ = _loc2_ + (_mapId.toString() + "/" + _loc3_ + ".png");
         return _loc2_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _mapLoader.removeEventListener("complete",__onLoadComplete);
         _fieldNameLoader.removeEventListener("complete",__onLoadComplete);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
