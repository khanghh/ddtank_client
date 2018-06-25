package Indiana.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class AttributeItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _txt:FilterFrameText;
      
      public function AttributeItem(fontstyle:String = "indiana.attribute.Txt")
      {
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.bg");
         _txt = ComponentFactory.Instance.creatComponentByStylename(fontstyle);
         _txt.x = 4;
         _txt.y = 1;
         addChild(_bg);
         addChild(_txt);
      }
      
      public function setWidth(value:int) : void
      {
         if(_bg)
         {
            _bg.width = value;
         }
      }
      
      public function setView(_view:DisplayObject) : void
      {
         if(_view)
         {
            addChild(_view);
         }
      }
      
      override public function get width() : Number
      {
         return 24;
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      public function set fontColor(color:int) : void
      {
         var format:* = null;
         if(_txt)
         {
            format = _txt.defaultTextFormat;
            format.color = color;
            _txt.defaultTextFormat = format;
         }
      }
      
      public function set Filter(_filter:Array) : void
      {
         var format:* = null;
         if(_txt)
         {
            format = _txt.defaultTextFormat;
            _txt.filters = _filter;
         }
      }
      
      public function get textField() : FilterFrameText
      {
         return _txt;
      }
      
      public function setDis(str:String) : void
      {
         if(_txt)
         {
            _txt.text = str;
         }
         _bg.width = _txt.textWidth + 10;
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _txt = null;
      }
   }
}
