package cardSystem.view
{
   import baglocked.BaglockedManager;
   import cardSystem.CardManager;
   import cardSystem.CardSocketEvent;
   import cardSystem.CardTemplateInfoManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.CardTemplateInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.ConfirmAlertHelper;
   import ddt.utils.HelperBuyAlert;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import road7th.comm.PackageIn;
   
   public class PropResetFrame extends BaseAlerFrame
   {
      
      public static var resetPointNotAlertAgain:Boolean = false;
      
      public static var buyIsBind:Boolean = true;
       
      
      private var _cardInfo:CardInfo;
      
      private var _cardCell:ResetCardCell;
      
      private var _newProperty:Bitmap;
      
      private var _oldProperty:Bitmap;
      
      private var _inputSmallBg1:Vector.<ScaleLeftRightImage>;
      
      private var _inputSmallBg2:Vector.<ScaleLeftRightImage>;
      
      private var _basicPropVec1:Vector.<FilterFrameText>;
      
      private var _oldPropVec:Vector.<FilterFrameText>;
      
      private var _newPropVec:Vector.<FilterFrameText>;
      
      private var _upAndDownVec:Vector.<ScaleFrameImage>;
      
      private var _smallinputPropContainer1:VBox;
      
      private var _smallinputPropContainer2:VBox;
      
      private var _basePropContainer1:VBox;
      
      private var _oldPropContainer:VBox;
      
      private var _newPropContainer:VBox;
      
      private var _upAndDownContainer:VBox;
      
      private var _canReplace:Boolean;
      
      private var _isFirst:Boolean = true;
      
      private var _headBg1:ScaleBitmapImage;
      
      private var _headBg2:ScaleBitmapImage;
      
      private var _headBg3:ScaleBitmapImage;
      
      private var _headTextBg1:ScaleLeftRightImage;
      
      private var _headTextBg2:ScaleLeftRightImage;
      
      private var _headTextBg3:ScaleLeftRightImage;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _bg3:ScaleBitmapImage;
      
      private var _bg4:ScaleBitmapImage;
      
      private var _resetArrow:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      private var _helpButton:BaseButton;
      
      private var _needSoul:FilterFrameText;
      
      private var _needSoulText:FilterFrameText;
      
      private var _ownSoul:FilterFrameText;
      
      private var _ownSoulText:FilterFrameText;
      
      private var _useMoneyTitleTxt:FilterFrameText;
      
      private var _useMoneyTxt:FilterFrameText;
      
      private var _resetAlert:BaseAlerFrame;
      
      private var _cancelAlert:BaseAlerFrame;
      
      private var _propertyPool:Object;
      
      private var _strArray:Object;
      
      private var _newArray:Array;
      
      private var _propertys:Vector.<PropertyEmu>;
      
      private var _sendReplace:Boolean = false;
      
      private var _resetNeedSoul:int;
      
      private var _lockContainer:VBox;
      
      private var _lockVec:Vector.<ScaleFrameImage>;
      
      private var _lockStates:Array;
      
      private var _levelSelectedBg:ScaleLeftRightImage;
      
      private var _levelSelectGroup:SelectedButtonGroup;
      
      private var _levelSelectedNomalChkBtn:SelectedCheckButton;
      
      private var _levelSelectedAdvancedChkBtn:SelectedCheckButton;
      
      private var _levelSelectedNomalTxt:FilterFrameText;
      
      private var _levelSelectedAdvancedTxt:FilterFrameText;
      
      private var _tipTxt:FilterFrameText;
      
      private var _attrTFs:Array;
      
      private var _attrGFs:Array;
      
      private var _enableSubmit:Boolean = true;
      
      private var soulValue:int = 0;
      
      public function PropResetFrame(){super();}
      
      private function initView() : void{}
      
      private function _levelSelectGroupChangeHandler(param1:Event) : void{}
      
      private function __lockImgClickHandler(param1:MouseEvent) : void{}
      
      private function get lockStateNum() : int{return 0;}
      
      public function checkSoul() : void{}
      
      public function show(param1:CardInfo) : void{}
      
      private function getTxtColorIndex(param1:int) : int{return 0;}
      
      private function UpdateStrArray() : void{}
      
      public function set cardInfo(param1:CardInfo) : void{}
      
      private function initEvent() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      protected function __replaceHandler(param1:MouseEvent) : void{}
      
      private function __replaceAlert(param1:FrameEvent) : void{}
      
      private function submitReplace() : void{}
      
      private function __changeSoul(param1:CardSocketEvent) : void{}
      
      private function updateText() : void{}
      
      protected function __resethandler(param1:MouseEvent) : void{}
      
      private function __resetDialogAlertResponse(param1:FrameEvent) : void{}
      
      private function buyAlert() : void{}
      
      private function resetExe(param1:Boolean) : void{}
      
      private function __cancelHandel() : void{}
      
      private function __cancelResponse(param1:FrameEvent) : void{}
      
      private function setReplaceAbled(param1:Boolean) : void{}
      
      private function __reset(param1:PkgEvent) : void{}
      
      override public function dispose() : void{}
      
      private function __helpOpen(param1:MouseEvent) : void{}
      
      private function __helpResponse(param1:FrameEvent) : void{}
   }
}

class PropertyEmu
{
    
   
   public var key:String;
   
   public var idx:int;
   
   function PropertyEmu(param1:String, param2:int){super();}
}
