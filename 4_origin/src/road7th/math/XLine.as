package road7th.math
{
   import flash.geom.Point;
   
   public class XLine
   {
       
      
      protected var list:Array;
      
      protected var fix:Boolean = true;
      
      protected var fixValue:Number = 1;
      
      public function XLine(... arg)
      {
         super();
         line = arg;
      }
      
      public static function ToString(value:Array) : String
      {
         var rlt:String = "";
         try
         {
            var _loc6_:int = 0;
            var _loc5_:* = value;
            for each(var p in value)
            {
               rlt = rlt + (p.x + ":" + p.y + ",");
            }
         }
         catch(e:Error)
         {
         }
         return rlt;
      }
      
      public static function parse(str:String) : Array
      {
         var temp:* = null;
         var nums:* = null;
         var i:int = 0;
         var list:Array = [];
         try
         {
            temp = str.match(/([-]?\d+[\.]?\d*)/g);
            nums = [];
            for(i = 0; i < temp.length; )
            {
               list.push(new Point(Number(temp[i]),Number(temp[i + 1])));
               i = i + 2;
            }
         }
         catch(e:Error)
         {
         }
         return list;
      }
      
      public function set line(value:Array) : void
      {
         list = value;
         if(list == null || list.length == 0)
         {
            fix = true;
            fixValue = 1;
         }
         else if(list.length == 1)
         {
            fix = true;
            fixValue = list[0].y;
         }
         else if(list.length == 2 && list[0].y == list[1].y)
         {
            fix = true;
            fixValue = list[0].y;
         }
         else
         {
            fix = false;
         }
      }
      
      public function get line() : Array
      {
         return list;
      }
      
      public function interpolate(x:Number) : Number
      {
         var p1:* = null;
         var p2:* = null;
         var i:int = 0;
         if(!fix)
         {
            for(i = 1; i < list.length; )
            {
               p2 = list[i];
               p1 = list[i - 1];
               if(p2.x <= x)
               {
                  i++;
                  continue;
               }
               break;
            }
            return interpolatePointByX(p1,p2,x);
         }
         return fixValue;
      }
   }
}
