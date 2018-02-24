package game.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BallManager;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.view.map.MapView;
   import phy.object.PhysicalObj;
   import road7th.utils.MovieClipVSplice;
   
   public class GameSceneEffect extends PhysicalObj
   {
       
      
      private var _effectMovie:MovieClipVSplice;
      
      private var _isDispose:Boolean = false;
      
      private var _isDie:Boolean = false;
      
      private var _txt:FilterFrameText;
      
      public function GameSceneEffect(param1:int, param2:Rectangle = null, param3:int = 7, param4:Number = 1, param5:Number = 1, param6:Number = 0, param7:Number = 1){super(null,null,null,null,null,null);}
      
      private function test() : void{}
      
      public function initMoving() : void{}
      
      public function initTxt() : void{}
      
      public function updateTxt(param1:Object) : void{}
      
      override public function get layer() : int{return 0;}
      
      override public function get layerType() : int{return 0;}
      
      private function initView() : void{}
      
      public function act(param1:String, param2:Function = null) : void{}
      
      override public function moveTo(param1:Point) : void{}
      
      override public function collidedByObject(param1:PhysicalObj) : void{}
      
      public function get effectMovie() : MovieClipVSplice{return null;}
      
      public function needFocus(param1:int = 0, param2:int = 0, param3:Object = null) : void{}
      
      public function get map() : MapView{return null;}
      
      override public function die() : void{}
      
      override public function stopMoving() : void{}
      
      public function get isDie() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
