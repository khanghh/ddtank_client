package gameStarling.objects
{
   import com.greensock.TweenLite;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Point;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class PhantomBomb3D extends SimpleBomb3D
   {
       
      
      private var _phantomCount:int;
      
      private var _currentBombActions:Array;
      
      private var _maxTime:Number = 0;
      
      private var _tweenVec:Array;
      
      public function PhantomBomb3D(param1:Bomb, param2:Living, param3:int = 0){super(null,null,null);}
      
      override public function moveTo(param1:Point) : void{}
      
      private function changeAlphaPlay(param1:SimpleBomb3D, param2:Number) : void{}
      
      override public function dispose() : void{}
   }
}
