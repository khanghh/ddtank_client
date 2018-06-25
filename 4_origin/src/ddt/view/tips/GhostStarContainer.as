package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class GhostStarContainer extends Sprite implements Disposeable
   {
       
      
      private var _maxLv:Number = 10;
      
      private var _mask:Sprite;
      
      private var _content:Sprite;
      
      private var _bg:Sprite;
      
      public function GhostStarContainer()
      {
         super();
      }
      
      private function initContainer() : void
      {
         var i:* = 0;
         var star:Bitmap = null;
         var grayStar:Bitmap = null;
         var cnt:uint = Math.ceil(_maxLv / 2);
         _content = new Sprite();
         _bg = new Sprite();
         addChild(_bg);
         addChild(_content);
         for(i = uint(0); i < cnt; )
         {
            grayStar = ComponentFactory.Instance.creatBitmap("asset.ddtcoreii.ghostGrayStar");
            grayStar.x = grayStar.width * i;
            _bg.addChild(grayStar);
            star = ComponentFactory.Instance.creatBitmap("asset.ddtcoreii.ghostStar");
            star.x = star.width * i;
            _content.addChild(star);
            i++;
         }
         _mask = new Sprite();
         _mask.graphics.beginFill(16777215,1);
         _mask.graphics.drawRect(0,0,width,height);
         _mask.graphics.endFill();
         cacheAsBitmap = true;
         _content.mask = _mask;
         _content.addChild(_mask);
      }
      
      public function set maxLv(value:uint) : void
      {
         _maxLv = value;
      }
      
      public function set level(value:uint) : void
      {
         if(value > _maxLv)
         {
            return;
         }
         if(_mask == null)
         {
            initContainer();
         }
         _mask.width = value / _maxLv * width;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
