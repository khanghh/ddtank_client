package ddtBuried.map
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class ARoad extends Sprite
   {
       
      
      private var startPoint:MovieClip;
      
      private var endPoint:MovieClip;
      
      private var mapArr:Array;
      
      private var w:uint;
      
      private var h:uint;
      
      private var openList:Array;
      
      private var closeList:Array;
      
      private var roadArr:Array;
      
      private var isPath:Boolean;
      
      private var isSearch:Boolean;
      
      public function ARoad()
      {
         openList = [];
         closeList = [];
         roadArr = [];
         super();
      }
      
      public function searchRoad(start:MovieClip, end:MovieClip, map:Array) : Array
      {
         var thisPoint:* = null;
         startPoint = start;
         endPoint = end;
         mapArr = map;
         w = mapArr[0].length - 1;
         h = mapArr.length - 1;
         openList.push(startPoint);
         while(openList.length >= 1)
         {
            thisPoint = openList.splice(getMinF(),1)[0];
            if(thisPoint == endPoint)
            {
               while(thisPoint.father != startPoint.father)
               {
                  roadArr.push(thisPoint);
                  thisPoint = thisPoint.father;
               }
               return roadArr;
            }
            closeList.push(thisPoint);
            addAroundPoint(thisPoint);
         }
         return roadArr;
      }
      
      private function addAroundPoint(thisPoint:MovieClip) : void
      {
         var thisPx:uint = thisPoint.px;
         var thisPy:uint = thisPoint.py;
         if(thisPx > 0 && mapArr[thisPy][thisPx - 1].go == 0)
         {
            if(!inArr(mapArr[thisPy][thisPx - 1],closeList))
            {
               if(!inArr(mapArr[thisPy][thisPx - 1],openList))
               {
                  setGHF(mapArr[thisPy][thisPx - 1],thisPoint,10);
                  openList.push(mapArr[thisPy][thisPx - 1]);
               }
               else
               {
                  checkG(mapArr[thisPy][thisPx - 1],thisPoint);
               }
            }
            if(thisPy > 0 && mapArr[thisPy - 1][thisPx - 1].go == 0 && mapArr[thisPy - 1][thisPx].go == 0)
            {
               if(!inArr(mapArr[thisPy - 1][thisPx - 1],closeList) && !inArr(mapArr[thisPy - 1][thisPx - 1],openList))
               {
                  setGHF(mapArr[thisPy - 1][thisPx - 1],thisPoint,14);
                  openList.push(mapArr[thisPy - 1][thisPx - 1]);
               }
            }
            if(thisPy < h && mapArr[thisPy + 1][thisPx - 1].go == 0 && mapArr[thisPy + 1][thisPx].go == 0)
            {
               if(!inArr(mapArr[thisPy + 1][thisPx - 1],closeList) && !inArr(mapArr[thisPy + 1][thisPx - 1],openList))
               {
                  setGHF(mapArr[thisPy + 1][thisPx - 1],thisPoint,14);
                  openList.push(mapArr[thisPy + 1][thisPx - 1]);
               }
            }
         }
         if(thisPx < w && mapArr[thisPy][thisPx + 1].go == 0)
         {
            if(!inArr(mapArr[thisPy][thisPx + 1],closeList))
            {
               if(!inArr(mapArr[thisPy][thisPx + 1],openList))
               {
                  setGHF(mapArr[thisPy][thisPx + 1],thisPoint,10);
                  openList.push(mapArr[thisPy][thisPx + 1]);
               }
               else
               {
                  checkG(mapArr[thisPy][thisPx + 1],thisPoint);
               }
            }
            if(thisPy > 0 && mapArr[thisPy - 1][thisPx + 1].go == 0 && mapArr[thisPy - 1][thisPx].go == 0)
            {
               if(!inArr(mapArr[thisPy - 1][thisPx + 1],closeList) && !inArr(mapArr[thisPy - 1][thisPx + 1],openList))
               {
                  setGHF(mapArr[thisPy - 1][thisPx + 1],thisPoint,14);
                  openList.push(mapArr[thisPy - 1][thisPx + 1]);
               }
            }
            if(thisPy < h && mapArr[thisPy + 1][thisPx + 1].go == 0 && mapArr[thisPy + 1][thisPx].go == 0)
            {
               if(!inArr(mapArr[thisPy + 1][thisPx + 1],closeList) && !inArr(mapArr[thisPy + 1][thisPx + 1],openList))
               {
                  setGHF(mapArr[thisPy + 1][thisPx + 1],thisPoint,14);
                  openList.push(mapArr[thisPy + 1][thisPx + 1]);
               }
            }
         }
         if(thisPy > 0 && mapArr[thisPy - 1][thisPx].go == 0)
         {
            if(!inArr(mapArr[thisPy - 1][thisPx],closeList))
            {
               if(!inArr(mapArr[thisPy - 1][thisPx],openList))
               {
                  setGHF(mapArr[thisPy - 1][thisPx],thisPoint,10);
                  openList.push(mapArr[thisPy - 1][thisPx]);
               }
               else
               {
                  checkG(mapArr[thisPy - 1][thisPx],thisPoint);
               }
            }
         }
         if(thisPy < h && mapArr[thisPy + 1][thisPx].go == 0)
         {
            if(!inArr(mapArr[thisPy + 1][thisPx],closeList))
            {
               if(!inArr(mapArr[thisPy + 1][thisPx],openList))
               {
                  setGHF(mapArr[thisPy + 1][thisPx],thisPoint,10);
                  openList.push(mapArr[thisPy + 1][thisPx]);
               }
               else
               {
                  checkG(mapArr[thisPy + 1][thisPx],thisPoint);
               }
            }
         }
      }
      
      private function inArr(obj:MovieClip, arr:Array) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = arr;
         for each(var mc in arr)
         {
            if(obj == mc)
            {
               return true;
            }
         }
         return false;
      }
      
      private function setGHF(point:MovieClip, thisPoint:MovieClip, G:*) : void
      {
         if(!thisPoint.G)
         {
            thisPoint.G = 0;
         }
         point.G = thisPoint.G + G;
         point.H = (Math.abs(point.px - endPoint.px) + Math.abs(point.py - endPoint.py)) * 10;
         point.F = point.H + point.G;
         point.father = thisPoint;
      }
      
      private function checkG(chkPoint:MovieClip, thisPoint:MovieClip) : void
      {
         var newG:* = thisPoint.G + 10;
         if(newG <= chkPoint.G)
         {
            chkPoint.G = newG;
            chkPoint.F = chkPoint.H + newG;
            chkPoint.father = thisPoint;
         }
      }
      
      private function getMinF() : uint
      {
         var rid:* = 0;
         var tmpF:* = 100000000;
         var id:uint = 0;
         var _loc6_:int = 0;
         var _loc5_:* = openList;
         for each(var mc in openList)
         {
            if(mc.F < tmpF)
            {
               tmpF = uint(mc.F);
               rid = id;
            }
            id++;
         }
         return rid;
      }
   }
}
