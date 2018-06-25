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
         var i:int = 0;
         _controller = TimesController.Instance;
         _contentViews = new Vector.<TimesContentView>(4);
         _bg = ComponentFactory.Instance.creatBitmap("asset.times.Bg");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("times.CloseBtn");
         _thumbnailView = ComponentFactory.Instance.creatCustomObject("times.TimesThumbnailView",[_controller]);
         _dateView = ComponentFactory.Instance.creatCustomObject("times.DateView");
         _menuView = ComponentFactory.Instance.creatCustomObject("times.MenuView");
         for(i = 0; i < _contentViews.length; )
         {
            _contentViews[i] = new TimesContentView(i);
            _contentViews[i].init(_controller.model.contentInfos[i]);
            i++;
         }
         _closeBtn.addEventListener("click",__closeClick);
         addChild(_bg);
         addChild(_closeBtn);
         addChild(_thumbnailView);
         addChild(_dateView);
         addChild(_menuView);
         _controller.initView(this,_thumbnailView,_contentViews);
      }
      
      public function menuSelected(index:int) : void
      {
         _menuView.selected = index;
      }
      
      private function __closeClick(event:MouseEvent) : void
      {
         _closeBtn.removeEventListener("click",__closeClick);
         _controller.dispatchEvent(new TimesEvent("closeView"));
      }
      
      public function updateGuildViewPoint(pagePos:Point) : void
      {
         var i:int = 0;
         var j:int = 0;
         var info:* = null;
         var idx:int = 0;
         if(pagePos.x == -1 && pagePos.y == -1)
         {
            _thumbnailView.pointIdx = idx;
            return;
         }
         i = 0;
         while(i < _controller.model.contentInfos.length)
         {
            for(j = 0; j < _controller.model.contentInfos[i].length; )
            {
               info = _controller.model.contentInfos[i][j];
               if(pagePos.x == info.category && pagePos.y == info.page)
               {
                  _thumbnailView.pointIdx = idx + 1;
                  return;
               }
               idx++;
               j++;
            }
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
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
         for(i = 0; i < _contentViews.length; )
         {
            ObjectUtils.disposeObject(_contentViews[i]);
            _contentViews[i] = null;
            i++;
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
