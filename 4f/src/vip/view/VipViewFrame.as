package vip.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.bossbox.AwardsViewII;
   import ddt.view.bossbox.VipInfoTipBox;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import vip.VipController;
   
   public class VipViewFrame extends Frame
   {
      
      private static var _instance:VipViewFrame;
      
      public static const VIP_LEVEL1:String = "112112";
      
      public static const VIP_LEVEL2:String = "112113";
      
      public static const VIP_LEVEL3:String = "112114";
      
      public static const VIP_LEVEL4:String = "112115";
      
      public static const VIP_LEVEL5:String = "112116";
      
      public static const VIP_LEVEL6:String = "112117";
      
      public static const VIP_LEVEL7:String = "112118";
      
      public static const VIP_LEVEL8:String = "112119";
      
      public static const VIP_LEVEL9:String = "112120";
      
      public static const VIP_LEVEL10:String = "112204";
      
      public static const VIP_LEVEL11:String = "112205";
      
      public static const VIP_LEVEL12:String = "112206";
      
      public static var _vipChestsArr:Array = ["112112","112113","112114","112115","112116","112117","112118","112119","112120","112204","112205","112206"];
      
      public static var millisecondsPerDays:int = 86400000;
       
      
      private var _currentVip:Bitmap;
      
      private var _nextVip:Bitmap;
      
      private var _receiveBtn:BaseButton;
      
      private var _receiveShin:Scale9CornerImage;
      
      private var _openVipBtn:BaseButton;
      
      private var _BG:ScaleBitmapImage;
      
      private var _vipViewBg1:MutipleImage;
      
      private var _vipViewBg2:MutipleImage;
      
      private var _vipSp:Disposeable;
      
      private var _vipFrame:VipFrame;
      
      private var _head:VipFrameHead;
      
      private var _vipInfoTipBox:VipInfoTipBox;
      
      private var alertFrame:BaseAlerFrame;
      
      private var awards:AwardsViewII;
      
      private var LeftRechargeAlerTxt:VipPrivilegeTxt;
      
      private var RightRechargeAlerTxt:VipPrivilegeTxt;
      
      private var _text:FilterFrameText;
      
      private var _Pattern:Bitmap;
      
      private var _Pattern1:Bitmap;
      
      public function VipViewFrame(){super();}
      
      public static function get instance() : VipViewFrame{return null;}
      
      private function _init() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __openVipHandler(param1:MouseEvent) : void{}
      
      private function __receive(param1:MouseEvent) : void{}
      
      private function __alertHandler(param1:FrameEvent) : void{}
      
      private function __responseVipInfoTipHandler(param1:FrameEvent) : void{}
      
      private function showAwards(param1:ItemTemplateInfo) : void{}
      
      private function __sendReward(param1:Event) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function _getStrArr(param1:DictionaryData) : Array{return null;}
      
      private function getVIPInfoTip(param1:DictionaryData) : Array{return null;}
      
      private function receiveBtnCanUse() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      override public function dispose() : void{}
   }
}
