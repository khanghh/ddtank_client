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
         var _loc4_:* = 0;
         var _loc2_:Bitmap = null;
         var _loc3_:Bitmap = null;
         var _loc1_:uint = Math.ceil(_maxLv / 2);
         _content = new Sprite();
         _bg = new Sprite();
         addChild(_bg);
         addChild(_content);
         _loc4_ = uint(0);
         while(_loc4_ < _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.ddtcoreii.ghostGrayStar");
            _loc3_.x = _loc3_.width * _loc4_;
            _bg.addChild(_loc3_);
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.ddtcoreii.ghostStar");
            _loc2_.x = _loc2_.width * _loc4_;
            _content.addChild(_loc2_);
            _loc4_++;
         }
         _mask = new Sprite();
         _mask.graphics.beginFill(16777215,1);
         _mask.graphics.drawRect(0,0,width,height);
         _mask.graphics.endFill();
         cacheAsBitmap = true;
         _content.mask = _mask;
         _content.addChild(_mask);
      }
      
      public function set maxLv(param1:uint) : void
      {
         _maxLv = param1;
      }
      
      public function set level(param1:uint) : void
      {
         if(param1 > _maxLv)
         {
            return;
         }
         if(_mask == null)
         {
            initContainer();
         }
         _mask.width = param1 / _maxLv * width;
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
