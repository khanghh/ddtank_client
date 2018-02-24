package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import gameCommon.view.smallMap.SmallLiving;
   import phy.object.PhysicalObj;
   import phy.object.SmallObject;
   import road.game.resource.ActionMovie;
   
   public class SimpleObject extends PhysicalObj
   {
       
      
      protected var m_model:String;
      
      protected var m_action:String;
      
      protected var m_movie:MovieClip;
      
      protected var actionMapping:Dictionary;
      
      private var _smallMapView:SmallObject;
      
      private var _isBottom:Boolean;
      
      private var _shouldReCreate:Boolean = false;
      
      public function SimpleObject(param1:int, param2:int, param3:String, param4:String, param5:Boolean = false){super(null,null);}
      
      override public function get layer() : int{return 0;}
      
      public function createMovieAfterLoadComplete() : void{}
      
      public function get shouldReCreate() : Boolean{return false;}
      
      public function set shouldReCreate(param1:Boolean) : void{}
      
      protected function creatMovie(param1:String) : void{}
      
      protected function initSmallMapView() : void{}
      
      override public function get smallView() : SmallObject{return null;}
      
      public function playAction(param1:String) : void{}
      
      override public function collidedByObject(param1:PhysicalObj) : void{}
      
      override public function setActionMapping(param1:String, param2:String) : void{}
      
      override public function dispose() : void{}
      
      public function get movie() : MovieClip{return null;}
   }
}
