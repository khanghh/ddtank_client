package gameStarling.objects{   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import flash.utils.Dictionary;   import gameCommon.view.smallMap.SmallLiving;   import phy.object.SmallObject;   import starlingPhy.object.PhysicalObj3D;      public class SimpleObject3D extends PhysicalObj3D   {                   protected var m_model:String;            protected var m_action:String;            protected var m_movie:BoneMovieStarling;            protected var actionMapping:Dictionary;            protected var _smallMapView:SmallLiving;            private var _isBottom:Boolean;            private var _shouldReCreate:Boolean = false;            public function SimpleObject3D(id:int, type:int, model:String, action:String, isBottom:Boolean = false) { super(null,null); }
            override public function get layer() : int { return 0; }
            public function createMovieAfterLoadComplete() : void { }
            public function get shouldReCreate() : Boolean { return false; }
            public function set shouldReCreate(value:Boolean) : void { }
            protected function creatMovie(model:String) : void { }
            protected function initSmallMapView() : void { }
            override public function get smallView() : SmallObject { return null; }
            public function playAction(action:String) : void { }
            override public function collidedByObject(obj:PhysicalObj3D) : void { }
            override public function setActionMapping(source:String, target:String) : void { }
            override public function dispose() : void { }
            public function get movie() : BoneMovieStarling { return null; }
   }}