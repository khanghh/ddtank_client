package roomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.loader.MapSmallIcon;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapItemView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _mapIcon:MapSmallIcon;
      
      private var _bgII:ScaleBitmapImage;
      
      private var _mapID:int;
      
      private var _cellWidth:int;
      
      private var _cellheight:int;
      
      public function MapItemView(mapID:int, cellWidth:int, cellheight:int)
      {
         _mapID = mapID;
         _cellWidth = cellWidth;
         _cellheight = cellheight;
         super();
         init();
      }
      
      private function init() : void
      {
         this.buttonMode = true;
         _mapIcon = new MapSmallIcon(_mapID);
         _mapIcon.addEventListener("complete",__mapIconLoadComplete);
         _mapIcon.startLoad();
         _bgII = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.RoomList.itemredbg");
         _bgII.mouseChildren = false;
         _bgII.mouseEnabled = false;
         _bgII.width = _cellWidth;
         _bgII.height = _cellheight;
         _bgII.visible = false;
         addChild(_bgII);
         addEventListener("mouseOver",__itemOver);
         addEventListener("mouseOut",__itemOut);
      }
      
      protected function __itemOut(event:MouseEvent) : void
      {
         _bgII.visible = false;
      }
      
      protected function __itemOver(event:MouseEvent) : void
      {
         _bgII.visible = true;
      }
      
      private function __mapIconLoadComplete(event:Event) : void
      {
         _mapIcon.removeEventListener("complete",__mapIconLoadComplete);
         _bg = _mapIcon.icon;
         if(_bg)
         {
            _bg.x = _cellWidth / 2 - _bg.width / 2 + 5;
            addChild(_bg);
         }
      }
      
      public function get id() : int
      {
         return _mapID;
      }
      
      public function dispose() : void
      {
         if(_mapIcon)
         {
            _mapIcon.removeEventListener("complete",__mapIconLoadComplete);
            _mapIcon.dispose();
            _mapIcon = null;
         }
         if(_bg && _bg.parent)
         {
            _bg.parent.removeChild(_bg);
            _bg = null;
         }
         if(_bgII)
         {
            ObjectUtils.disposeObject(_bgII);
            _bgII = null;
         }
      }
   }
}
