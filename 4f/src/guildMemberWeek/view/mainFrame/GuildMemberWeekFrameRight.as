package guildMemberWeek.view.mainFrame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import guildMemberWeek.items.AddRankingRecordItem;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   
   public class GuildMemberWeekFrameRight extends Sprite implements Disposeable
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _list:VBox;
      
      private var _itemList:Vector.<AddRankingRecordItem>;
      
      public function GuildMemberWeekFrameRight(){super();}
      
      public function set itemList(param1:Vector.<AddRankingRecordItem>) : void{}
      
      public function get itemList() : Vector.<AddRankingRecordItem>{return null;}
      
      private function initView() : void{}
      
      public function ClearRecord() : void{}
      
      public function UpRecord() : void{}
      
      private function disposeItems() : void{}
      
      public function dispose() : void{}
   }
}
