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
         var i:int = 0;
         var item:* = null;
         var moneyValue:int = 0;
         if(!_xmlData)
         {
            return;
         }
         var arr:Array = _xmlData.giftbagArray;
         for(i = 0; i < 3; )
         {
            moneyValue = _giftbagArray[i].giftConditionArr[0].conditionValue;
            item = ComponentFactory.Instance.creatCustomObject("RoleRechargeFrame.RoleRechargeItem",[moneyValue,i]);
            item.setGoods(arr[i]);
            _itemList.push(item);
            _list.addChild(item);
            i++;
         }
         _panel.setView(_list);
         _panel.invalidateViewport();
         refresh();
      }
      
      public function refresh() : void
      {
         var i:int = 0;
         for(i = 0; i <= _itemList.length - 1; )
         {
            (_itemList[i] as RoleRechargeItem).setStatus(_statusArr,_giftInfoDic);
            i++;
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
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
