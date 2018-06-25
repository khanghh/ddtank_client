package guildMemberWeek.view.addRankingFrame{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;   import guildMemberWeek.items.AddRankingWorkItem;   import guildMemberWeek.manager.GuildMemberWeekManager;      public class GuildMemberWeekAddRankingFrame extends BaseAlerFrame   {                   private var _PlayerPointBookText:FilterFrameText;            private var _DeductTaxExplainText:FilterFrameText;            private var _BG:ScaleFrameImage;            private var _DeductTaxExplainBG:ScaleFrameImage;            private var _PlayerHavePointBG:ScaleFrameImage;            private var _RankingText:FilterFrameText;            private var _PutInPointBookExplainText:FilterFrameText;            private var _GetPointBookExplainText:FilterFrameText;            private var _YesBtn:TextButton;            private var _NoBtn:TextButton;            private var _itemList:Vector.<AddRankingWorkItem>;            private var _list:VBox;            private var _panel:ScrollPanel;            public function GuildMemberWeekAddRankingFrame() { super(); }
            public function get itemList() : Vector.<AddRankingWorkItem> { return null; }
            public function set itemList(Message:Vector.<AddRankingWorkItem>) : void { }
            private function initView() : void { }
            private function initText() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            private function __CancelHandler(event:MouseEvent) : void { }
            private function CancelThis() : void { }
            private function __OkHandler(event:MouseEvent) : void { }
            public function ChangePointBookShow(ItemID:int, Money:int) : void { }
            public function ChangePlayerMoneyShow(Money:Number) : void { }
            private function disposeItems() : void { }
            override public function dispose() : void { }
   }}