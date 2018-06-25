package wonderfulActivity.newActivity.returnActivity
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import road7th.utils.DateUtils;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.views.IRightView;
   
   public class ReturnActivityView extends Sprite implements IRightView
   {
       
      
      private var _goldLine:Bitmap;
      
      private var _tittle:Bitmap;
      
      private var _goldStone:Bitmap;
      
      private var _back:Bitmap;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _downBack:Bitmap;
      
      private var _limitTime:Bitmap;
      
      private var _downTxt:FilterFrameText;
      
      private var _timerTxt:FilterFrameText;
      
      private var _helpIcon:ScaleBitmapImage;
      
      private var _rightItemList:Vector.<ReturnListItem>;
      
      private var _type:int;
      
      private var actId:String;
      
      private var nowDate:Date;
      
      private var endDate:Date;
      
      private var _xmlData:GmActivityInfo;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusArr:Array;
      
      private var _canSelect:Boolean;
      
      public function ReturnActivityView(type:int, actId:String)
      {
         _type = type;
         this.actId = actId;
         super();
      }
      
      public function init() : void
      {
         initData();
         initView();
         initTimer();
      }
      
      private function initData() : void
      {
         _rightItemList = new Vector.<ReturnListItem>();
         _xmlData = WonderfulActivityManager.Instance.getActivityDataById(actId);
         _giftInfoDic = WonderfulActivityManager.Instance.getActivityInitDataById(actId).giftInfoDic;
         _statusArr = WonderfulActivityManager.Instance.getActivityInitDataById(actId).statusArr;
      }
      
      private function initView() : void
      {
         _goldLine = ComponentFactory.Instance.creat("wonderfulactivity.libao.goldLine");
         addChild(_goldLine);
         if(_xmlData)
         {
            _canSelect = checkReward(_xmlData.giftbagArray);
         }
         if(_canSelect)
         {
            _back = ComponentFactory.Instance.creat("wonderfulactivity.fame.back");
         }
         else
         {
            _back = ComponentFactory.Instance.creat("wonderfulactivity.fame.back2");
         }
         addChild(_back);
         _goldStone = ComponentFactory.Instance.creat("wonderfulactivity.libao.gold");
         addChild(_goldStone);
         _downBack = ComponentFactory.Instance.creat("wonderfulactivity.right.back");
         addChild(_downBack);
         _downTxt = ComponentFactory.Instance.creat("wonderfulactivity.right.desTxt");
         addChild(_downTxt);
         switch(int(_type))
         {
            case 0:
               _tittle = ComponentFactory.Instance.creat("wonderfulactivity.rechargeTille1");
               _downTxt.text = LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt7",_statusArr[0].statusValue);
               break;
            case 1:
               _helpIcon = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.helpImg");
               _helpIcon.tipData = LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt8_tip");
               addChild(_helpIcon);
               _tittle = ComponentFactory.Instance.creat("wonderfulactivity.rechargeTille2");
               _downTxt.text = LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt8",_statusArr[0].statusValue);
               break;
            case 2:
               _tittle = ComponentFactory.Instance.creat("wonderfulactivity.oneOffPayTitle");
               break;
            case 3:
               _helpIcon = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.helpImg");
               _helpIcon.tipData = LanguageMgr.GetTranslation("wonderfulActivity.oneOffInTimeTip");
               addChild(_helpIcon);
               _tittle = ComponentFactory.Instance.creat("wonderfulactivity.oneOffInTimeTitle");
         }
         addChild(_tittle);
         _limitTime = ComponentFactory.Instance.creat("wonderfulactivity.limit");
         addChild(_limitTime);
         _timerTxt = ComponentFactory.Instance.creat("wonderfulactivity.right.timeTxt");
         addChild(_timerTxt);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.left.vBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.scrollpanel");
         _scrollPanel.setView(_vbox);
         addChild(_scrollPanel);
         initItem();
      }
      
      private function initItem() : void
      {
         var i:int = 0;
         var item:* = null;
         if(!_xmlData)
         {
            return;
         }
         var arr:Array = _xmlData.giftbagArray;
         for(i = 0; i <= arr.length - 1; )
         {
            item = new ReturnListItem(_type,i % 2,actId);
            item.setData(_xmlData.desc,arr[i],_canSelect);
            _rightItemList.push(item);
            _vbox.addChild(item);
            i++;
         }
         _scrollPanel.invalidateViewport();
         refresh();
      }
      
      private function checkReward(giftBagArr:Array) : Boolean
      {
         var _loc7_:int = 0;
         var _loc6_:* = giftBagArr;
         for each(var giftInfo in giftBagArr)
         {
            var _loc5_:int = 0;
            var _loc4_:* = giftInfo.giftRewardArr;
            for each(var info in giftInfo.giftRewardArr)
            {
               if(info.rewardType != 0)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function refresh() : void
      {
         var i:int = 0;
         for(i = 0; i <= _rightItemList.length - 1; )
         {
            (_rightItemList[i] as ReturnListItem).setStatus(_statusArr,_giftInfoDic);
            i++;
         }
      }
      
      private function initTimer() : void
      {
         if(!_xmlData)
         {
            return;
         }
         endDate = DateUtils.getDateByStr(_xmlData.endTime);
         returnTimerHander();
         WonderfulActivityManager.Instance.addTimerFun("returnActivity",returnTimerHander);
      }
      
      private function returnTimerHander() : void
      {
         nowDate = TimeManager.Instance.Now();
         var str:String = WonderfulActivityManager.Instance.getTimeDiff(endDate,nowDate);
         if(_timerTxt)
         {
            _timerTxt.text = str;
         }
         if(str == "0")
         {
            dispose();
            WonderfulActivityManager.Instance.delTimerFun("returnActivity");
            WonderfulActivityManager.Instance.currView = "-1";
         }
      }
      
      public function dispose() : void
      {
         WonderfulActivityManager.Instance.delTimerFun("returnActivity");
         ObjectUtils.disposeObject(_goldLine);
         _goldLine = null;
         ObjectUtils.disposeObject(_tittle);
         _tittle = null;
         ObjectUtils.disposeObject(_goldStone);
         _goldStone = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_downBack);
         _downBack = null;
         ObjectUtils.disposeObject(_limitTime);
         _limitTime = null;
         ObjectUtils.disposeObject(_downTxt);
         _downTxt = null;
         ObjectUtils.disposeObject(_timerTxt);
         _timerTxt = null;
         ObjectUtils.disposeObject(_helpIcon);
         _helpIcon = null;
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(type:int, id:int) : void
      {
      }
      
      public function updateAwardState() : void
      {
         _giftInfoDic = WonderfulActivityManager.Instance.getActivityInitDataById(actId).giftInfoDic;
         _statusArr = WonderfulActivityManager.Instance.getActivityInitDataById(actId).statusArr;
         refresh();
      }
   }
}
