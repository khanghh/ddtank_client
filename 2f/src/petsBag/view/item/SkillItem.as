package petsBag.view.item{   import bagAndInfo.cell.DragEffect;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.display.BitmapLoaderProxy;   import ddt.interfaces.IAcceptDrag;   import ddt.interfaces.IDragable;   import ddt.manager.DragManager;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.tips.ToolPropInfo;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.geom.Point;   import flash.geom.Rectangle;   import pet.data.PetSkill;   import pet.data.PetSkillTemplateInfo;   import petsBag.PetsBagManager;   import petsBag.event.PetItemEvent;      public class SkillItem extends Component implements IDragable, IAcceptDrag   {            public static const ZOOMVALUE:Number = 0.5;                   protected var _info:PetSkillTemplateInfo;            protected var _skillIcon:DisplayObject;            protected var _iconPos:Point;            private var _isLock:Boolean;            private var _lockImg:DisplayObject;            private var _lockLvImg:DisplayObject;            protected var _index:int;            protected var _canDrag:Boolean;            protected var _isWatch:Boolean;            protected var _tipInfo:ToolPropInfo;            protected var _mask:Shape;            protected var _bg:DisplayObject;            protected var _quickShortKey:Bitmap;            public var McType:int = 0;            public var DoubleClickEnabled:Boolean = false;            private var _skillID:int = -1;            private var _exclusiveImg:Bitmap;            private var _exclusiveMc:MovieClip;            public function SkillItem(info:PetSkillTemplateInfo, $index:int, canDrag:Boolean = false, isWatch:Boolean = false) { super(); }
            public function set skillID(id:int) : void { }
            override public function get tipStyle() : String { return null; }
            override public function get tipData() : Object { return null; }
            public function get skillID() : int { return 0; }
            public function get iconPos() : Point { return null; }
            public function set iconPos(value:Point) : void { }
            protected function initView() : void { }
            public function setExclusiveSkillImg() : void { }
            public function setExclusiveSkillMc() : void { }
            public function updateBorder() : void { }
            protected function initEvent() : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            protected function __clickHandler(evt:InteractiveEvent) : void { }
            protected function removeEvent() : void { }
            public function updateSize() : void { }
            public function set isLock(value:Boolean) : void { }
            public function get isLock() : Boolean { return false; }
            public function get index() : int { return 0; }
            public function set index(value:int) : void { }
            public function get info() : PetSkillTemplateInfo { return null; }
            public function set info(value:PetSkillTemplateInfo) : void { }
            protected function addQuictShortKey() : void { }
            public function set grayFilters(b:Boolean) : void { }
            public function getSource() : IDragable { return null; }
            public function dragStop(effect:DragEffect) : void { }
            public function dragDrop(effect:DragEffect) : void { }
            protected function creatDragImg() : DisplayObject { return null; }
            override public function get height() : Number { return 0; }
            override public function get width() : Number { return 0; }
            override public function dispose() : void { }
   }}