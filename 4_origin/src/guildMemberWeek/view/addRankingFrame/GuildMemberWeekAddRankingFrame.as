package guildMemberWeek.view.addRankingFrame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import guildMemberWeek.items.AddRankingWorkItem;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   
   public class GuildMemberWeekAddRankingFrame extends BaseAlerFrame
   {
       
      
      private var _PlayerPointBookText:FilterFrameText;
      
      private var _DeductTaxExplainText:FilterFrameText;
      
      private var _BG:ScaleFrameImage;
      
      private var _DeductTaxExplainBG:ScaleFrameImage;
      
      private var _PlayerHavePointBG:ScaleFrameImage;
      
      private var _RankingText:FilterFrameText;
      
      private var _PutInPointBookExplainText:FilterFrameText;
      
      private var _GetPointBookExplainText:FilterFrameText;
      
      private var _YesBtn:TextButton;
      
      private var _NoBtn:TextButton;
      
      private var _itemList:Vector.<AddRankingWorkItem>;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      public function GuildMemberWeekAddRankingFrame()
      {
         super();
         initView();
         initEvent();
         initText();
      }
      
      public function get itemList() : Vector.<AddRankingWorkItem>
      {
         return _itemList;
      }
      
      public function set itemList(param1:Vector.<AddRankingWorkItem>) : void
      {
         this._itemList = param1;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.AddRankingGiftLabel");
         _BG = ComponentFactory.Instance.creat("asset.guildmemberweek.AddRankingFrameBG");
         _DeductTaxExplainBG = ComponentFactory.Instance.creat("asset.guildmemberweek.AddRankingFrameExplainBG");
         _PlayerHavePointBG = ComponentFactory.Instance.creat("asset.guildmemberweek.AddRankingFramePlayerPoint");
         _YesBtn = ComponentFactory.Instance.creat("ddtstore.HelpFrame.EnterBtn");
         _YesBtn.text = LanguageMgr.GetTranslation("ok");
         _YesBtn.x = 50;
         _YesBtn.y = 300;
         _NoBtn = ComponentFactory.Instance.creat("ddtstore.HelpFrame.EnterBtn");
         _NoBtn.text = LanguageMgr.GetTranslation("cancel");
         _NoBtn.x = 270;
         _NoBtn.y = 300;
         _PlayerPointBookText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.PlayerPointBookTxt");
         _DeductTaxExplainText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.DeductTaxExplainTxt");
         _PutInPointBookExplainText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.PutInPointBookExplainLabelTxt");
         _GetPointBookExplainText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.GetPointBookExplainLabelTxt");
         _RankingText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.RankingLabelTxt");
         addToContent(_BG);
         addToContent(_DeductTaxExplainBG);
         addToContent(_PlayerHavePointBG);
         addToContent(_YesBtn);
         addToContent(_NoBtn);
         addToContent(_PlayerPointBookText);
         addToContent(_DeductTaxExplainText);
         addToContent(_RankingText);
         addToContent(_PutInPointBookExplainText);
         addToContent(_GetPointBookExplainText);
         _list = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingListBox");
         _itemList = new Vector.<AddRankingWorkItem>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("guildmemberweek.addRanking.AddRankingWorkItem");
            _loc1_.initView(_loc2_ + 1);
            itemList.push(_loc1_);
            _list.addChild(itemList[_loc2_]);
            _loc2_++;
         }
         _panel = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.panel");
         _panel.setView(_list);
         addToContent(_panel);
         _panel.invalidateViewport();
      }
      
      private function initText() : void
      {
         ChangePlayerMoneyShow(PlayerManager.Instance.Self.Money);
         _RankingText.text = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.RankingLabel");
         _DeductTaxExplainText.text = LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.DeductTaxExplain");
         _PutInPointBookExplainText.text = LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.PutInPointBookExplainLabel");
         _GetPointBookExplainText.text = LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.GetPointBookExplainLabel");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _NoBtn.addEventListener("click",__CancelHandler);
         _YesBtn.addEventListener("click",__OkHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _NoBtn.removeEventListener("click",__CancelHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            CancelThis();
         }
      }
      
      private function __CancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CancelThis();
      }
      
      private function CancelThis() : void
      {
         SoundManager.instance.play("008");
         GuildMemberWeekManager.instance.CloseAddRankingFrame();
      }
      
      private function __OkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.DutyLevel > 3 || !GuildMemberWeekManager.instance.model.CanAddPointBook)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.CantNotAddPointBook"));
            return;
         }
         var _loc4_:int = 0;
         var _loc2_:int = _itemList.length;
         var _loc3_:Array = [];
         _loc4_;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(itemList[_loc4_].AddMoney);
            _loc4_++;
         }
         GuildMemberWeekManager.instance.model.PlayerAddPointBook = _loc3_.concat();
         GuildMemberWeekManager.instance.Controller.CheckAddBookIsOK();
      }
      
      public function ChangePointBookShow(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 - 1;
         itemList[_loc3_].ChangeGetPointBook(param2);
      }
      
      public function ChangePlayerMoneyShow(param1:Number) : void
      {
         _PlayerPointBookText.text = String(param1);
      }
      
      private function disposeItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(itemList)
         {
            _loc2_ = 0;
            _loc1_ = itemList.length;
            _loc2_;
            while(_loc2_ < _loc1_)
            {
               ObjectUtils.disposeObject(itemList[_loc2_]);
               itemList[_loc2_] = null;
               _loc2_++;
            }
            itemList = null;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         disposeItems();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeAllChildren(_panel);
         ObjectUtils.disposeAllChildren(_list);
         ObjectUtils.disposeObject(_list);
         _list = null;
         super.dispose();
         _BG = null;
         _DeductTaxExplainBG = null;
         _PlayerHavePointBG = null;
         _panel = null;
         _YesBtn = null;
         _NoBtn = null;
         _PlayerPointBookText = null;
         _DeductTaxExplainText = null;
         _RankingText = null;
         _PutInPointBookExplainText = null;
         _GetPointBookExplainText = null;
      }
   }
}
