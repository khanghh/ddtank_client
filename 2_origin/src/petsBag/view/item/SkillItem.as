package petsBag.view.item
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.display.BitmapLoaderProxy;
   import ddt.interfaces.IAcceptDrag;
   import ddt.interfaces.IDragable;
   import ddt.manager.DragManager;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import pet.data.PetSkill;
   import pet.data.PetSkillTemplateInfo;
   import petsBag.PetsBagManager;
   import petsBag.event.PetItemEvent;
   
   public class SkillItem extends Component implements IDragable, IAcceptDrag
   {
      
      public static const ZOOMVALUE:Number = 0.5;
       
      
      protected var _info:PetSkillTemplateInfo;
      
      protected var _skillIcon:DisplayObject;
      
      protected var _iconPos:Point;
      
      private var _isLock:Boolean;
      
      private var _lockImg:DisplayObject;
      
      private var _lockLvImg:DisplayObject;
      
      protected var _index:int;
      
      protected var _canDrag:Boolean;
      
      protected var _isWatch:Boolean;
      
      protected var _tipInfo:ToolPropInfo;
      
      protected var _mask:Shape;
      
      protected var _bg:DisplayObject;
      
      protected var _quickShortKey:Bitmap;
      
      public var McType:int = 0;
      
      public var DoubleClickEnabled:Boolean = false;
      
      private var _skillID:int = -1;
      
      private var _exclusiveImg:Bitmap;
      
      private var _exclusiveMc:MovieClip;
      
      public function SkillItem(info:PetSkillTemplateInfo, $index:int, canDrag:Boolean = false, isWatch:Boolean = false)
      {
         super();
         _canDrag = canDrag;
         _isWatch = isWatch;
         _index = $index;
         _info = info;
         _iconPos = new Point();
         initView();
         initEvent();
      }
      
      public function set skillID(id:int) : void
      {
         info = null;
         _skillID = id;
         ShowTipManager.Instance.removeTip(this);
         if(id < 0)
         {
            isLock = true;
         }
         else if(id == 0)
         {
            isLock = false;
         }
         else
         {
            info = new PetSkill(id);
            ShowTipManager.Instance.addTip(this);
         }
      }
      
      override public function get tipStyle() : String
      {
         return "ddt.view.tips.PetSkillCellTip";
      }
      
      override public function get tipData() : Object
      {
         return _info;
      }
      
      public function get skillID() : int
      {
         return _skillID;
      }
      
      public function get iconPos() : Point
      {
         return _iconPos;
      }
      
      public function set iconPos(value:Point) : void
      {
         _iconPos = value;
         updateSize();
      }
      
      protected function initView() : void
      {
         if(_canDrag)
         {
            _bg = ComponentFactory.Instance.creatCustomObject("petsBag.skillItemBG");
            addChild(_bg);
         }
         tipDirctions = "5,2,7,1,6,4";
         tipGapH = 20;
         tipGapV = 20;
         graphics.beginFill(16711680,0);
         graphics.drawCircle(17.5,17.5,17);
         graphics.endFill();
         _mask = new Shape();
         _mask.graphics.beginFill(16711680,0);
         _mask.graphics.drawCircle(17.5,17.5,17);
         _mask.graphics.endFill();
         _mask.visible = !_canDrag;
         this.buttonMode = true;
         if(_index == 4)
         {
            _lockImg = ComponentFactory.Instance.creat("assets.petsBag.lock");
         }
         else
         {
            _lockImg = ComponentFactory.Instance.creat("assets.petsBag.lockLv");
         }
         addChild(_lockImg);
         _lockImg.visible = !_canDrag;
         if(_info)
         {
            _skillIcon = new BitmapLoaderProxy(PathManager.solveSkillPicUrl(_info.Pic));
            addChild(_skillIcon);
            _lockImg.visible = false;
            updateSize();
         }
         addQuictShortKey();
      }
      
      public function setExclusiveSkillImg() : void
      {
         if(_info && _info.exclusiveID > 0 && McType == 1)
         {
            if(_exclusiveImg == null)
            {
               _exclusiveImg = ComponentFactory.Instance.creat("asset.petsBag.awaken.awakenSkillBorder");
               addChild(_exclusiveImg);
            }
            _exclusiveImg.visible = true;
         }
         else if(_exclusiveImg)
         {
            _exclusiveImg.visible = false;
         }
      }
      
      public function setExclusiveSkillMc() : void
      {
         if(_info && _info.exclusiveID > 0 && McType == 2)
         {
            if(_exclusiveMc == null)
            {
               _exclusiveMc = ComponentFactory.Instance.creat("asset.petsBg.awakenSucess.circleMC");
            }
            addChild(_exclusiveMc);
            if(_exclusiveMc)
            {
               _exclusiveMc.visible = true;
            }
         }
         else if(_exclusiveMc)
         {
            _exclusiveMc.visible = false;
         }
      }
      
      public function updateBorder() : void
      {
         setExclusiveSkillMc();
         setExclusiveSkillImg();
      }
      
      protected function initEvent() : void
      {
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!DoubleClickEnabled)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(info == null)
         {
            return;
         }
         dispatchEvent(new PetItemEvent("itemclick",this));
      }
      
      protected function __clickHandler(evt:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
         if(_canDrag && _info && !_isWatch)
         {
            DragManager.startDrag(this,null,creatDragImg(),stage.mouseX,stage.mouseY,"move");
         }
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
      
      public function updateSize() : void
      {
         if(_skillIcon)
         {
            _skillIcon.x = _iconPos.x;
            _skillIcon.y = _iconPos.y;
            if(_canDrag)
            {
               var _loc1_:* = 0.5;
               _skillIcon.scaleY = _loc1_;
               _skillIcon.scaleX = _loc1_;
            }
         }
      }
      
      public function set isLock(value:Boolean) : void
      {
         _isLock = value;
         grayFilters = _isLock;
         _lockImg.visible = _isLock;
         if(_quickShortKey)
         {
            _quickShortKey.visible = !_isLock;
         }
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
      }
      
      public function get info() : PetSkillTemplateInfo
      {
         return _info;
      }
      
      public function set info(value:PetSkillTemplateInfo) : void
      {
         _info = value;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         _tipData = null;
         if(_info)
         {
            isLock = false;
            _skillIcon = new BitmapLoaderProxy(PathManager.solveSkillPicUrl(_info.Pic),new Rectangle(0,0,35,35));
            _skillIcon.mask = _mask;
            addChild(_skillIcon);
            addChild(_mask);
            addQuictShortKey();
            updateSize();
         }
         updateBorder();
      }
      
      protected function addQuictShortKey() : void
      {
         if(!_canDrag && !_quickShortKey && !_isLock)
         {
            _quickShortKey = ComponentFactory.Instance.creatBitmap("assets.petsBag.Q" + _index.toString());
            addChild(_quickShortKey);
         }
      }
      
      public function set grayFilters(b:Boolean) : void
      {
         if(b)
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            filters = null;
         }
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         var source:SkillItem = effect.source as SkillItem;
         if(source && !_canDrag)
         {
            SocketManager.Instance.out.sendEquipPetSkill(PetsBagManager.instance().petModel.currentPetInfo.Place,source.info.ID,_index);
            if(PetsBagManager.instance().petModel.petGuildeOptionOnOff[117] > 0)
            {
               PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(117);
               PetsBagManager.instance().petModel.petGuildeOptionOnOff[117] = 0;
            }
         }
      }
      
      protected function creatDragImg() : DisplayObject
      {
         var img:Bitmap = new Bitmap(new BitmapData(_skillIcon.width / _skillIcon.scaleX,_skillIcon.height / _skillIcon.scaleY,true,4294967295));
         img.bitmapData.draw(_skillIcon);
         img.scaleX = 0.75;
         img.scaleY = 0.75;
         return img;
      }
      
      override public function get height() : Number
      {
         return !!_bg?_bg.height:0;
      }
      
      override public function get width() : Number
      {
         return !!_bg?_bg.width:0;
      }
      
      override public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_lockLvImg);
         _lockLvImg = null;
         _info = null;
         _index = 0;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
