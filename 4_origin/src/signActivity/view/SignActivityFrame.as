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
      
      public function SignActivityFrame(param1:int)
      {
         super();
         _day = param1;
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
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(!_xmlData)
         {
            return;
         }
         var _loc1_:Array = _xmlData.giftbagArray;
         _loc4_ = 0;
         while(_loc4_ < _giftbagArray.length)
         {
            _loc3_ = _giftbagArray[_loc4_].giftConditionArr[0].conditionValue;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("SignActivityFrame.SignActivityItem",[_day,_loc3_]);
            _loc2_.setGoods(_loc1_[_loc4_]);
            _itemList.push(_loc2_);
            addToContent(_loc2_);
            _loc4_++;
         }
         refresh();
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ <= _itemList.length - 1)
         {
            (_itemList[_loc1_] as SignActivityItem).setStatus(_statusArr,_giftInfoDic,_loc1_);
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
         SignActivityItem.length = 1;
         SignActivityItem.btnIndex = 1;
         SignActivityItem.btnBigIndex = 1;
         SignActivityItem.continuousGoodsIndex = 1;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
