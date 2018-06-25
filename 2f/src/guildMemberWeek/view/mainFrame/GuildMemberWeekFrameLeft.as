package guildMemberWeek.view.mainFrame{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import guildMemberWeek.items.ShowGuildMemberDataItem;   import guildMemberWeek.manager.GuildMemberWeekManager;      public class GuildMemberWeekFrameLeft extends Sprite implements Disposeable   {                   private var _itemList:Vector.<ShowGuildMemberDataItem>;            private var _list:VBox;            public function GuildMemberWeekFrameLeft() { super(); }
            public function set itemList(value:Vector.<ShowGuildMemberDataItem>) : void { }
            public function get itemList() : Vector.<ShowGuildMemberDataItem> { return null; }
            private function initView() : void { }
            public function UpTop10data(UpType:String) : void { }
            private function disposeItems() : void { }
            public function dispose() : void { }
   }}