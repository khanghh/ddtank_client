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
      
      public function ARoad(){super();}
      
      public function searchRoad(param1:MovieClip, param2:MovieClip, param3:Array) : Array{return null;}
      
      private function addAroundPoint(param1:MovieClip) : void{}
      
      private function inArr(param1:MovieClip, param2:Array) : Boolean{return false;}
      
      private function setGHF(param1:MovieClip, param2:MovieClip, param3:*) : void{}
      
      private function checkG(param1:MovieClip, param2:MovieClip) : void{}
      
      private function getMinF() : uint{return null;}
   }
}
