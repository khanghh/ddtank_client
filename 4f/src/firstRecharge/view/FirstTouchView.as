package firstRecharge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import firstRecharge.FirstRechargeControl;
   import firstRecharge.FirstRechargeManger;
   import firstRecharge.data.RechargeData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class FirstTouchView extends Frame implements Disposeable
   {
       
      
      private var _treeImage:ScaleBitmapImage;
      
      private var _treeImage2:ScaleBitmapImage;
      
      private var _worldtitle:Bitmap;
      
      private var _child:Bitmap;
      
      private var _back:MutipleImage;
      
      private var _btn:SimpleBitmapButton;
      
      private var _goodsContentList:Vector.<BagCell>;
      
      private var _line:Bitmap;
      
      private var _cartoonList:Vector.<MovieClip>;
      
      private var _rechargeMoneyTotalText:GradientText;
      
      private var _rechargeGiftBagValueText1:GradientText;
      
      private var _rechargeGiftBagValueText2:GradientText;
      
      private var _wordDirept:FilterFrameText;
      
      private var _wordDirept2:FilterFrameText;
      
      private var _wordDirept3:FilterFrameText;
      
      private var _wordDirept4:FilterFrameText;
      
      private var _endTimeTxt:FilterFrameText;
      
      private var _daojishiTxt:Bitmap;
      
      public function FirstTouchView(){super();}
      
      private function initEvent() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function initView() : void{}
      
      public function setGoodsList(param1:Vector.<RechargeData>) : void{}
      
      protected function clickHander(param1:MouseEvent) : void{}
      
      private function changeStringToDate(param1:String) : Date{return null;}
      
      private function refreshTimePlayTxt() : void{}
      
      override public function dispose() : void{}
   }
}
