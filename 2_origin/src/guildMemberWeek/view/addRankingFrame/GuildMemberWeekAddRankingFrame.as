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
      
      public function set itemList(Message:Vector.<AddRankingWorkItem>) : void
      {
         this._itemList = Message;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
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
         for(i = 0; i < 10; )
         {
            item = ComponentFactory.Instance.creatCustomObject("guildmemberweek.addRanking.AddRankingWorkItem");
            item.initView(i + 1);
            itemList.push(item);
            _list.addChild(itemList[i]);
            i++;
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
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            CancelThis();
         }
      }
      
      private function __CancelHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CancelThis();
      }
      
      private function CancelThis() : void
      {
         SoundManager.instance.play("008");
         GuildMemberWeekManager.instance.CloseAddRankingFrame();
      }
      
      private function __OkHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.DutyLevel > 3 || !GuildMemberWeekManager.instance.model.CanAddPointBook)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("guildMemberWeek.AddRankingFrame.CantNotAddPointBook"));
            return;
         }
         var i:int = 0;
         var L:int = _itemList.length;
         var TempVector:Array = [];
         i;
         while(i < L)
         {
            TempVector.push(itemList[i].AddMoney);
            i++;
         }
         GuildMemberWeekManager.instance.model.PlayerAddPointBook = TempVector.concat();
         GuildMemberWeekManager.instance.Controller.CheckAddBookIsOK();
      }
      
      public function ChangePointBookShow(ItemID:int, Money:int) : void
      {
         var i:int = ItemID - 1;
         itemList[i].ChangeGetPointBook(Money);
      }
      
      public function ChangePlayerMoneyShow(Money:Number) : void
      {
         _PlayerPointBookText.text = String(Money);
      }
      
      private function disposeItems() : void
      {
         var i:int = 0;
         var L:int = 0;
         if(itemList)
         {
            i = 0;
            L = itemList.length;
            i;
            while(i < L)
            {
               ObjectUtils.disposeObject(itemList[i]);
               itemList[i] = null;
               i++;
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
