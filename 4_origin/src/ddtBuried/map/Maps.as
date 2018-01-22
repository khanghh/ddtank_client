package ddtBuried.map
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import ddtBuried.role.BuriedPlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class Maps extends Sprite
   {
       
      
      private var w:uint;
      
      private var h:uint;
      
      private var wh:uint;
      
      private var goo:Number;
      
      private var map:Sprite;
      
      private var mapArr:Array;
      
      private var roadMen:MovieClip;
      
      private var roadList:Array;
      
      private var roadTimer:Timer;
      
      private var timer_i:uint = 0;
      
      private var mapDataArray:Array;
      
      private var role:BuriedPlayer;
      
      public function Maps(param1:Array, param2:int, param3:int)
      {
         super();
         w = param2;
         h = param3;
         wh = 55;
         mapDataArray = param1;
         init();
      }
      
      private function init() : void
      {
         goo = 0.3;
         createMaps();
         roadMens();
         roadTimer = new Timer(300,0);
      }
      
      public function startMove(param1:int, param2:int) : void
      {
         var _loc7_:* = null;
         var _loc5_:* = param1;
         var _loc6_:* = param2;
         var _loc4_:* = mapArr[_loc6_][_loc5_];
         if(_loc4_.go == 0)
         {
            if(roadList)
            {
               var _loc9_:int = 0;
               var _loc8_:* = roadList;
               for each(var _loc3_ in roadList)
               {
                  _loc3_.alpha = 1;
               }
               roadList = [];
            }
            roadTimer.stop();
            roadMen.px = Math.floor(roadMen.x / wh);
            roadMen.py = Math.floor(roadMen.y / wh);
            _loc7_ = new ARoad();
            roadList = _loc7_.searchRoad(roadMen,_loc4_,mapArr);
            if(roadList.length > 0)
            {
               MC_play(roadList);
            }
         }
      }
      
      private function MC_play(param1:Array) : void
      {
         param1.reverse();
         roadTimer.stop();
         timer_i = 0;
         roadTimer.addEventListener("timer",goMap);
         roadTimer.start();
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc2_.alpha = 0.3;
         }
      }
      
      private function goMap(param1:TimerEvent) : void
      {
         var _loc2_:MovieClip = roadList[timer_i];
         roadMen.x = _loc2_.x;
         roadMen.y = _loc2_.y;
         _loc2_.alpha = 1;
         timer_i = Number(timer_i) + 1;
         if(timer_i >= roadList.length)
         {
            roadTimer.stop();
            if(BuriedManager.Instance.isOver)
            {
               BuriedManager.Instance.isOver = false;
               BuriedControl.Instance.dispatchEvent(new BuriedEvent("mapover"));
            }
            else
            {
               BuriedControl.Instance.dispatchEvent(new BuriedEvent("walkOver"));
            }
         }
      }
      
      private function createMaps() : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc1_:* = null;
         mapArr = [];
         map = new Sprite();
         map.x = wh;
         map.y = wh;
         addChild(map);
         _loc3_ = uint(0);
         while(_loc3_ < h)
         {
            mapArr.push([]);
            _loc4_ = uint(0);
            while(_loc4_ < w)
            {
               _loc2_ = uint(mapDataArray[_loc3_][_loc4_]);
               _loc1_ = drawRect(_loc2_);
               mapArr[_loc3_].push(_loc1_);
               mapArr[_loc3_][_loc4_].px = _loc4_;
               mapArr[_loc3_][_loc4_].py = _loc3_;
               mapArr[_loc3_][_loc4_].go = _loc2_;
               mapArr[_loc3_][_loc4_].x = _loc4_ * wh;
               mapArr[_loc3_][_loc4_].y = _loc3_ * wh;
               map.addChild(mapArr[_loc3_][_loc4_]);
               _loc4_++;
            }
            _loc3_++;
         }
         map.rotationX = -30;
         map.scaleX = 1.4;
         map.scaleY = 0.8;
      }
      
      private function clearMaps() : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc1_:* = null;
         _loc2_ = uint(0);
         while(_loc2_ < h)
         {
            _loc3_ = uint(0);
            while(_loc3_ < w)
            {
               _loc1_ = mapArr[_loc2_][_loc3_];
               while(_loc1_.numChildren)
               {
                  ObjectUtils.disposeObject(_loc1_.removeChildAt(0));
               }
               ObjectUtils.disposeObject(mapArr[_loc2_][_loc3_]);
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function getMapArray() : Array
      {
         return mapArr;
      }
      
      private function keyDowns(param1:KeyboardEvent) : void
      {
         var _loc2_:int = param1.keyCode;
         if(_loc2_ == 32)
         {
            removeChild(map);
            mapArr = [];
            createMaps();
            roadMens();
            roadTimer.stop();
         }
      }
      
      private function drawRect(param1:uint) : MovieClip
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:MovieClip = new MovieClip();
         switch(int(param1))
         {
            case 0:
               _loc4_ = ComponentFactory.Instance.creat("buried.shaizi.mapItemBack");
               _loc4_.smoothing = true;
               _loc4_.width = 56;
               _loc4_.height = 56;
               _loc3_.addChild(_loc4_);
               return _loc3_;
            case 1:
               return _loc3_;
         }
      }
      
      private function roleCallback(param1:BuriedPlayer, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         param1.sceneCharacterStateType = "natural";
         param1.update();
      }
      
      private function roadMens() : void
      {
         roadMen = drawRect(2);
         var _loc1_:uint = Math.round(Math.random() * (w - 1));
         var _loc2_:uint = Math.round(Math.random() * (h - 1));
         map.addChild(roadMen);
      }
      
      public function setRoadMan(param1:int, param2:int) : void
      {
         roadMen.px = param1;
         roadMen.py = param2;
         roadMen.x = param1 * wh;
         roadMen.y = param2 * wh;
         mapArr[param2][param1].go = 0;
      }
      
      public function dispose() : void
      {
         clearMaps();
         mapArr = [];
         roadTimer.stop();
         roadTimer.removeEventListener("timer",goMap);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         roadTimer = null;
      }
   }
}
