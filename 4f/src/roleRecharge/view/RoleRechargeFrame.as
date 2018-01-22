package roleRecharge.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import roleRecharge.RoleRechargeMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class RoleRechargeFrame extends Frame
   {
       
      
      private var _Bg:Bitmap;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _giftbagArray:Array;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Vector.<RoleRechargeItem>;
      
      private var actId:String;
      
      private var _xmlData:GmActivityInfo;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusArr:Array;
      
      public function RoleRechargeFrame(){super();}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      private function initGoods() : void{}
      
      public function refresh() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
