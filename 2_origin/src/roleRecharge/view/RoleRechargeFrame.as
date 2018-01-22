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
      
      public function RoleRechargeFrame()
      {
         super();
         initView();
         initEvent();
         initData();
         initGoods();
      }
      
      private function initView() : void
      {
         _Bg = ComponentFactory.Instance.creatBitmap("roleRecharge.bg");
         _activeTimeTxt = ComponentFactory.Instance.creatComponentByStylename("RoleRechargeFrame.activeTimeTxt");
         _activeTimeTxt.text = RoleRechargeMgr.instance.model.beginTime + " -- " + RoleRechargeMgr.instance.model.endTime;
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("RoleRechargeFrame.promptTxt");
         _promptTxt.text = LanguageMgr.GetTranslation("RoleRechargeFrame.promptTxtL");
         addToContent(_Bg);
         addToContent(_activeTimeTxt);
         addToContent(_promptTxt);
         _giftbagArray = RoleRechargeMgr.instance.model.giftbagArray;
         _list = ComponentFactory.Instance.creatComponentByStylename("RoleRechargeFrame.GiftBagArrayContainer");
         _panel = ComponentFactory.Instance.creatComponentByStylename("RoleRechargeFrame.scrollpanel");
         _panel.width = 545;
         _panel.height = 260;
         addToContent(_panel);
      }
      
      private function initData() : void
      {
         _itemList = new Vector.<RoleRechargeItem>();
         actId = RoleRechargeMgr.instance.model.actId;
         _xmlData = WonderfulActivityManager.Instance.getActivityDataById(actId);
         _giftInfoDic = WonderfulActivityManager.Instance.getActivityInitDataById(actId).giftInfoDic;
         _statusArr = WonderfulActivityManager.Instance.getActivityInitDataById(actId).statusArr;
      }
      
      private function initGoods() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(!_xmlData)
         {
            return;
         }
         var _loc1_:Array = _xmlData.giftbagArray;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc3_ = _giftbagArray[_loc4_].giftConditionArr[0].conditionValue;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("RoleRechargeFrame.RoleRechargeItem",[_loc3_,_loc4_]);
            _loc2_.setGoods(_loc1_[_loc4_]);
            _itemList.push(_loc2_);
            _list.addChild(_loc2_);
            _loc4_++;
         }
         _panel.setView(_list);
         _panel.invalidateViewport();
         refresh();
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ <= _itemList.length - 1)
         {
            (_itemList[_loc1_] as RoleRechargeItem).setStatus(_statusArr,_giftInfoDic);
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            SocketManager.Instance.out.requestWonderfulActInit(2);
            WonderfulActivityManager.Instance.refreshIconStatus();
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
