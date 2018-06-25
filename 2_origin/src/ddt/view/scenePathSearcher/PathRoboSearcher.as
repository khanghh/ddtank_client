package ddt.view.scenePathSearcher
{
   import ddt.utils.Geometry;
   import flash.geom.Point;
   
   public class PathRoboSearcher implements PathIPathSearcher
   {
      
      private static var LEFT:Number = -1;
      
      private static var RIGHT:Number = 1;
       
      
      private var step:Number;
      
      private var maxCount:Number;
      
      private var maxDistance:Number;
      
      private var stepTurnNum:Number;
      
      public function PathRoboSearcher(step:Number, maxDistance:Number, num:Number = 4)
      {
         super();
         this.step = step;
         this.maxDistance = maxDistance;
         maxCount = Math.ceil(maxDistance / step) * 2;
         stepTurnNum = num;
      }
      
      public function setStepTurnNum(num:Number) : void
      {
         stepTurnNum = num;
      }
      
      public function search(from:Point, end:Point, hittest:PathIHitTester) : Array
      {
         var notGoPath:Array = [from,from];
         if(from.equals(end))
         {
            return notGoPath;
         }
         var leftPath:Array = [];
         var rightPath:Array = [];
         var left:Boolean = searchWithWish(from,end,hittest,LEFT,leftPath);
         var right:Boolean = searchWithWish(from,end,hittest,RIGHT,rightPath);
         if(left && right)
         {
            if(leftPath.length < rightPath.length)
            {
               return leftPath;
            }
            return rightPath;
         }
         if(left)
         {
            return leftPath;
         }
         if(right)
         {
            return rightPath;
         }
         return notGoPath;
      }
      
      private function searchWithWish(from:Point, tto:Point, tester:PathIHitTester, wish:Number, nodes:Array) : Boolean
      {
         var midTo:* = null;
         var midSearch:Boolean = false;
         var reverseNodes:* = null;
         var success:Boolean = false;
         var lastZhuanze:* = null;
         var minReplaceD:Number = NaN;
         var i:* = NaN;
         var rp:* = null;
         if(tester.isHit(tto))
         {
            tto = findReversseNearestBlankPoint(from,tto,tester);
            if(tto == null)
            {
               return false;
            }
            if(tester.isHit(from))
            {
               nodes.push(from);
               nodes.push(tto);
               return true;
            }
         }
         else if(tester.isHit(from))
         {
            midTo = findReversseNearestBlankPoint(tto,from,tester);
            if(midTo == null)
            {
               return false;
            }
            midSearch = searchWithWish(midTo,tto,tester,wish,nodes);
            if(midSearch)
            {
               nodes.splice(0,0,from);
               return true;
            }
            return false;
         }
         if(Point.distance(from,tto) > maxDistance)
         {
            nodes.push(from);
            tto = findFarestBlankPoint(from,tto,tester);
            if(tto == null)
            {
               return false;
            }
            nodes.push(tto);
            return true;
         }
         var aheadSearch:Boolean = doSearchWithWish(from,tto,tester,wish,nodes);
         if(!aheadSearch)
         {
            return false;
         }
         if(nodes.length > 4)
         {
            reverseNodes = [];
            success = doSearchWithWish(tto,nodes[0],tester,0 - wish,reverseNodes);
            if(success)
            {
               lastZhuanze = Point(reverseNodes[reverseNodes.length - 2]);
               minReplaceD = step;
               for(i = 1; i < nodes.length - 1; )
               {
                  rp = Point(nodes[i]);
                  if(Point.distance(rp,lastZhuanze) < minReplaceD)
                  {
                     nodes.splice(1,i,lastZhuanze);
                     return true;
                  }
                  i++;
               }
            }
         }
         return true;
      }
      
      private function findFarestBlankPoint(from:Point, tto:Point, t:PathIHitTester) : Point
      {
         var i:* = NaN;
         var tp:* = null;
         if(t.isHit(from))
         {
            return findReversseNearestBlankPoint(tto,from,t);
         }
         var heading:Number = countHeading(from,tto);
         var dist:Number = Point.distance(from,tto);
         var lastFrom:* = from;
         while(!t.isHit(from))
         {
            lastFrom = from;
            from = Geometry.nextPoint(from,heading,step);
            dist = dist - step;
            if(dist <= 0)
            {
               return null;
            }
         }
         from = lastFrom;
         var n:* = 8;
         var turn:Number = 3.14159265358979 / n;
         for(i = 1; i < n; )
         {
            tp = Geometry.nextPoint(from,heading + i * turn,step * 2);
            if(!t.isHit(tp))
            {
               return tp;
            }
            tp = Geometry.nextPoint(from,heading - i * turn,step * 2);
            if(!t.isHit(tp))
            {
               return tp;
            }
            i++;
         }
         return from;
      }
      
      private function findReversseNearestBlankPoint(from:Point, tto:Point, t:PathIHitTester) : Point
      {
         var i:* = NaN;
         var tp:* = null;
         var heading:Number = countHeading(tto,from);
         var dist:Number = Point.distance(tto,from);
         while(t.isHit(tto))
         {
            tto = Geometry.nextPoint(tto,heading,step);
            dist = dist - step;
            if(dist <= 0)
            {
               return null;
            }
         }
         var n:* = 12;
         var turn:Number = 3.14159265358979 / n;
         heading = heading + 3.14159265358979;
         for(i = 1; i < n; )
         {
            tp = Geometry.nextPoint(tto,heading + i * turn,step * 2);
            if(!t.isHit(tp))
            {
               return tp;
            }
            tp = Geometry.nextPoint(tto,heading - i * turn,step * 2);
            if(!t.isHit(tp))
            {
               return tp;
            }
            i++;
         }
         return tto;
      }
      
      private function doSearchWithWish(from:Point, tto:Point, tester:PathIHitTester, wish:Number, nodes:Array) : Boolean
      {
         var headingToEnd:Number = NaN;
         var dir:* = NaN;
         var bb:Number = NaN;
         var tp:* = null;
         var lastFrom:* = null;
         var distanceToEnd:Number = NaN;
         var finded:Boolean = false;
         var i:* = NaN;
         nodes.push(from);
         var angle:Number = wish * 3.14159265358979 / stepTurnNum;
         var startDelta:Number = wish * 3.14159265358979 / 2;
         var count:* = 1;
         var maxDistance:Number = step;
         var heading:* = Number(countHeading(from,tto));
         var lastDistanceToEnd:* = Number(Point.distance(from,tto));
         while(true)
         {
            if(!(lastDistanceToEnd > maxDistance && count < maxCount))
            {
               if(count <= maxCount)
               {
                  nodes.push(tto);
                  return true;
               }
               return false;
            }
            headingToEnd = countHeading(from,tto);
            dir = Number(heading - startDelta);
            bb = bearing(headingToEnd,dir);
            if(wish > 0 && bb < 0 || wish < 0 && bb > 0)
            {
               dir = headingToEnd;
            }
            tp = Geometry.nextPoint(from,dir,step);
            lastFrom = from;
            if(tester.isHit(tp))
            {
               finded = false;
               for(i = 2; i < stepTurnNum * 2; )
               {
                  dir = Number(dir + angle);
                  tp = Geometry.nextPoint(from,dir,step);
                  if(!tester.isHit(tp))
                  {
                     from = tp;
                     distanceToEnd = Point.distance(from,tto);
                     finded = true;
                     break;
                  }
                  i++;
               }
               if(!finded)
               {
                  break;
               }
            }
            else
            {
               from = tp;
               distanceToEnd = Point.distance(from,tto);
            }
            if(Math.abs(bearing(heading,dir)) > 0.01)
            {
               nodes.push(lastFrom);
               heading = dir;
            }
            lastDistanceToEnd = distanceToEnd;
         }
         trace("cant find one");
         nodes.splice(0);
         return false;
      }
      
      private function countHeading(p1:Point, p2:Point) : Number
      {
         return Math.atan2(p2.y - p1.y,p2.x - p1.x);
      }
      
      private function bearing(base:Number, heading:Number) : Number
      {
         var b:Number = heading - base;
         b = (b + 3.14159265358979 * 4) % (3.14159265358979 * 2);
         if(b < -3.14159265358979)
         {
            b = b + 3.14159265358979 * 2;
         }
         else if(b > 3.14159265358979)
         {
            b = b - 3.14159265358979 * 2;
         }
         return b;
      }
   }
}
