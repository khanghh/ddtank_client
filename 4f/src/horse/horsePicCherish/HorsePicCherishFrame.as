package horse.horsePicCherish
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import horse.HorseManager;
   import horse.data.HorsePicCherishVo;
   
   public class HorsePicCherishFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _scaleBg:ScaleBitmapImage;
      
      private var _leftBtn:SimpleBitmapButton;
      
      private var _rightBtn:SimpleBitmapButton;
      
      private var _currentIndex:int = 1;
      
      private var _sumPage:int;
      
      private var _itemListView:HorsePicCherishItemListView;
      
      private var _itemList:Vector.<HorsePicCherishItem>;
      
      private var _horsePicCherishList:Vector.<HorsePicCherishVo>;
      
      private var _nameStrList:Array;
      
      private var _propertyNameArr:Array;
      
      private var _propertyNamePosArr:Array;
      
      private var _propertyValueArr:Array;
      
      private var _propertyValuePosArr:Array;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      public function HorsePicCherishFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function initData() : void{}
      
      private function updateView() : void{}
      
      public function set index(param1:int) : void{}
      
      private function refreshView() : void{}
      
      protected function __rightHandler(param1:MouseEvent) : void{}
      
      protected function __leftHandler(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
