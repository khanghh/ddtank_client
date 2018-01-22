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
      
      protected function __onUpdateView(param1:Event) : void
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
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc3_:GmActivityInfo = RechargeRankManager.instance.xmlData;
         var _loc6_:String = dateTrim(_loc3_.beginTime);
         var _loc5_:String = dateTrim(_loc3_.endTime);
         _dateTxt.text = _loc6_ + "-" + _loc5_;
         _checkBg.tipData = LanguageMgr.GetTranslation("rechargeRank.helpTxt",_loc3_.remain2);
         var _loc2_:Array = RechargeRankManager.instance.rankList;
         var _loc4_:int = RechargeRankManager.instance.myConsume;
         _myRank = -1;
         _loc8_ = 0;
         while(_loc8_ <= _loc2_.length - 1)
         {
            _loc7_ = _loc2_[_loc8_] as RechargeRankVo;
            if(_loc7_.userId == PlayerManager.Instance.Self.ID)
            {
               _myRank = _loc8_;
               break;
            }
            _loc8_++;
         }
         var _loc1_:int = 0;
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
               _loc1_ = (_loc2_[_myRank - 1] as RechargeRankVo).consume - _loc4_ + 1;
               _rankLabelTxt.text = LanguageMgr.GetTranslation("rechargeRank.rankLabel",_loc1_);
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
            if(_loc2_.length > 0)
            {
               _loc1_ = (_loc2_[_loc2_.length - 1] as RechargeRankVo).consume - _loc4_ + 1;
            }
            else
            {
               _loc1_ = 1;
            }
            _outOfRankLabel.text = LanguageMgr.GetTranslation("rechargeRank.outOfRank");
            _rankLabelTxt.text = LanguageMgr.GetTranslation("rechargeRank.outOfRankLabel",_loc4_,_loc1_);
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
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Array = RechargeRankManager.instance.rankList;
         var _loc2_:Array = RechargeRankManager.instance.xmlData.giftbagArray;
         _vbox.removeAllChild();
         _loc4_ = 0;
         while(_loc4_ <= _loc1_.length - 1)
         {
            _loc3_ = new RechargeRankItem(_loc4_);
            _loc3_.setData(_loc1_[_loc4_],_loc2_[_loc4_]);
            _vbox.addChild(_loc3_);
            _loc4_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function dateTrim(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:Array = param1.split(" ");
         _loc2_ = _loc3_[0] + " " + _loc3_[1].slice(0,5);
         return _loc2_;
      }
      
      private function initTimer() : void
      {
         WonderfulActivityManager.Instance.addTimerFun("rechargeRank",consumeRankTimerHandler);
      }
      
      private function consumeRankTimerHandler() : void
      {
         var _loc3_:Date = DateUtils.getDateByStr(RechargeRankManager.instance.xmlData.endTime);
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc1_:Number = Math.round((_loc3_.getTime() - _loc2_.getTime()) / 1000);
         if(_loc1_ > 0)
         {
            refreshCount = Number(refreshCount) + 1;
            if(_loc1_ >= 3600)
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
      
      public function setState(param1:int, param2:int) : void
      {
      }
   }
}
