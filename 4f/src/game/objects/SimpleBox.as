package game.objects{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.DisplayObjectContainer;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.MouseEvent;   import gameCommon.GameControl;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.objects.GhostBoxModel;   import gameCommon.view.smallMap.SmallBox;   import phy.object.PhysicalObj;   import phy.object.SmallObject;   import road7th.utils.MovieClipWrapper;   import room.RoomManager;      public class SimpleBox extends SimpleObject   {                   private var _dieMC:MovieClipWrapper;            private var _box:ScaleFrameImage;            private var _ghostBox:MovieClip;            private var _smallBox:SmallObject;            private var _isGhostBox:Boolean;            private var _subType:int = 0;            private var _localVisible:Boolean = true;            private var _constainer:DisplayObjectContainer;            private var _self:LocalPlayer;            private var _visible:Boolean = true;            public function SimpleBox(id:int, model:String, subType:int = 1) { super(null,null,null,null); }
            override public function get smallView() : SmallObject { return null; }
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
            override public function collidedByObject(obj:PhysicalObj) : void { }
            override public function die() : void { }
            protected function __boxDieComplete(event:Event) : void { }
            override public function isBox() : Boolean { return false; }
            override public function get canCollided() : Boolean { return false; }
            override public function dispose() : void { }
            override public function playAction(action:String) : void { }
            private function __onSelfPlayerDie(evt:Event) : void { }
            private function __onSelfPlayerRevive(evt:Event) : void { }
   }}