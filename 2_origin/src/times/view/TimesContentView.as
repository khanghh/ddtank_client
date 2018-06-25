package times.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   import times.utils.TimesUtils;
   
   public class TimesContentView extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _controller:TimesController;
      
      private var _bigPics:TimesPicGroup;
      
      private var _prePageBtn:SimpleBitmapButton;
      
      private var _nextPageBtn:SimpleBitmapButton;
      
      private var _maskShape:Shape;
      
      private var _maxIdx:int;
      
      private var _picType:String;
      
      public function TimesContentView(index:int)
      {
         super();
         _index = index;
      }
      
      public function init(infos:Vector.<TimesPicInfo>) : void
      {
         _controller = TimesController.Instance;
         _maxIdx = infos.length;
         _maskShape = new Shape();
         _maskShape.graphics.beginFill(0,0.5);
         _maskShape.graphics.drawRoundRect(0,-1,745,406,15,15);
         _maskShape.graphics.endFill();
         _bigPics = new TimesPicGroup(infos,_index);
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("times.PreBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("times.NextBtn");
         _bigPics.mask = _maskShape;
         TimesUtils.setPos(_bigPics,"times.ContentBigPicPos");
         TimesUtils.setPos(_maskShape,"times.maskShapePos");
         addChild(_bigPics);
         addChild(_maskShape);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         frame = 0;
         initEvent();
      }
      
      public function get maxIdx() : int
      {
         return _maxIdx;
      }
      
      public function set maxIdx(value:int) : void
      {
         _maxIdx = value;
      }
      
      public function set frame(value:int) : void
      {
         _bigPics.currentIdx = value;
         load(value);
      }
      
      public function get frame() : int
      {
         return _bigPics.currentIdx;
      }
      
      private function load(startIdx:int) : void
      {
         _bigPics.load(startIdx);
      }
      
      private function initEvent() : void
      {
         _prePageBtn.addEventListener("click",__onBtnClick);
         _nextPageBtn.addEventListener("click",__onBtnClick);
      }
      
      private function __onBtnClick(e:MouseEvent) : void
      {
         _controller.dispatchEvent(new TimesEvent("playSound"));
         var _loc2_:* = e.currentTarget;
         if(_prePageBtn !== _loc2_)
         {
            if(_nextPageBtn === _loc2_)
            {
               goNextPage();
            }
         }
         else
         {
            goPrePage();
         }
      }
      
      private function goPrePage() : void
      {
         if(_bigPics.currentIdx > 0)
         {
            _bigPics.currentIdx--;
            _controller.tryShowTipDisplay(_bigPics.currentInfo.category,_bigPics.currentIdx);
            _controller.tryShowEgg();
            _controller.updateGuildViewPoint(_bigPics.currentInfo.category,_bigPics.currentIdx);
         }
         else
         {
            _controller.dispatchEvent(new TimesEvent("gotoPreContent"));
         }
      }
      
      private function goNextPage() : void
      {
         if(_bigPics.currentIdx < _maxIdx - 1)
         {
            _bigPics.currentIdx++;
            _controller.tryShowTipDisplay(_bigPics.currentInfo.category,_bigPics.currentIdx);
            _controller.tryShowEgg();
            _controller.updateGuildViewPoint(_bigPics.currentInfo.category,_bigPics.currentIdx);
         }
         else
         {
            _controller.dispatchEvent(new TimesEvent("gotoNextContent"));
         }
      }
      
      public function dispose() : void
      {
         _controller = null;
         _prePageBtn.removeEventListener("click",__onBtnClick);
         _nextPageBtn.removeEventListener("click",__onBtnClick);
         ObjectUtils.disposeObject(_bigPics);
         _bigPics = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         if(_maskShape)
         {
            if(_maskShape.parent)
            {
               _maskShape.parent.removeChild(_maskShape);
            }
            _maskShape.graphics.clear();
            _maskShape = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
