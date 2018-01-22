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
      
      public function TimesView(){super();}
      
      public function init() : void{}
      
      public function menuSelected(param1:int) : void{}
      
      private function __closeClick(param1:MouseEvent) : void{}
      
      public function updateGuildViewPoint(param1:Point) : void{}
      
      public function dispose() : void{}
   }
}
