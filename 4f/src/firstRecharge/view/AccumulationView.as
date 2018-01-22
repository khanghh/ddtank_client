package firstRecharge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.FTextButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SoundManager;
   import firstRecharge.items.PicItem;
   import firstRecharge.items.String8;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class AccumulationView extends Frame implements Disposeable
   {
       
      
      private var _treeImage:ScaleBitmapImage;
      
      private var _treeImage2:Scale9CornerImage;
      
      private var _pricePic:Bitmap;
      
      private var _picBack:Bitmap;
      
      private var _barBack:Bitmap;
      
      private var _libaoTxt:Bitmap;
      
      private var _daojishiTxt:Bitmap;
      
      private var _itemList:Vector.<PicItem>;
      
      private var _goodsContentList:Vector.<BagCell>;
      
      private var _selcetedBitMap:Bitmap;
      
      private var _iconStrList:Array;
      
      private var _iconTxtStrList:Array;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _txt4:FilterFrameText;
      
      private var _txt5:FilterFrameText;
      
      private var _txt6:FilterFrameText;
      
      private var _txt7:FilterFrameText;
      
      private var _btn:FTextButton;
      
      private var _fengeLine:Bitmap;
      
      private var _goldLine:Bitmap;
      
      private var str8:String8;
      
      public function AccumulationView(){super();}
      
      private function initEvent() : void{}
      
      private function uinitEvent() : void{}
      
      protected function _response(param1:FrameEvent) : void{}
      
      private function initView() : void{}
      
      protected function clickHander(param1:MouseEvent) : void{}
      
      protected function mouseClickHander(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
