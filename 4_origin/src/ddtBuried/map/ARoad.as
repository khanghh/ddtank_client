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
      
      public function searchRoad(param1:MovieClip, param2:MovieClip, param3:Array) : Array
      {
         var _loc4_:* = null;
         startPoint = param1;
         endPoint = param2;
         mapArr = param3;
         w = mapArr[0].length - 1;
         h = mapArr.length - 1;
         openList.push(startPoint);
         while(openList.length >= 1)
         {
            _loc4_ = openList.splice(getMinF(),1)[0];
            if(_loc4_ == endPoint)
            {
               while(_loc4_.father != startPoint.father)
               {
                  roadArr.push(_loc4_);
                  _loc4_ = _loc4_.father;
               }
               return roadArr;
            }
            closeList.push(_loc4_);
            addAroundPoint(_loc4_);
         }
         return roadArr;
      }
      
      private function addAroundPoint(param1:MovieClip) : void
      {
         var _loc3_:uint = param1.px;
         var _loc2_:uint = param1.py;
         if(_loc3_ > 0 && mapArr[_loc2_][_loc3_ - 1].go == 0)
         {
            if(!inArr(mapArr[_loc2_][_loc3_ - 1],closeList))
            {
               if(!inArr(mapArr[_loc2_][_loc3_ - 1],openList))
               {
                  setGHF(mapArr[_loc2_][_loc3_ - 1],param1,10);
                  openList.push(mapArr[_loc2_][_loc3_ - 1]);
               }
               else
               {
                  checkG(mapArr[_loc2_][_loc3_ - 1],param1);
               }
            }
            if(_loc2_ > 0 && mapArr[_loc2_ - 1][_loc3_ - 1].go == 0 && mapArr[_loc2_ - 1][_loc3_].go == 0)
            {
               if(!inArr(mapArr[_loc2_ - 1][_loc3_ - 1],closeList) && !inArr(mapArr[_loc2_ - 1][_loc3_ - 1],openList))
               {
                  setGHF(mapArr[_loc2_ - 1][_loc3_ - 1],param1,14);
                  openList.push(mapArr[_loc2_ - 1][_loc3_ - 1]);
               }
            }
            if(_loc2_ < h && mapArr[_loc2_ + 1][_loc3_ - 1].go == 0 && mapArr[_loc2_ + 1][_loc3_].go == 0)
            {
               if(!inArr(mapArr[_loc2_ + 1][_loc3_ - 1],closeList) && !inArr(mapArr[_loc2_ + 1][_loc3_ - 1],openList))
               {
                  setGHF(mapArr[_loc2_ + 1][_loc3_ - 1],param1,14);
                  openList.push(mapArr[_loc2_ + 1][_loc3_ - 1]);
               }
            }
         }
         if(_loc3_ < w && mapArr[_loc2_][_loc3_ + 1].go == 0)
         {
            if(!inArr(mapArr[_loc2_][_loc3_ + 1],closeList))
            {
               if(!inArr(mapArr[_loc2_][_loc3_ + 1],openList))
               {
                  setGHF(mapArr[_loc2_][_loc3_ + 1],param1,10);
                  openList.push(mapArr[_loc2_][_loc3_ + 1]);
               }
               else
               {
                  checkG(mapArr[_loc2_][_loc3_ + 1],param1);
               }
            }
            if(_loc2_ > 0 && mapArr[_loc2_ - 1][_loc3_ + 1].go == 0 && mapArr[_loc2_ - 1][_loc3_].go == 0)
            {
               if(!inArr(mapArr[_loc2_ - 1][_loc3_ + 1],closeList) && !inArr(mapArr[_loc2_ - 1][_loc3_ + 1],openList))
               {
                  setGHF(mapArr[_loc2_ - 1][_loc3_ + 1],param1,14);
                  openList.push(mapArr[_loc2_ - 1][_loc3_ + 1]);
               }
            }
            if(_loc2_ < h && mapArr[_loc2_ + 1][_loc3_ + 1].go == 0 && mapArr[_loc2_ + 1][_loc3_].go == 0)
            {
               if(!inArr(mapArr[_loc2_ + 1][_loc3_ + 1],closeList) && !inArr(mapArr[_loc2_ + 1][_loc3_ + 1],openList))
               {
                  setGHF(mapArr[_loc2_ + 1][_loc3_ + 1],param1,14);
                  openList.push(mapArr[_loc2_ + 1][_loc3_ + 1]);
               }
            }
         }
         if(_loc2_ > 0 && mapArr[_loc2_ - 1][_loc3_].go == 0)
         {
            if(!inArr(mapArr[_loc2_ - 1][_loc3_],closeList))
            {
               if(!inArr(mapArr[_loc2_ - 1][_loc3_],openList))
               {
                  setGHF(mapArr[_loc2_ - 1][_loc3_],param1,10);
                  openList.push(mapArr[_loc2_ - 1][_loc3_]);
               }
               else
               {
                  checkG(mapArr[_loc2_ - 1][_loc3_],param1);
               }
            }
         }
         if(_loc2_ < h && mapArr[_loc2_ + 1][_loc3_].go == 0)
         {
            if(!inArr(mapArr[_loc2_ + 1][_loc3_],closeList))
            {
               if(!inArr(mapArr[_loc2_ + 1][_loc3_],openList))
               {
                  setGHF(mapArr[_loc2_ + 1][_loc3_],param1,10);
                  openList.push(mapArr[_loc2_ + 1][_loc3_]);
               }
               else
               {
                  checkG(mapArr[_loc2_ + 1][_loc3_],param1);
               }
            }
         }
      }
      
      private function inArr(param1:MovieClip, param2:Array) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = param2;
         for each(var _loc3_ in param2)
         {
            if(param1 == _loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function setGHF(param1:MovieClip, param2:MovieClip, param3:*) : void
      {
         if(!param2.G)
         {
            param2.G = 0;
         }
         param1.G = param2.G + param3;
         param1.H = (Math.abs(param1.px - endPoint.px) + Math.abs(param1.py - endPoint.py)) * 10;
         param1.F = param1.H + param1.G;
         param1.father = param2;
      }
      
      private function checkG(param1:MovieClip, param2:MovieClip) : void
      {
         var _loc3_:* = param2.G + 10;
         if(_loc3_ <= param1.G)
         {
            param1.G = _loc3_;
            param1.F = param1.H + _loc3_;
            param1.father = param2;
         }
      }
      
      private function getMinF() : uint
      {
         var _loc3_:* = 0;
         var _loc4_:* = 100000000;
         var _loc1_:uint = 0;
         var _loc6_:int = 0;
         var _loc5_:* = openList;
         for each(var _loc2_ in openList)
         {
            if(_loc2_.F < _loc4_)
            {
               _loc4_ = uint(_loc2_.F);
               _loc3_ = _loc1_;
            }
            _loc1_++;
         }
         return _loc3_;
      }
   }
}
