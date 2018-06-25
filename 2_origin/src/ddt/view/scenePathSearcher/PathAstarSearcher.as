package ddt.view.scenePathSearcher
{
   import flash.geom.Point;
   
   public class PathAstarSearcher implements PathIPathSearcher
   {
       
      
      private var open_list:Array;
      
      private var close_list:Array;
      
      private var path_arr:Array;
      
      private var setOut_point:PathAstarPoint;
      
      private var aim_point:PathAstarPoint;
      
      private var current_point:PathAstarPoint;
      
      private var step_len:int;
      
      private var hittest:PathIHitTester;
      
      private var record_start_point:PathAstarPoint;
      
      public function PathAstarSearcher(n:int)
      {
         super();
         step_len = n;
      }
      
      public function search(from:Point, end:Point, hittest:PathIHitTester) : Array
      {
         aim_point = new PathAstarPoint(end.x,end.y);
         record_start_point = new PathAstarPoint(from.x,from.y);
         var xModify:int = 0;
         var yModify:int = 0;
         if(end.x > from.x)
         {
            xModify = from.x - (step_len - Math.abs(end.x - from.x) % step_len);
         }
         else
         {
            xModify = from.x + (step_len - Math.abs(end.x - from.x) % step_len);
         }
         if(end.y > from.y)
         {
            yModify = from.y - (step_len - Math.abs(end.y - from.y) % step_len);
         }
         else
         {
            yModify = from.y + (step_len - Math.abs(end.y - from.y) % step_len);
         }
         setOut_point = new PathAstarPoint(xModify,yModify);
         current_point = setOut_point;
         this.hittest = hittest;
         init();
         findPath();
         return path_arr;
      }
      
      private function init() : void
      {
         open_list = [];
         close_list = [];
         path_arr = [];
      }
      
      private function findPath() : void
      {
         var nodes:* = null;
         var g_tmp:* = NaN;
         var f_tmp:* = NaN;
         var h_tmp:* = NaN;
         var i:int = 0;
         open_list.push(setOut_point);
         var goon:Boolean = true;
         while(open_list.length > 0 && goon)
         {
            current_point = open_list.shift();
            if(current_point.x == aim_point.x && current_point.y == aim_point.y)
            {
               goon = false;
               aim_point = nodes[i];
               aim_point.source_point = current_point;
               break;
            }
            nodes = [];
            nodes = createNode(current_point);
            g_tmp = 0;
            f_tmp = 0;
            h_tmp = 0;
            for(i = 0; i < nodes.length; )
            {
               if(nodes[i].x == aim_point.x && nodes[i].y == aim_point.y)
               {
                  goon = false;
                  aim_point = nodes[i];
                  aim_point.source_point = current_point;
                  break;
               }
               if(existInArray(open_list,nodes[i]) == -1 && existInArray(close_list,nodes[i]) == -1)
               {
                  if(!hittest.isHit(nodes[i]))
                  {
                     nodes[i].source_point = current_point;
                     g_tmp = Number(getEvaluateG(nodes[i]));
                     h_tmp = Number(getEvaluateH(nodes[i]));
                     setEvaluate(nodes[i],g_tmp,h_tmp);
                     open_list.push(nodes[i]);
                  }
               }
               else if(existInArray(open_list,nodes[i]) != -1)
               {
                  g_tmp = Number(getEvaluateG(nodes[i]));
                  h_tmp = Number(getEvaluateH(nodes[i]));
                  f_tmp = Number(g_tmp + h_tmp);
                  if(f_tmp < nodes[i].f)
                  {
                     nodes[i].source_point = current_point;
                     setEvaluate(nodes[i],g_tmp,h_tmp);
                  }
               }
               else
               {
                  g_tmp = Number(getEvaluateG(nodes[i]));
                  h_tmp = Number(getEvaluateH(nodes[i]));
                  f_tmp = Number(g_tmp + h_tmp);
                  if(f_tmp < nodes[i].f)
                  {
                     nodes[i].source_point = current_point;
                     setEvaluate(nodes[i],g_tmp,h_tmp);
                     open_list.push(nodes[i]);
                     close_list.splice(existInArray(close_list,nodes[i]),1);
                  }
               }
               i++;
            }
            close_list.push(current_point);
            open_list.sortOn("f",16);
            if(open_list.length > 30)
            {
               open_list = open_list.slice(0,30);
            }
         }
         createPath();
      }
      
      private function createPath() : void
      {
         var this_point:PathAstarPoint = new PathAstarPoint();
         this_point = aim_point;
         while(this_point != setOut_point)
         {
            path_arr.unshift(this_point);
            if(this_point.source_point != null)
            {
               this_point = this_point.source_point;
               continue;
            }
            path_arr = [];
            path_arr.push(record_start_point,record_start_point);
            return;
         }
         path_arr.splice(0,0,record_start_point);
      }
      
      private function setEvaluate(point:PathAstarPoint, g:Number, h:Number) : void
      {
         point.g = g;
         point.h = h;
         point.f = point.g + point.h;
      }
      
      private function getEvaluateG(point:PathAstarPoint) : int
      {
         var g_tmp:int = 0;
         if(current_point.x == point.x || current_point.y == point.y)
         {
            g_tmp = 10;
         }
         else
         {
            g_tmp = 14;
         }
         g_tmp = g_tmp + current_point.g;
         return g_tmp;
      }
      
      private function getEvaluateH(point:PathAstarPoint) : int
      {
         return Math.abs(aim_point.x - point.x) * 10 + Math.abs(aim_point.y - point.y) * 10;
      }
      
      private function createNode(point:PathAstarPoint) : Array
      {
         var arr:Array = [];
         arr.push(new PathAstarPoint(point.x,point.y - step_len));
         arr.push(new PathAstarPoint(point.x - step_len,point.y));
         arr.push(new PathAstarPoint(point.x + step_len,point.y));
         arr.push(new PathAstarPoint(point.x,point.y + step_len));
         arr.push(new PathAstarPoint(point.x - step_len,point.y - step_len));
         arr.push(new PathAstarPoint(point.x + step_len,point.y - step_len));
         arr.push(new PathAstarPoint(point.x - step_len,point.y + step_len));
         arr.push(new PathAstarPoint(point.x + step_len,point.y + step_len));
         return arr;
      }
      
      private function existInArray(arr:Array, point:PathAstarPoint) : int
      {
         var i:int = 0;
         var n:* = -1;
         for(i = 0; i < arr.length; )
         {
            if(arr[i].x == point.x && arr[i].y == point.y)
            {
               n = i;
               break;
            }
            i++;
         }
         return n;
      }
   }
}
