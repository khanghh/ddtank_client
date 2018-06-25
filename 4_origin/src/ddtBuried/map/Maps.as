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
      
      public function Maps($arr:Array, $w:int, $h:int)
      {
         super();
         w = $w;
         h = $h;
         wh = 55;
         mapDataArray = $arr;
         init();
      }
      
      private function init() : void
      {
         goo = 0.3;
         createMaps();
         roadMens();
         roadTimer = new Timer(300,0);
      }
      
      public function startMove(xpos:int, ypos:int) : void
      {
         var _ARoad:* = null;
         var endX:* = xpos;
         var endY:* = ypos;
         var endPoint:* = mapArr[endY][endX];
         if(endPoint.go == 0)
         {
            if(roadList)
            {
               var _loc9_:int = 0;
               var _loc8_:* = roadList;
               for each(var mc in roadList)
               {
                  mc.alpha = 1;
               }
               roadList = [];
            }
            roadTimer.stop();
            roadMen.px = Math.floor(roadMen.x / wh);
            roadMen.py = Math.floor(roadMen.y / wh);
            _ARoad = new ARoad();
            roadList = _ARoad.searchRoad(roadMen,endPoint,mapArr);
            if(roadList.length > 0)
            {
               MC_play(roadList);
            }
         }
      }
      
      private function MC_play(roadList:Array) : void
      {
         roadList.reverse();
         roadTimer.stop();
         timer_i = 0;
         roadTimer.addEventListener("timer",goMap);
         roadTimer.start();
         var _loc4_:int = 0;
         var _loc3_:* = roadList;
         for each(var mc in roadList)
         {
            mc.alpha = 0.3;
         }
      }
      
      private function goMap(evt:TimerEvent) : void
      {
         var tmpMC:MovieClip = roadList[timer_i];
         roadMen.x = tmpMC.x;
         roadMen.y = tmpMC.y;
         tmpMC.alpha = 1;
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
         var y:* = 0;
         var x:* = 0;
         var mapPoint:* = 0;
         var point:* = null;
         mapArr = [];
         map = new Sprite();
         map.x = wh;
         map.y = wh;
         addChild(map);
         for(y = uint(0); y < h; )
         {
            mapArr.push([]);
            for(x = uint(0); x < w; )
            {
               mapPoint = uint(mapDataArray[y][x]);
               point = drawRect(mapPoint);
               mapArr[y].push(point);
               mapArr[y][x].px = x;
               mapArr[y][x].py = y;
               mapArr[y][x].go = mapPoint;
               mapArr[y][x].x = x * wh;
               mapArr[y][x].y = y * wh;
               map.addChild(mapArr[y][x]);
               x++;
            }
            y++;
         }
         map.rotationX = -30;
         map.scaleX = 1.4;
         map.scaleY = 0.8;
      }
      
      private function clearMaps() : void
      {
         var y:* = 0;
         var x:* = 0;
         var mc:* = null;
         for(y = uint(0); y < h; )
         {
            for(x = uint(0); x < w; )
            {
               mc = mapArr[y][x];
               while(mc.numChildren)
               {
                  ObjectUtils.disposeObject(mc.removeChildAt(0));
               }
               ObjectUtils.disposeObject(mapArr[y][x]);
               x++;
            }
            y++;
         }
      }
      
      public function getMapArray() : Array
      {
         return mapArr;
      }
      
      private function keyDowns(evt:KeyboardEvent) : void
      {
         var _key:int = evt.keyCode;
         if(_key == 32)
         {
            removeChild(map);
            mapArr = [];
            createMaps();
            roadMens();
            roadTimer.stop();
         }
      }
      
      private function drawRect(mapPoint:uint) : MovieClip
      {
         var color:int = 0;
         var bitMap:* = null;
         var _tmp:MovieClip = new MovieClip();
         switch(int(mapPoint))
         {
            case 0:
               bitMap = ComponentFactory.Instance.creat("buried.shaizi.mapItemBack");
               bitMap.smoothing = true;
               bitMap.width = 56;
               bitMap.height = 56;
               _tmp.addChild(bitMap);
               return _tmp;
            case 1:
               return _tmp;
         }
      }
      
      private function roleCallback(role:BuriedPlayer, isLoadSucceed:Boolean) : void
      {
         if(!role)
         {
            return;
         }
         role.sceneCharacterStateType = "natural";
         role.update();
      }
      
      private function roadMens() : void
      {
         roadMen = drawRect(2);
         var _tmpx:uint = Math.round(Math.random() * (w - 1));
         var _tmpy:uint = Math.round(Math.random() * (h - 1));
         map.addChild(roadMen);
      }
      
      public function setRoadMan(px:int, py:int) : void
      {
         roadMen.px = px;
         roadMen.py = py;
         roadMen.x = px * wh;
         roadMen.y = py * wh;
         mapArr[py][px].go = 0;
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
