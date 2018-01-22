package store.newFusion.view
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import store.newFusion.FusionNewManager;
   import store.newFusion.data.FusionNewVo;
   
   public class FusionNewRightView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _fusionBg:Bitmap;
      
      private var _successBg:Bitmap;
      
      private var _fusionCell:BagCell;
      
      private var _materialList:Vector.<FusionNewMaterialCell>;
      
      private var _data:FusionNewVo;
      
      private var _successTipTxt:FilterFrameText;
      
      private var _successRateTxt:FilterFrameText;
      
      private var _needMoneyTipTxt:FilterFrameText;
      
      private var _needMoneyNumTxt:FilterFrameText;
      
      private var _moneyIcon:Bitmap;
      
      private var _fusionBtn:SimpleBitmapButton;
      
      private var _stopBtn:SimpleBitmapButton;
      
      private var _inputNumBg:Bitmap;
      
      private var _inputNumTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _maxNum:int;
      
      private var _inCount:int = 0;
      
      private var _isInFusion:Boolean = false;
      
      private var _coverSprite:Sprite;
      
      private var _previewTxt:FilterFrameText;
      
      private var _fusionNameTxt:FilterFrameText;
      
      private var _fusionNum:int;
      
      private var _fusionAttribute:SelectedCheckButton;
      
      private var _clickTime:Number = 0;
      
      private var showMoneyBG:MutipleImage;
      
      private var goldTxt:FilterFrameText;
      
      private var _moneyButton:RichesButton;
      
      public function FusionNewRightView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateMoney() : void{}
      
      private function stopHandler(param1:MouseEvent) : void{}
      
      private function stopContinuousView() : void{}
      
      private function startContinuousView() : void{}
      
      private function fusionCompleteHandler(param1:PkgEvent) : void{}
      
      private function delayFusion() : void{}
      
      private function changeMaxHandler(param1:MouseEvent) : void{}
      
      private function inputTextChangeHandler(param1:Event) : void{}
      
      private function fusionHandler(param1:MouseEvent) : void{}
      
      private function fusionItem(param1:int) : void{}
      
      private function _response2(param1:FrameEvent) : void{}
      
      private function checkGoldEnough() : Boolean{return false;}
      
      private function _responseV(param1:FrameEvent) : void{}
      
      private function okFastPurchaseGold() : void{}
      
      public function refreshView(param1:FusionNewVo) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
