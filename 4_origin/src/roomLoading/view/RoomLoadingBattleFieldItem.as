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
      
      public function RoomLoadingBattleFieldItem(mapId:int = -1)
      {
         super();
         if(RoomManager.Instance.current.mapId > 0)
         {
            mapId = RoomManager.Instance.current.mapId;
         }
         _mapId = mapId;
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
      
      private function __onScaleBitmapLoaded(pEvent:UIModuleEvent) : void
      {
         if(pEvent.module == "ddtcorescalebitmap")
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
      
      private function __onLoadComplete(evt:LoaderEvent) : void
      {
         if(evt.currentTarget.isSuccess)
         {
            if(evt.currentTarget == _mapLoader)
            {
               _map = PositionUtils.setPos(Bitmap(_mapLoader.content),"roomLoading.BattleFieldItemMapPos");
               _map = Bitmap(_mapLoader.content);
            }
            else if(evt.currentTarget == _fieldNameLoader)
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
      
      private function solveMapPath(type:int) : String
      {
         var imgName:String = "samll_map";
         if(RoomManager.Instance.current.dungeonType == 4)
         {
            imgName = imgName + "_e";
         }
         if(type == 2)
         {
            imgName = "icon";
         }
         var result:String = PathManager.SITE_MAIN + "image/map/";
         if(GameControl.Instance.Current && GameControl.Instance.Current.gameMode == 8)
         {
            result = result + ("1133/" + imgName + ".png");
            return result;
         }
         if(RoomManager.Instance.current.type == 15 && type != 2)
         {
            if(!(int(RoomManager.Instance.current.mapId) - 500))
            {
               result = result + "70021/samll_map.png";
            }
            else
            {
               result = result + "214/samll_map.png";
            }
            return result;
         }
         if(RoomManager.Instance.current.type == 20 && type != 2 && GameControl.Instance.Current.gameMode == 24)
         {
            result = result + "216/samll_map.jpg";
            return result;
         }
         if(RoomManager.Instance.current.type == 49 && type != 2)
         {
            result = result + "1495/samll_map.png";
            return result;
         }
         if(RoomManager.Instance.current.type == 155 && type != 2)
         {
            result = result + "50000/samll_map.png";
            return result;
         }
         if(RoomManager.Instance.current.type == 31 && type != 2)
         {
            if(EscortManager.instance.isStart)
            {
               result = result + "1350/samll_map.png";
            }
            else if(DrgnBoatManager.instance.isStart)
            {
               result = result + "71002/samll_map.png";
            }
            else
            {
               result = result + "217/samll_map.png";
            }
            return result;
         }
         if(RoomManager.Instance.current.type == 52)
         {
            result = result + ("70003/" + imgName + ".png");
            return result;
         }
         result = result + (_mapId.toString() + "/" + imgName + ".png");
         return result;
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
