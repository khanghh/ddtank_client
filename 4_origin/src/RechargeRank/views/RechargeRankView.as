package RechargeRank.views
{
   import RechargeRank.RechargeRankManager;
   import RechargeRank.data.RechargeRankVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import road7th.utils.DateUtils;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.views.IRightView;
   
   public class RechargeRankView extends Sprite implements IRightView
   {
       
      
      private var _bg:Bitmap;
      
      private var _dateTxt:FilterFrameText;
      
      private var _checkTxt:FilterFrameText;
      
      private var _checkBg:ScaleBitmapImage;
      
      private var _outOfRankLabel:FilterFrameText;
      
      private var _myRankLabel:FilterFrameText;
      
      private var _rankLabelTxt:FilterFrameText;
      
      private var _rankTxtBg:Scale9CornerImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _myRank:int;
      
      private var refreshCount:int = 0;
      
      public function RechargeRankView()
      {
         super();
      }
      
      public function init() : void
      {
         initView();
         updateView();
         initTimer();
         initEvent();
      }
      
      private function initEvent() : void
      {
         RechargeRankManager.instance.addEventListener("rechargeUpdateView",__onUpdateView);
      }
      
      protected function __onUpdateView(event:Event) : void
      {
         updateView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("wonderfulactivity.rechargeRank.bg");
         addChild(_bg);
         _dateTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.dateTxt");
         addChild(_dateTxt);
         _checkBg = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.checkBg");
         addChild(_checkBg);
         _checkBg.tipStyle = "ddt.view.tips.OneLineTip";
         _checkBg.tipDirctions = "0";
         _checkTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.checkTxt");
         addChild(_checkTxt);
         _checkTxt.text = LanguageMgr.GetTranslation("rechargeRank.checkConsume");
         _outOfRankLabel = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.labelTxt");
         addChild(_outOfRankLabel);
         _outOfRankLabel.text = LanguageMgr.GetTranslation("rechargeRank.outOfRankLabel",100,6000);
         _outOfRankLabel.visible = false;
         _myRankLabel = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.myRankLabel");
         addChild(_myRankLabel);
         _myRankLabel.text = LanguageMgr.GetTranslation("rechargeRank.myRank");
         _rankLabelTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.labelTxt2");
         addChild(_rankLabelTxt);
         _rankLabelTxt.text = LanguageMgr.GetTranslation("rechargeRank.rankLabel",5000);
         _rankTxtBg = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.rankBg");
         addChild(_rankTxtBg);
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.rankTxt");
         addChild(_rankTxt);
         _rankTxt.text = "20";
         _vbox = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.vBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.scrollpanel");
         _scrollPanel.setView(_vbox);
         addChild(_scrollPanel);
      }
      
      public function updateView() : void
      {
         var i:int = 0;
         var vo:* = null;
         var xmlData:GmActivityInfo = RechargeRankManager.instance.xmlData;
         var beginDate:String = dateTrim(xmlData.beginTime);
         var endDate:String = dateTrim(xmlData.endTime);
         _dateTxt.text = beginDate + "-" + endDate;
         _checkBg.tipData = LanguageMgr.GetTranslation("rechargeRank.helpTxt",xmlData.remain2);
         var arr:Array = RechargeRankManager.instance.rankList;
         var myConsume:int = RechargeRankManager.instance.myConsume;
         _myRank = -1;
         for(i = 0; i <= arr.length - 1; )
         {
            vo = arr[i] as RechargeRankVo;
            if(vo.userId == PlayerManager.Instance.Self.ID)
            {
               _myRank = i;
               break;
            }
            i++;
         }
         var remain:int = 0;
         if(_myRank >= 0)
         {
            _outOfRankLabel.visible = false;
            _myRankLabel.visible = true;
            _rankTxtBg.visible = true;
            _rankTxt.visible = true;
            _rankTxt.text = String(_myRank + 1);
            if(_myRank == 0)
            {
               _rankLabelTxt.visible = false;
            }
            else
            {
               _rankLabelTxt.visible = true;
               remain = (arr[_myRank - 1] as RechargeRankVo).consume - myConsume + 1;
               _rankLabelTxt.text = LanguageMgr.GetTranslation("rechargeRank.rankLabel",remain);
            }
            if(RechargeRankManager.instance.status == 2)
            {
               _rankLabelTxt.visible = true;
               _rankLabelTxt.textColor = 16711680;
               _rankLabelTxt.text = LanguageMgr.GetTranslation("rechargeRank.over");
            }
         }
         else
         {
            _myRankLabel.visible = false;
            _rankTxtBg.visible = false;
            _rankTxt.visible = false;
            _rankLabelTxt.visible = true;
            _outOfRankLabel.visible = true;
            if(arr.length > 0)
            {
               remain = (arr[arr.length - 1] as RechargeRankVo).consume - myConsume + 1;
            }
            else
            {
               remain = 1;
            }
            _outOfRankLabel.text = LanguageMgr.GetTranslation("rechargeRank.outOfRank");
            _rankLabelTxt.text = LanguageMgr.GetTranslation("rechargeRank.outOfRankLabel",myConsume,remain);
            if(RechargeRankManager.instance.status == 2)
            {
               _rankLabelTxt.visible = true;
               _rankLabelTxt.textColor = 16711680;
               _rankLabelTxt.text = LanguageMgr.GetTranslation("rechargeRank.over");
            }
         }
         updateItems();
      }
      
      private function updateItems() : void
      {
         var i:int = 0;
         var item:* = null;
         var voArr:Array = RechargeRankManager.instance.rankList;
         var giftArr:Array = RechargeRankManager.instance.xmlData.giftbagArray;
         _vbox.removeAllChild();
         for(i = 0; i <= voArr.length - 1; )
         {
            item = new RechargeRankItem(i);
            item.setData(voArr[i],giftArr[i]);
            _vbox.addChild(item);
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function dateTrim(dateStr:String) : String
      {
         var str:String = "";
         var temp:Array = dateStr.split(" ");
         str = temp[0] + " " + temp[1].slice(0,5);
         return str;
      }
      
      private function initTimer() : void
      {
         WonderfulActivityManager.Instance.addTimerFun("rechargeRank",consumeRankTimerHandler);
      }
      
      private function consumeRankTimerHandler() : void
      {
         var endDate:Date = DateUtils.getDateByStr(RechargeRankManager.instance.xmlData.endTime);
         var nowDate:Date = TimeManager.Instance.Now();
         var diff:Number = Math.round((endDate.getTime() - nowDate.getTime()) / 1000);
         if(diff > 0)
         {
            refreshCount = Number(refreshCount) + 1;
            if(diff >= 3600)
            {
               if(refreshCount >= 300)
               {
                  refreshCount = 0;
                  SocketManager.Instance.out.updateRechargeRank();
               }
            }
            else if(refreshCount >= 30)
            {
               refreshCount = 0;
               SocketManager.Instance.out.updateRechargeRank();
            }
         }
         else
         {
            WonderfulActivityManager.Instance.delTimerFun("rechargeRank");
         }
      }
      
      public function dispose() : void
      {
         RechargeRankManager.instance.removeEventListener("rechargeUpdateView",__onUpdateView);
         WonderfulActivityManager.Instance.delTimerFun("rechargeRank");
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_dateTxt);
         _dateTxt = null;
         ObjectUtils.disposeObject(_checkTxt);
         _checkTxt = null;
         ObjectUtils.disposeObject(_checkBg);
         _checkBg = null;
         ObjectUtils.disposeObject(_outOfRankLabel);
         _outOfRankLabel = null;
         ObjectUtils.disposeObject(_rankLabelTxt);
         _rankLabelTxt = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_rankTxtBg);
         _rankTxtBg = null;
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(type:int, id:int) : void
      {
      }
   }
}
