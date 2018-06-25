package phy.object
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import road7th.utils.MathUtils;
   
   public class PhysicalObj extends Physics
   {
       
      
      protected var _id:int;
      
      protected var _testRect:Rectangle;
      
      protected var _canCollided:Boolean;
      
      protected var _isLiving:Boolean;
      
      protected var _layerType:int;
      
      private var _name:String;
      
      public var IsCollide:Boolean;
      
      private var _drawPointContainer:Sprite;
      
      public function PhysicalObj(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(mass,gravityFactor,windFactor,airResitFactor);
         _id = id;
         _layerType = layerType;
         _canCollided = false;
         _testRect = new Rectangle(-5,-5,10,10);
         _isLiving = true;
      }
      
      public function get Id() : int
      {
         return _id;
      }
      
      public function get layerType() : int
      {
         return _layerType;
      }
      
      public function get Name() : String
      {
         return _name;
      }
      
      public function set Name(value:String) : void
      {
         _name = value;
      }
      
      public function setCollideRect(left:int, top:int, right:int, buttom:int) : void
      {
         _testRect.top = top;
         _testRect.left = left;
         _testRect.right = right;
         _testRect.bottom = buttom;
      }
      
      public function getCollideRect() : Rectangle
      {
         return _testRect.clone();
      }
      
      public function get canCollided() : Boolean
      {
         return _canCollided;
      }
      
      public function set canCollided(value:Boolean) : void
      {
         _canCollided = value;
      }
      
      public function get smallView() : SmallObject
      {
         return null;
      }
      
      public function get isLiving() : Boolean
      {
         return _isLiving;
      }
      
      override public function moveTo(p:Point) : void
      {
         var dx:Number = NaN;
         var dy:Number = NaN;
         var count:int = 0;
         var dt:Number = NaN;
         var cur:* = null;
         var dest:* = null;
         var t:int = 0;
         var rect:* = null;
         var list:* = null;
         if(Point.distance(p,pos) >= 3)
         {
            dx = Math.abs(int(p.x) - int(x));
            dy = Math.abs(int(p.y) - int(y));
            count = dx > dy?dx:Number(dy);
            dt = 1 / count;
            cur = pos;
            for(t = Math.abs(count); t > 0; )
            {
               dest = Point.interpolate(cur,p,dt * t);
               rect = getCollideRect();
               rect.offset(dest.x,dest.y);
               list = _map.getPhysicalObjects(rect,this);
               if(list.length > 0)
               {
                  pos = dest;
                  collideObject(list);
               }
               else if(!_map.IsRectangleEmpty(rect))
               {
                  pos = dest;
                  collideGround();
               }
               else if(_map.IsOutMap(dest.x,dest.y))
               {
                  pos = dest;
                  flyOutMap();
               }
               if(!_isMoving)
               {
                  return;
               }
               t = t - 3;
            }
            pos = p;
         }
      }
      
      public function calcObjectAngle(bounds:Number = 16) : Number
      {
         var pre_array:* = null;
         var next_array:* = null;
         var pre:* = null;
         var next:* = null;
         var bound:* = NaN;
         var m:* = NaN;
         var i:int = 0;
         var j:int = 0;
         var n:* = NaN;
         var nn:* = NaN;
         if(_map)
         {
            pre_array = [];
            next_array = [];
            pre = new Point();
            next = new Point();
            bound = bounds;
            for(m = 1; m <= bound; )
            {
               for(i = -10; i <= 10; )
               {
                  if(_map.IsEmpty(x + m,y - i))
                  {
                     if(i != -10)
                     {
                        pre_array.push(new Point(x + m,y - i));
                        break;
                     }
                     break;
                  }
                  i++;
               }
               j = -10;
               while(j <= 10)
               {
                  if(_map.IsEmpty(x - m,y - j))
                  {
                     if(j != -10)
                     {
                        next_array.push(new Point(x - m,y - j));
                        break;
                     }
                     break;
                  }
                  j++;
               }
               m = Number(m + 2);
            }
            pre = new Point(x,y);
            next = new Point(x,y);
            for(n = 0; n < pre_array.length; )
            {
               pre = pre.add(pre_array[n]);
               n++;
            }
            for(nn = 0; nn < next_array.length; )
            {
               next = next.add(next_array[nn]);
               nn++;
            }
            pre.x = pre.x / (pre_array.length + 1);
            pre.y = pre.y / (pre_array.length + 1);
            next.x = next.x / (next_array.length + 1);
            next.y = next.y / (next_array.length + 1);
            return MathUtils.GetAngleTwoPoint(pre,next);
         }
         return 0;
      }
      
      public function calcObjectAngle2(bounds:Number = 16, dis:int = 10) : Number
      {
         var pre_array:* = null;
         var next_array:* = null;
         var pre:* = null;
         var next:* = null;
         var bound:* = NaN;
         var m:* = NaN;
         var i:int = 0;
         var j:int = 0;
         var n:* = NaN;
         var nn:* = NaN;
         if(_map)
         {
            pre_array = [];
            next_array = [];
            pre = new Point();
            next = new Point();
            bound = bounds;
            for(m = 1; m <= bound; )
            {
               for(i = -dis; i <= dis; )
               {
                  if(_map.IsEmpty(x + m,y - i))
                  {
                     if(i != -dis)
                     {
                        pre_array.push(new Point(x + m,y - i));
                        break;
                     }
                     break;
                  }
                  i++;
               }
               for(j = -dis; j <= dis; )
               {
                  if(_map.IsEmpty(x - m,y - j))
                  {
                     if(j != -dis)
                     {
                        next_array.push(new Point(x - m,y - j));
                        break;
                     }
                     break;
                  }
                  j++;
               }
               m = Number(m + 2);
            }
            pre = new Point(x,y);
            next = new Point(x,y);
            for(n = 0; n < pre_array.length; )
            {
               pre = pre.add(pre_array[n]);
               n++;
            }
            for(nn = 0; nn < next_array.length; )
            {
               next = next.add(next_array[nn]);
               nn++;
            }
            pre.x = pre.x / (pre_array.length + 1);
            pre.y = pre.y / (pre_array.length + 1);
            next.x = next.x / (next_array.length + 1);
            next.y = next.y / (next_array.length + 1);
            return MathUtils.GetAngleTwoPoint(pre,next);
         }
         return 0;
      }
      
      public function calcObjectAngleDebug(bounds:Number = 16) : Number
      {
         var pre_array:* = null;
         var next_array:* = null;
         var pre:* = null;
         var next:* = null;
         var bound:* = NaN;
         var m:* = NaN;
         var i:int = 0;
         var j:int = 0;
         var n:* = NaN;
         var nn:* = NaN;
         if(_map)
         {
            pre_array = [];
            next_array = [];
            pre = new Point();
            next = new Point();
            bound = bounds;
            for(m = 1; m <= bound; )
            {
               for(i = -10; i <= 10; )
               {
                  if(_map.IsEmpty(x + m,y - i))
                  {
                     if(i != -10)
                     {
                        pre_array.push(new Point(x + m,y - i));
                        break;
                     }
                     break;
                  }
                  i++;
               }
               j = -10;
               while(j <= 10)
               {
                  if(_map.IsEmpty(x - m,y - j))
                  {
                     if(j != -10)
                     {
                        next_array.push(new Point(x - m,y - j));
                        break;
                     }
                     break;
                  }
                  j++;
               }
               m = Number(m + 2);
            }
            pre = new Point(x,y);
            next = new Point(x,y);
            for(n = 0; n < pre_array.length; )
            {
               pre = pre.add(pre_array[n]);
               n++;
            }
            drawPoint(pre_array,true);
            for(nn = 0; nn < next_array.length; )
            {
               next = next.add(next_array[nn]);
               nn++;
            }
            drawPoint(next_array,false);
            pre.x = pre.x / (pre_array.length + 1);
            pre.y = pre.y / (pre_array.length + 1);
            next.x = next.x / (next_array.length + 1);
            next.y = next.y / (next_array.length + 1);
            return MathUtils.GetAngleTwoPoint(pre,next);
         }
         return 0;
      }
      
      public function calcObjectAngleDebug2(bounds:Number = 16, dis:int = 10) : Number
      {
         var pre_array:* = null;
         var next_array:* = null;
         var pre:* = null;
         var next:* = null;
         var bound:* = NaN;
         var m:* = NaN;
         var i:int = 0;
         var j:int = 0;
         var n:* = NaN;
         var nn:* = NaN;
         if(_map)
         {
            pre_array = [];
            next_array = [];
            pre = new Point();
            next = new Point();
            bound = bounds;
            for(m = 1; m <= bound; )
            {
               for(i = -dis; i <= dis; )
               {
                  if(_map.IsEmpty(x + m,y - i))
                  {
                     if(i != -dis)
                     {
                        pre_array.push(new Point(x + m,y - i));
                        break;
                     }
                     break;
                  }
                  i++;
               }
               for(j = -dis; j <= dis; )
               {
                  if(_map.IsEmpty(x - m,y - j))
                  {
                     if(j != -dis)
                     {
                        next_array.push(new Point(x - m,y - j));
                        break;
                     }
                     break;
                  }
                  j++;
               }
               m = Number(m + 2);
            }
            pre = new Point(x,y);
            next = new Point(x,y);
            for(n = 0; n < pre_array.length; )
            {
               pre = pre.add(pre_array[n]);
               n++;
            }
            drawPoint(pre_array,true);
            for(nn = 0; nn < next_array.length; )
            {
               next = next.add(next_array[nn]);
               nn++;
            }
            drawPoint(next_array,false);
            pre.x = pre.x / (pre_array.length + 1);
            pre.y = pre.y / (pre_array.length + 1);
            next.x = next.x / (next_array.length + 1);
            next.y = next.y / (next_array.length + 1);
            return MathUtils.GetAngleTwoPoint(pre,next);
         }
         return 0;
      }
      
      private function drawPoint(data:Array, clear:Boolean) : void
      {
         var i:int = 0;
         if(_drawPointContainer == null)
         {
            _drawPointContainer = new Sprite();
         }
         if(clear)
         {
            _drawPointContainer.graphics.clear();
         }
         i = 0;
         while(i < data.length)
         {
            _drawPointContainer.graphics.beginFill(16711680);
            _drawPointContainer.graphics.drawCircle(data[i].x,data[i].y,2);
            _drawPointContainer.graphics.endFill();
            i++;
         }
         _map.addChild(_drawPointContainer);
      }
      
      protected function flyOutMap() : void
      {
         if(_isLiving)
         {
            die();
         }
      }
      
      protected function collideObject(list:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = list;
         for each(var obj in list)
         {
            obj.collidedByObject(this);
         }
      }
      
      protected function collideGround() : void
      {
         if(_isMoving)
         {
            stopMoving();
         }
      }
      
      public function collidedByObject(obj:PhysicalObj) : void
      {
      }
      
      public function setActionMapping(source:String, target:String) : void
      {
      }
      
      public function die() : void
      {
         _isLiving = false;
         if(_isMoving)
         {
            stopMoving();
         }
      }
      
      public function getTestRect() : Rectangle
      {
         return _testRect.clone();
      }
      
      public function isBox() : Boolean
      {
         return false;
      }
   }
}
