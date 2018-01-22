package flowerGiving.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class FlowerFallMc extends Sprite implements Disposeable
   {
       
      
      private var _flowerMc:MovieClip;
      
      private var _frequency:Number = 0.5;
      
      private var _flag:Number = 0;
      
      private var _flowerArr:Array;
      
      private var _num:int;
      
      private var _loadingSpriteWidth:int = 1010;
      
      private var _loadingSpriteHeight:int = 610;
      
      private var _fsr:Number = 0.5235988333333332;
      
      private var _tempv:Number;
      
      private var _tempr:Number;
      
      public var isOver:Boolean = false;
      
      public function FlowerFallMc()
      {
         var _loc1_:int = 0;
         _tempv = 2 + Math.random() * 1000 / 1000 * 2 * 0.8 - 0.8;
         _tempr = Math.random() * 1000 / 1000 * _fsr * 2 - _fsr;
         super();
         _flowerArr = [];
         _loc1_ = 0;
         while(_loc1_ < 100)
         {
            _flowerMc = ComponentFactory.Instance.creat("asset.flowerGiving.flowerMc");
            _flowerArr.push(_flowerMc);
            _loc1_++;
         }
         addEventListener("enterFrame",__update);
      }
      
      private function __update(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(!isOver)
         {
            _flag = _flag + _frequency;
            while(_flag > 1)
            {
               _flag = _flag - 1;
               if(_num >= 100)
               {
                  return;
               }
               _loc3_ = _flowerArr[_num] as MovieClip;
               _loc3_.addEventListener("enterFrame",__flowerUpdate);
               _num = Number(_num) + 1;
               initFlower(_loc3_);
               addChild(_loc3_);
            }
         }
         else
         {
            _flag = _flag + _frequency;
            while(_flag > 1)
            {
               _flag = _flag - 1;
               _num = Number(_num) - 1;
               if(_num < 0)
               {
                  dispatchEvent(new Event("complete"));
                  return;
               }
               _loc2_ = _flowerArr[_num] as MovieClip;
               _loc2_.removeEventListener("enterFrame",__flowerUpdate);
               if(_loc2_.parent)
               {
                  removeChild(_loc2_);
               }
               _loc2_ = null;
            }
         }
      }
      
      private function initFlower(param1:MovieClip) : void
      {
         param1.x = Math.random() * _loadingSpriteWidth;
         param1.y = Math.random() * 10;
         param1.gx = _tempv * Math.sin(_tempr);
         param1.gy = 8 + _tempv * Math.cos(_tempr);
         param1.rot = Math.random() * 1000 / 1000 * 2 * 8 - 8;
         var _loc2_:* = 0.7 * Math.random();
         param1.scaleX = _loc2_;
         param1.scaleY = _loc2_;
      }
      
      private function __flowerUpdate(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.x = _loc2_.x + _loc2_.gx;
         _loc2_.y = _loc2_.y + _loc2_.gy;
         _loc2_.rotation = _loc2_.rotation + _loc2_.rot;
         if(_loc2_.y > _loadingSpriteHeight)
         {
            initFlower(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _flowerArr.length)
         {
            _loc1_ = _flowerArr[_loc2_] as MovieClip;
            _loc1_.removeEventListener("enterFrame",__flowerUpdate);
            if(_loc1_.parent)
            {
               removeChild(_loc1_);
            }
            _loc1_ = null;
            _loc2_++;
         }
         removeEventListener("enterFrame",__update);
      }
   }
}
