package dayActivity.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DdtImportantView extends Sprite implements Disposeable
   {
       
      
      private var _prePageBtn:SimpleBitmapButton;
      
      private var _nextPageBtn:SimpleBitmapButton;
      
      private var _contentView:Bitmap;
      
      private var _currentIndex:int = 0;
      
      private var _sumIndex:int = 18;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _hBox:HBox;
      
      private var _contentViewVector:Vector.<Bitmap>;
      
      public function DdtImportantView()
      {
         _contentViewVector = new Vector.<Bitmap>();
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var view:* = null;
         _hBox = ComponentFactory.Instance.creatComponentByStylename("day.ddtImportantAdv.hBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("day.ddtImportantAdv.list");
         addChild(_scrollPanel);
         _scrollPanel.setView(_hBox);
         for(i = 0; i < _sumIndex; )
         {
            view = ComponentFactory.Instance.creat("day.actiity.groundBack" + (i + 1));
            _contentViewVector.push(view);
            _hBox.addChild(view);
            i++;
         }
         _scrollPanel.invalidateViewport();
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("day.ddtImportantAdv.prePageBtn");
         _prePageBtn.alpha = 0.3;
         addChild(_prePageBtn);
         _prePageBtn.tipData = LanguageMgr.GetTranslation("prePage");
         _prePageBtn.visible = false;
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("day.ddtImportantAdv.nextPageBtn");
         _nextPageBtn.alpha = 0.3;
         addChild(_nextPageBtn);
         _nextPageBtn.tipData = LanguageMgr.GetTranslation("nextPage");
         currentIndex = 0;
      }
      
      private function addEvent() : void
      {
         _prePageBtn.addEventListener("mouseOver",__overHandler);
         _prePageBtn.addEventListener("mouseOut",__outHandler);
         _nextPageBtn.addEventListener("mouseOver",__overHandler);
         _nextPageBtn.addEventListener("mouseOut",__outHandler);
         _prePageBtn.addEventListener("click",__leftPageHandler);
         _nextPageBtn.addEventListener("click",__rightPageHandler);
      }
      
      protected function __overHandler(event:MouseEvent) : void
      {
         (event.target as SimpleBitmapButton).alpha = 1;
      }
      
      protected function __outHandler(event:MouseEvent) : void
      {
         (event.target as SimpleBitmapButton).alpha = 0.3;
      }
      
      protected function __leftPageHandler(event:MouseEvent) : void
      {
         var i:int = 0;
         if(currentIndex <= 0)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         for(i = 0; i < _contentViewVector.length; )
         {
            if(i == _currentIndex || i == _currentIndex - 1)
            {
               _contentViewVector[i].visible = true;
            }
            else
            {
               _contentViewVector[i].visible = false;
            }
            i++;
         }
         var vX:int = _hBox.x;
         var _loc4_:Boolean = false;
         _nextPageBtn.visible = _loc4_;
         _prePageBtn.visible = _loc4_;
         TweenLite.to(_hBox,1,{
            "x":vX + _contentViewVector[_currentIndex].width,
            "onComplete":prePage
         });
      }
      
      private function prePage() : void
      {
         if(!_prePageBtn || !_nextPageBtn)
         {
            return;
         }
         var _loc1_:Boolean = true;
         _nextPageBtn.visible = _loc1_;
         _prePageBtn.visible = _loc1_;
         currentIndex = _currentIndex - 1;
      }
      
      private function nextPage() : void
      {
         if(!_prePageBtn || !_nextPageBtn)
         {
            return;
         }
         var _loc1_:Boolean = true;
         _nextPageBtn.visible = _loc1_;
         _prePageBtn.visible = _loc1_;
         currentIndex = _currentIndex + 1;
      }
      
      protected function __rightPageHandler(event:MouseEvent) : void
      {
         var i:int = 0;
         if(currentIndex >= _sumIndex - 1)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         for(i = 0; i < _contentViewVector.length; )
         {
            if(i == _currentIndex || i == _currentIndex + 1)
            {
               _contentViewVector[i].visible = true;
            }
            else
            {
               _contentViewVector[i].visible = false;
            }
            i++;
         }
         var vX:int = _hBox.x;
         var _loc4_:Boolean = false;
         _nextPageBtn.visible = _loc4_;
         _prePageBtn.visible = _loc4_;
         TweenLite.to(_hBox,1,{
            "x":vX - _contentViewVector[_currentIndex].width,
            "onComplete":nextPage
         });
      }
      
      public function get currentIndex() : int
      {
         return _currentIndex;
      }
      
      public function set currentIndex(value:int) : void
      {
         var i:int = 0;
         _currentIndex = value;
         for(i = 0; i < _contentViewVector.length; )
         {
            if(i == _currentIndex)
            {
               _contentViewVector[i].visible = true;
            }
            else
            {
               _contentViewVector[i].visible = false;
            }
            i++;
         }
         var _loc3_:* = _currentIndex;
         if(0 !== _loc3_)
         {
            if(_sumIndex - 1 !== _loc3_)
            {
               _loc3_ = true;
               _nextPageBtn.visible = _loc3_;
               _prePageBtn.visible = _loc3_;
            }
            else
            {
               _prePageBtn.visible = true;
               _nextPageBtn.visible = false;
            }
         }
         else
         {
            _prePageBtn.visible = false;
            _nextPageBtn.visible = true;
         }
      }
      
      private function disposeContentView() : void
      {
         ObjectUtils.disposeObject(_contentView);
         _contentView = null;
         _contentView = ComponentFactory.Instance.creat("day.actiity.groundBack" + _currentIndex);
         _contentView.alpha = 0;
         _contentView.x = 22;
         _contentView.y = 86;
         addChildAt(_contentView,0);
         TweenLite.to(_contentView,1,{"alpha":1});
      }
      
      private function removeEvent() : void
      {
         _prePageBtn.removeEventListener("mouseOver",__overHandler);
         _prePageBtn.removeEventListener("mouseOut",__outHandler);
         _nextPageBtn.removeEventListener("mouseOver",__overHandler);
         _nextPageBtn.removeEventListener("mouseOut",__outHandler);
         _prePageBtn.removeEventListener("click",__leftPageHandler);
         _nextPageBtn.removeEventListener("click",__rightPageHandler);
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _contentViewVector;
         for each(var bit in _contentViewVector)
         {
            ObjectUtils.disposeObject(bit);
            bit = null;
         }
         _contentViewVector = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_contentView);
         _contentView = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
