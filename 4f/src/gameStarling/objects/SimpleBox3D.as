package gameStarling.objects{   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;   import gameCommon.GameControl;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.objects.GhostBoxModel;   import gameCommon.view.smallMap.SmallBox;   import road7th.StarlingMain;   import room.RoomManager;   import starling.display.DisplayObjectContainer;   import starling.display.Image;   import starlingPhy.object.PhysicalObj3D;      public class SimpleBox3D extends SimpleObject3D   {                   private var _dieMC:BoneMovieStarling;            private var _box:Image;            private var _ghostBox:BoneMovieStarling;            private var _isGhostBox:Boolean;            private var _subType:int = 0;            private var _localVisible:Boolean = true;            private var _constainer:DisplayObjectContainer;            private var _self:LocalPlayer;            private var _visible:Boolean = true;            public function SimpleBox3D(id:int, model:String, subType:int = 1) { super(null,null,null,null); }
            override public function get layer() : int { return 0; }
            private function addEvent() : void { }
            private function __click(evt:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function get isGhost() : Boolean { return false; }
            public function get subType() : int { return 0; }
            public function get psychic() : int { return 0; }
            protected function setIsGhost(value:Boolean) : void { }
            public function pickByLiving(living:Living) : void { }
            override protected function creatMovie(model:String) : void { }
            public function setContainer(constainer:DisplayObjectContainer) : void { }
            override public function set visible(value:Boolean) : void { }
            override public function collidedByObject(obj:PhysicalObj3D) : void { }
            override public function die() : void { }
            protected function __boxDieComplete(event:Event) : void { }
            override public function isBox() : Boolean { return false; }
            override public function get canCollided() : Boolean { return false; }
            override public function dispose() : void { }
            override public function playAction(action:String) : void { }
            private function __onSelfPlayerDie(evt:Event) : void { }
            private function __onSelfPlayerRevive(evt:Event) : void { }
   }}