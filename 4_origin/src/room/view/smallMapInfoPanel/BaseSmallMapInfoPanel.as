package room.view.smallMapInfoPanel
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import room.model.RoomInfo;
   
   public class BaseSmallMapInfoPanel extends Sprite implements Disposeable
   {
      
      protected static const DEFAULT_MAP_ID:String = "10000";
       
      
      protected var _info:RoomInfo;
      
      private var _bg:MutipleImage;
      
      private var _word:Bitmap;
      
      private var _smallMapIcon:Bitmap;
      
      private var _smallMapContainer:Sprite;
      
      private var _loader:DisplayLoader;
      
      private var _rect:Rectangle;
      
      private var _maskShape:Shape;
      
      public function BaseSmallMapInfoPanel()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMapInfo.bg");
         addChild(_bg);
         _word = ComponentFactory.Instance.creatBitmap("asset.ddtroom.smallMapInfo.word");
         addChild(_word);
         _smallMapContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.smallMapInfoPanel.smallMapContainer");
         addChild(_smallMapContainer);
         _loader = LoadResourceManager.Instance.createLoader(solvePath(),0);
         _loader.addEventListener("complete",__completeHandler);
         LoadResourceManager.Instance.startLoad(_loader);
         _rect = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.smallInfoPanel.imageRect");
         _maskShape = new Shape();
         _maskShape.graphics.beginFill(0,0);
         _maskShape.graphics.drawRect(_rect.x,_rect.y,_rect.width,_rect.height);
         _maskShape.graphics.endFill();
         addChild(_maskShape);
      }
      
      protected function solvePath() : String
      {
         if(_info && _info.mapId > 0)
         {
            return PathManager.SITE_MAIN + "image/map/" + _info.mapId.toString() + "/samll_map.png";
         }
         return PathManager.SITE_MAIN + "image/map/" + "10000" + "/samll_map.png";
      }
      
      protected function __completeHandler(param1:LoaderEvent) : void
      {
         if(_loader)
         {
            _loader.removeEventListener("complete",__completeHandler);
         }
         if(_loader.isSuccess)
         {
            ObjectUtils.disposeAllChildren(_smallMapContainer);
            _smallMapIcon = _loader.content as Bitmap;
            _smallMapIcon.mask = _maskShape;
            _smallMapContainer.addChild(_smallMapIcon);
         }
      }
      
      public function set info(param1:RoomInfo) : void
      {
         _info = param1;
         _info.addEventListener("mapChanged",__update);
         _info.addEventListener("mapTimeChanged",__update);
         _info.addEventListener("hardLevelChanged",__update);
         updateView();
      }
      
      private function __update(param1:Event) : void
      {
         updateView();
      }
      
      protected function updateView() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("complete",__completeHandler);
            _loader = null;
         }
         ObjectUtils.disposeAllChildren(_smallMapContainer);
         _loader = LoadResourceManager.Instance.createLoader(solvePath(),0);
         _loader.addEventListener("complete",__completeHandler);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      public function dispose() : void
      {
         _info.removeEventListener("mapChanged",__update);
         _info.removeEventListener("mapTimeChanged",__update);
         _info.removeEventListener("hardLevelChanged",__update);
         if(_loader)
         {
            _loader.removeEventListener("complete",__completeHandler);
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_word);
         _word = null;
         _smallMapIcon = null;
         ObjectUtils.disposeAllChildren(_smallMapContainer);
         removeChild(_smallMapContainer);
         _smallMapContainer = null;
         _info = null;
         _loader = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
