package times.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   
   public class TimesView extends Sprite implements Disposeable
   {
       
      
      private var _controller:TimesController;
      
      private var _bg:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _contentViews:Vector.<TimesContentView>;
      
      private var _thumbnailView:TimesThumbnailView;
      
      private var _dateView:TimesDateView;
      
      private var _menuView:TimesMenuView;
      
      public function TimesView()
      {
         super();
         init();
      }
      
      public function init() : void
      {
         var _loc1_:int = 0;
         _controller = TimesController.Instance;
         _contentViews = new Vector.<TimesContentView>(4);
         _bg = ComponentFactory.Instance.creatBitmap("asset.times.Bg");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("times.CloseBtn");
         _thumbnailView = ComponentFactory.Instance.creatCustomObject("times.TimesThumbnailView",[_controller]);
         _dateView = ComponentFactory.Instance.creatCustomObject("times.DateView");
         _menuView = ComponentFactory.Instance.creatCustomObject("times.MenuView");
         _loc1_ = 0;
         while(_loc1_ < _contentViews.length)
         {
            _contentViews[_loc1_] = new TimesContentView(_loc1_);
            _contentViews[_loc1_].init(_controller.model.contentInfos[_loc1_]);
            _loc1_++;
         }
         _closeBtn.addEventListener("click",__closeClick);
         addChild(_bg);
         addChild(_closeBtn);
         addChild(_thumbnailView);
         addChild(_dateView);
         addChild(_menuView);
         _controller.initView(this,_thumbnailView,_contentViews);
      }
      
      public function menuSelected(param1:int) : void
      {
         _menuView.selected = param1;
      }
      
      private function __closeClick(param1:MouseEvent) : void
      {
         _closeBtn.removeEventListener("click",__closeClick);
         _controller.dispatchEvent(new TimesEvent("closeView"));
      }
      
      public function updateGuildViewPoint(param1:Point) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         if(param1.x == -1 && param1.y == -1)
         {
            _thumbnailView.pointIdx = _loc2_;
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < _controller.model.contentInfos.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _controller.model.contentInfos[_loc5_].length)
            {
               _loc4_ = _controller.model.contentInfos[_loc5_][_loc3_];
               if(param1.x == _loc4_.category && param1.y == _loc4_.page)
               {
                  _thumbnailView.pointIdx = _loc2_ + 1;
                  return;
               }
               _loc2_++;
               _loc3_++;
            }
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _controller = null;
         _closeBtn.removeEventListener("click",__closeClick);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_dateView);
         _dateView = null;
         ObjectUtils.disposeObject(_menuView);
         _menuView = null;
         _loc1_ = 0;
         while(_loc1_ < _contentViews.length)
         {
            ObjectUtils.disposeObject(_contentViews[_loc1_]);
            _contentViews[_loc1_] = null;
            _loc1_++;
         }
         _contentViews = null;
         ObjectUtils.disposeObject(_thumbnailView);
         _thumbnailView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
