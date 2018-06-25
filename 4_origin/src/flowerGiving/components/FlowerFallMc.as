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
         var i:int = 0;
         _tempv = 2 + Math.random() * 1000 / 1000 * 2 * 0.8 - 0.8;
         _tempr = Math.random() * 1000 / 1000 * _fsr * 2 - _fsr;
         super();
         _flowerArr = [];
         for(i = 0; i < 100; )
         {
            _flowerMc = ComponentFactory.Instance.creat("asset.flowerGiving.flowerMc");
            _flowerArr.push(_flowerMc);
            i++;
         }
         addEventListener("enterFrame",__update);
      }
      
      private function __update(event:Event) : void
      {
         var flowerMc:* = null;
         var flowerMc2:* = null;
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
               flowerMc = _flowerArr[_num] as MovieClip;
               flowerMc.addEventListener("enterFrame",__flowerUpdate);
               _num = Number(_num) + 1;
               initFlower(flowerMc);
               addChild(flowerMc);
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
               flowerMc2 = _flowerArr[_num] as MovieClip;
               flowerMc2.removeEventListener("enterFrame",__flowerUpdate);
               if(flowerMc2.parent)
               {
                  removeChild(flowerMc2);
               }
               flowerMc2 = null;
            }
         }
      }
      
      private function initFlower(flowerMc:MovieClip) : void
      {
         flowerMc.x = Math.random() * _loadingSpriteWidth;
         flowerMc.y = Math.random() * 10;
         flowerMc.gx = _tempv * Math.sin(_tempr);
         flowerMc.gy = 8 + _tempv * Math.cos(_tempr);
         flowerMc.rot = Math.random() * 1000 / 1000 * 2 * 8 - 8;
         var _loc2_:* = 0.7 * Math.random();
         flowerMc.scaleX = _loc2_;
         flowerMc.scaleY = _loc2_;
      }
      
      private function __flowerUpdate(event:Event) : void
      {
         var flowerMc:MovieClip = event.target as MovieClip;
         flowerMc.x = flowerMc.x + flowerMc.gx;
         flowerMc.y = flowerMc.y + flowerMc.gy;
         flowerMc.rotation = flowerMc.rotation + flowerMc.rot;
         if(flowerMc.y > _loadingSpriteHeight)
         {
            initFlower(flowerMc);
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var flowerMc:* = null;
         for(i = 0; i < _flowerArr.length; )
         {
            flowerMc = _flowerArr[i] as MovieClip;
            flowerMc.removeEventListener("enterFrame",__flowerUpdate);
            if(flowerMc.parent)
            {
               removeChild(flowerMc);
            }
            flowerMc = null;
            i++;
         }
         removeEventListener("enterFrame",__update);
      }
   }
}
