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
      
      public function GuildMemberWeekFrameRight()
      {
         super();
         initView();
      }
      
      public function set itemList(value:Vector.<AddRankingRecordItem>) : void
      {
         this._itemList = value;
      }
      
      public function get itemList() : Vector.<AddRankingRecordItem>
      {
         return this._itemList;
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.RankingRecordListBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.MainFrameRight.scrollpanel");
         itemList = new Vector.<AddRankingRecordItem>();
         _panel.setView(_list);
         _panel.invalidateViewport();
         addChild(_panel);
      }
      
      public function ClearRecord() : void
      {
         disposeItems();
         itemList = new Vector.<AddRankingRecordItem>();
      }
      
      public function UpRecord() : void
      {
         var item:* = null;
         var L:int = GuildMemberWeekManager.instance.model.AddRanking.length;
         var i:int = itemList.length;
         i;
         while(i < L)
         {
            item = ComponentFactory.Instance.creatCustomObject("guildmemberweek.MainFrame.Right.AddRankingRecordItem");
            item.initText(GuildMemberWeekManager.instance.model.AddRanking[i]);
            itemList.push(item);
            _list.addChild(itemList[i]);
            i++;
         }
         _panel.invalidateViewport();
      }
      
      private function disposeItems() : void
      {
         var i:int = 0;
         if(itemList)
         {
            for(i = 0; i < itemList.length; )
            {
               ObjectUtils.disposeObject(itemList[i]);
               itemList[i] = null;
               i++;
            }
            itemList = null;
         }
      }
      
      public function dispose() : void
      {
         disposeItems();
         ObjectUtils.disposeAllChildren(_list);
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeAllChildren(_panel);
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
