package signActivity.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import signActivity.SignActivityMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class SignActivityFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _day:int;
      
      private var _giftbagArray:Array;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _helpTxt:FilterFrameText;
      
      private var _itemList:Vector.<SignActivityItem>;
      
      private var actId:String;
      
      private var _xmlData:GmActivityInfo;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusArr:Array;
      
      public function SignActivityFrame($day:int)
      {
         super();
         _day = $day;
         initView();
         initEvent();
         initData();
         initGoods();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.signactivity.day" + _day);
         addToContent(_bg);
         _activeTimeTxt = ComponentFactory.Instance.creatComponentByStylename("signActivityFrame.activeTimeTxt");
         _activeTimeTxt.text = LanguageMgr.GetTranslation("signActivityFrame.activeTimeTxt",SignActivityMgr.instance.model.beginTime,SignActivityMgr.instance.model.endTime);
         addToContent(_activeTimeTxt);
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("signActivityFrame.helpTxt");
         _helpTxt.text = LanguageMgr.GetTranslation("signActivityFrame.helpTxt");
         addToContent(_helpTxt);
         _giftbagArray = SignActivityMgr.instance.model.giftbagArray;
      }
      
      private function initData() : void
      {
         _itemList = new Vector.<SignActivityItem>();
         actId = SignActivityMgr.instance.model.actId;
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
         for(i = 0; i < _giftbagArray.length; )
         {
            moneyValue = _giftbagArray[i].giftConditionArr[0].conditionValue;
            item = ComponentFactory.Instance.creatCustomObject("SignActivityFrame.SignActivityItem",[_day,moneyValue]);
            item.setGoods(arr[i]);
            _itemList.push(item);
            addToContent(item);
            i++;
         }
         refresh();
      }
      
      public function refresh() : void
      {
         var i:int = 0;
         for(i = 0; i <= _itemList.length - 1; )
         {
            (_itemList[i] as SignActivityItem).setStatus(_statusArr,_giftInfoDic,i);
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
         SignActivityItem.length = 1;
         SignActivityItem.btnIndex = 1;
         SignActivityItem.btnBigIndex = 1;
         SignActivityItem.continuousGoodsIndex = 1;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
