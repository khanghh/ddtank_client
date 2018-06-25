package ddtBuried.map{   import flash.display.MovieClip;   import flash.display.Sprite;      public class ARoad extends Sprite   {                   private var startPoint:MovieClip;            private var endPoint:MovieClip;            private var mapArr:Array;            private var w:uint;            private var h:uint;            private var openList:Array;            private var closeList:Array;            private var roadArr:Array;            private var isPath:Boolean;            private var isSearch:Boolean;            public function ARoad() { super(); }
            public function searchRoad(start:MovieClip, end:MovieClip, map:Array) : Array { return null; }
            private function addAroundPoint(thisPoint:MovieClip) : void { }
            private function inArr(obj:MovieClip, arr:Array) : Boolean { return false; }
            private function setGHF(point:MovieClip, thisPoint:MovieClip, G:*) : void { }
            private function checkG(chkPoint:MovieClip, thisPoint:MovieClip) : void { }
            private function getMinF() : uint { return null; }
   }}