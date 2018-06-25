package roomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TipItemView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bgII:ScaleBitmapImage;
      
      private var _value:int;
      
      private var _cellWidth:int;
      
      private var _cellheight:int;
      
      public function TipItemView(bg:Bitmap, value:int, cellWidth:int, cellheight:int)
      {
         _value = value;
         _bg = bg;
         _cellWidth = cellWidth;
         _cellheight = cellheight;
         super();
         init();
      }
      
      private function init() : void
      {
         this.buttonMode = true;
         if(_bg.x == 0)
         {
            _bg.x = _cellWidth / 2 - _bg.width / 2;
         }
         _bgII = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.RoomList.itemredbg");
         _bgII.width = _cellWidth;
         _bgII.height = _cellheight;
         _bgII.mouseChildren = false;
         _bgII.mouseEnabled = false;
         _bgII.visible = false;
         addChild(_bgII);
         addChild(_bg);
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
      
      public function get value() : int
      {
         return _value;
      }
      
      public function dispose() : void
      {
         if(_bgII)
         {
            ObjectUtils.disposeObject(_bgII);
            _bgII = null;
         }
         if(_bg && _bg.bitmapData)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
