package gameStarling.objects
{
   import bones.display.BoneMovieStarling;
   import bones.display.IBoneMovie;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.manager.BallManager;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameStarling.view.map.MapView3D;
   import road7th.utils.BoneMovieVSplice;
   import starlingPhy.object.PhysicalObj3D;
   import starlingui.core.text.TextLabel;
   
   public class GameSceneEffect3D extends PhysicalObj3D
   {
       
      
      private var _effectMovie:BoneMovieVSplice;
      
      private var _isDispose:Boolean = false;
      
      private var _isDie:Boolean = false;
      
      private var _txt:TextLabel;
      
      private var _backFun:Function;
      
      public function GameSceneEffect3D(param1:int, param2:Rectangle = null, param3:int = 7, param4:Number = 1, param5:Number = 1, param6:Number = 0, param7:Number = 1){super(null,null,null,null,null,null);}
      
      public function initMoving() : void{}
      
      public function updateTxt(param1:Object) : void{}
      
      override public function get layer() : int{return 0;}
      
      override public function get layerType() : int{return 0;}
      
      private function initView() : void{}
      
      public function act(param1:String, param2:Function = null) : void{}
      
      public function set bombBackFun(param1:Function) : void{}
      
      override public function moveTo(param1:Point) : void{}
      
      override public function collidedByObject(param1:PhysicalObj3D) : void{}
      
      public function get effectMovie() : BoneMovieVSplice{return null;}
      
      public function needFocus(param1:int = 0, param2:int = 0, param3:Object = null) : void{}
      
      public function get map() : MapView3D{return null;}
      
      override public function die() : void{}
      
      override public function stopMoving() : void{}
      
      public function get isDie() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
