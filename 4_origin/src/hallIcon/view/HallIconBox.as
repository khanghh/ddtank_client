package hallIcon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class HallIconBox extends Sprite implements Disposeable
   {
       
      
      private var _iconSprite:Sprite;
      
      private var _iconSpriteBg:ScaleBitmapImage;
      
      public function HallIconBox()
      {
         super();
         _iconSpriteBg = ComponentFactory.Instance.creatComponentByStylename("hallIconPanel.iconSpriteBg");
         super.addChild(_iconSpriteBg);
         _iconSprite = new Sprite();
         super.addChild(_iconSprite);
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         var tempChild:DisplayObject = _iconSprite.addChild(child);
         return tempChild;
      }
      
      override public function getChildIndex(child:DisplayObject) : int
      {
         return _iconSprite.getChildIndex(child);
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         var tempChild:DisplayObject = _iconSprite.removeChildAt(index);
         return tempChild;
      }
      
      override public function set x(value:Number) : void
      {
         .super.x = value;
         updateBg();
      }
      
      override public function set y(value:Number) : void
      {
         .super.y = value;
         updateBg();
      }
      
      override public function get numChildren() : int
      {
         return _iconSprite.numChildren;
      }
      
      private function updateBg() : void
      {
         _iconSpriteBg.width = _iconSprite.width + 12;
         _iconSpriteBg.height = _iconSprite.height + 10;
         _iconSpriteBg.x = _iconSprite.x - 12;
         _iconSpriteBg.y = _iconSprite.y - 10;
      }
      
      public function removeChildrens() : void
      {
         while(_iconSprite.numChildren > 0)
         {
            _iconSprite.removeChildAt(0);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_iconSprite);
         ObjectUtils.disposeObject(_iconSprite);
         _iconSprite = null;
         ObjectUtils.disposeObject(_iconSpriteBg);
         _iconSpriteBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
