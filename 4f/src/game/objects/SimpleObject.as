package game.objects{   import com.pickgliss.loader.ModuleLoader;   import flash.display.FrameLabel;   import flash.display.MovieClip;   import flash.media.SoundTransform;   import flash.utils.Dictionary;   import gameCommon.view.smallMap.SmallLiving;   import phy.object.PhysicalObj;   import phy.object.SmallObject;   import road.game.resource.ActionMovie;      public class SimpleObject extends PhysicalObj   {                   protected var m_model:String;            protected var m_action:String;            protected var m_movie:MovieClip;            protected var actionMapping:Dictionary;            private var _smallMapView:SmallObject;            private var _realLayer:int;            private var _shouldReCreate:Boolean = false;            public function SimpleObject(id:int, type:int, model:String, action:String, layer:int = 5) { super(null,null); }
            override public function get layer() : int { return 0; }
            public function createMovieAfterLoadComplete() : void { }
            public function get shouldReCreate() : Boolean { return false; }
            public function set shouldReCreate(value:Boolean) : void { }
            protected function creatMovie(model:String) : void { }
            protected function initSmallMapView() : void { }
            override public function get smallView() : SmallObject { return null; }
            public function playAction(action:String) : void { }
            override public function collidedByObject(obj:PhysicalObj) : void { }
            override public function setActionMapping(source:String, target:String) : void { }
            override public function dispose() : void { }
            public function get movie() : MovieClip { return null; }
   }}